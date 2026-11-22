import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../models/crew.dart';
import '../theme/app_spacing.dart';
import '../theme/text_styles.dart';

class CrewCodeSheet extends StatefulWidget {
  final Crew crew;
  final bool isNew;

  const CrewCodeSheet({super.key, required this.crew, required this.isNew});

  @override
  State<CrewCodeSheet> createState() => _CrewCodeSheetState();
}

class _CrewCodeSheetState extends State<CrewCodeSheet> {
  final _shareButton = GlobalKey();
  String? _status;

  void _showStatus(String message) {
    if (mounted) {
      setState(() => _status = message);
    }
  }

  Future<void> _copy(String text, String message) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      _showStatus(message);
    } catch (_) {
      _showStatus('Could not access the clipboard.');
    }
  }

  Future<void> _share(String code) async {
    final crew = widget.crew;
    final message = 'Places To Go · ${crew.name}\nCrew code: $code';
    final box = _shareButton.currentContext?.findRenderObject() as RenderBox?;
    final origin = box == null
        ? null
        : box.localToGlobal(Offset.zero) & box.size;

    try {
      final result = await SharePlus.instance.share(
        ShareParams(text: message, sharePositionOrigin: origin),
      );
      if (result.status != ShareResultStatus.unavailable) {
        return;
      }
    } catch (_) {
      // Use the clipboard on platforms without a working share sheet.
    }
    await _copy(message, 'Invite copied.');
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final code = widget.crew.code!;

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.large,
          0,
          AppSpacing.large,
          AppSpacing.medium,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CircleAvatar(
                radius: 23,
                backgroundColor: Color.alphaBlend(
                  colors.primary.withValues(alpha: 0.12),
                  colors.surface,
                ),
                foregroundColor: colors.primary,
                child: Icon(widget.isNew ? Icons.check : Icons.people_outline),
              ),
            ),
            const SizedBox(height: AppSpacing.small),
            Text(
              widget.isNew ? 'Your group is ready' : 'Invite your crew',
              textAlign: TextAlign.center,
              style: AppTextStyles.appTitle.copyWith(fontSize: 22),
            ),
            Text(
              widget.crew.name,
              textAlign: TextAlign.center,
              style: AppTextStyles.body,
            ),
            const SizedBox(height: AppSpacing.medium),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(AppSpacing.radius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.medium),
                child: Column(
                  children: [
                    Text(
                      'Group code',
                      style: AppTextStyles.label.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.small),
                    Semantics(
                      label: 'Group code ${code.split('').join(' ')}',
                      excludeSemantics: true,
                      child: Row(
                        children: [
                          for (final (index, digit)
                              in code.split('').indexed) ...[
                            if (index > 0)
                              const SizedBox(width: AppSpacing.small),
                            Expanded(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: colors.surface,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AppSpacing.small,
                                  ),
                                  child: Text(
                                    digit,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.appTitle.copyWith(
                                      fontSize: 23,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _copy(code, 'Code copied.'),
                    icon: const Icon(Icons.copy_outlined, size: 17),
                    label: const Text('Copy'),
                  ),
                ),
                const SizedBox(width: AppSpacing.small),
                Expanded(
                  child: FilledButton.icon(
                    key: _shareButton,
                    onPressed: () => _share(code),
                    icon: const Icon(Icons.ios_share, size: 17),
                    label: const Text('Share'),
                  ),
                ),
              ],
            ),
            if (_status case final status?)
              Semantics(
                liveRegion: true,
                child: Text(
                  status,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.small,
                ),
              ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
