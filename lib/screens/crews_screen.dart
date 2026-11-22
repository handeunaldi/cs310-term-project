import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/crew.dart';
import '../models/crew_store.dart';
import '../theme/app_spacing.dart';
import '../theme/text_styles.dart';
import '../widgets/crew_code_sheet.dart';
import '../widgets/crew_list_tile.dart';

class CrewsScreen extends StatefulWidget {
  final CrewStore store;
  final int? initialSpotCount;

  const CrewsScreen({super.key, required this.store, this.initialSpotCount});

  @override
  State<CrewsScreen> createState() => _CrewsScreenState();
}

class _CrewsScreenState extends State<CrewsScreen> {
  bool _composing = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialSpotCount != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _newCrew(spots: widget.initialSpotCount!);
        }
      });
    }
  }

  Future<void> _newCrew({int spots = 0}) async {
    if (_composing) {
      return;
    }

    _composing = true;
    try {
      final name = await showDialog<String>(
        context: context,
        builder: (_) => _CrewNameDialog(store: widget.store),
      );
      if (name == null || !mounted) {
        return;
      }

      final crew = await widget.store.add(name, spots: spots);
      if (mounted) {
        await _showCode(crew, isNew: true);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not save your crew. Please try again.'),
          ),
        );
      }
    } finally {
      _composing = false;
    }
  }

  Future<void> _showCode(Crew crew, {bool isNew = false}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => CrewCodeSheet(crew: crew, isNew: isNew),
    );
  }

  Future<void> _joinCrew() async {
    final joined = await showDialog<bool>(
      context: context,
      builder: (_) => _JoinCrewDialog(store: widget.store),
    );
    if (joined == true && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('You joined the crew.')));
    }
  }

  Future<void> _openCrew(Crew crew) {
    if (crew.code != null) {
      return _showCode(crew);
    }
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(crew.name),
        content: Text(crew.summary),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crews')),
      body: SafeArea(
        top: false,
        child: ValueListenableBuilder(
          valueListenable: widget.store,
          builder: (context, crews, child) => ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.large),
            itemCount: crews.length + 2,
            separatorBuilder: (_, index) =>
                const SizedBox(height: AppSpacing.small),
            itemBuilder: (context, index) {
              if (index == 0) {
                return OutlinedButton.icon(
                  onPressed: _newCrew,
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Create crew'),
                );
              }
              if (index == 1) {
                return OutlinedButton.icon(
                  onPressed: _joinCrew,
                  icon: const Icon(Icons.group_add_outlined),
                  label: const Text('Join crew'),
                );
              }
              final crewIndex = index - 2;
              final crew = crews[crewIndex];
              return CrewListTile(
                crew: crew,
                index: crewIndex,
                trailingIcon: Icons.more_horiz,
                onTap: () => _openCrew(crew),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _JoinCrewDialog extends StatefulWidget {
  final CrewStore store;

  const _JoinCrewDialog({required this.store});

  @override
  State<_JoinCrewDialog> createState() => _JoinCrewDialogState();
}

class _JoinCrewDialogState extends State<_JoinCrewDialog> {
  String _code = '';
  String? _error;
  bool _joining = false;

  Future<void> _submit() async {
    if (_joining) return;
    if (_code.length != 5) {
      setState(() => _error = 'Enter the five-digit crew code.');
      return;
    }

    setState(() {
      _joining = true;
      _error = null;
    });
    String? error;
    try {
      final result = await widget.store.join(_code);
      error = switch (result) {
        JoinCrewResult.joined => null,
        JoinCrewResult.alreadyMember => 'You are already in this crew.',
        JoinCrewResult.codeNotFound => 'No crew found for this code.',
      };
      if (error == null) {
        if (mounted) Navigator.pop(context, true);
        return;
      }
    } catch (_) {
      error = 'Could not join the crew. Please try again.';
    }
    if (mounted) {
      setState(() {
        _joining = false;
        _error = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_joining,
      child: AlertDialog(
        scrollable: true,
        title: const Text('Join a crew'),
        content: TextField(
          autofocus: true,
          enabled: !_joining,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(5),
          ],
          decoration: InputDecoration(
            labelText: 'Crew code',
            helperText: 'Demo code: ${CrewStore.demoInviteCode}',
            errorText: _error,
            border: const OutlineInputBorder(),
          ),
          onChanged: (code) {
            _code = code;
            if (_error != null) setState(() => _error = null);
          },
          onSubmitted: (_) => _submit(),
        ),
        actions: [
          TextButton(
            onPressed: _joining ? null : () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: _joining ? null : _submit,
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }
}

class _CrewNameDialog extends StatefulWidget {
  final CrewStore store;

  const _CrewNameDialog({required this.store});

  @override
  State<_CrewNameDialog> createState() => _CrewNameDialogState();
}

class _CrewNameDialogState extends State<_CrewNameDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, _nameController.text.trim());
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Name your crew'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _nameController,
          autofocus: true,
          maxLength: 40,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _submit(),
          style: AppTextStyles.body,
          decoration: const InputDecoration(
            labelText: 'Crew name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            final name = value?.trim() ?? '';
            if (name.isEmpty) {
              return 'Enter a crew name.';
            }
            if (widget.store.hasName(name)) {
              return 'You already have a crew with this name.';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Get code')),
      ],
    );
  }
}
