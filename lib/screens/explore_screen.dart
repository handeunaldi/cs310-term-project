import 'package:flutter/material.dart';

import '../models/demo_profile.dart';
import '../models/demo_profiles.dart';
import '../models/place.dart';
import '../theme/app_spacing.dart';
import '../theme/text_styles.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/place_photo.dart';
import 'profile_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _searchController = TextEditingController();
  bool _searching = false;

  String _searchKey(String text) {
    const letters = {
      'ç': 'c',
      'ğ': 'g',
      'ı': 'i',
      'ö': 'o',
      'ş': 's',
      'ü': 'u',
    };
    return text.trim().toLowerCase().replaceAllMapped(
      RegExp('[çğıöşü\u0307]'),
      (match) => letters[match[0]] ?? '',
    );
  }

  void _closeSearch() {
    FocusScope.of(context).unfocus();
    _searchController.clear();
    setState(() => _searching = false);
  }

  void _openProfile(DemoProfile profile) {
    FocusScope.of(context).unfocus();
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => ProfileScreen(profile: profile)),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final query = _searchKey(_searchController.text)
        .replaceFirst(RegExp(r'^@'), '');
    final matches = demoProfiles.where((profile) {
      return _searchKey(profile.name).contains(query) ||
          profile.username.contains(query);
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.medium,
            AppSpacing.medium,
            AppSpacing.medium,
            0,
          ),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onTap: () => setState(() => _searching = true),
                onChanged: (_) => setState(() => _searching = true),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search profile',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searching
                      ? IconButton(
                          tooltip: 'Close search',
                          onPressed: _closeSearch,
                          icon: const Icon(Icons.close),
                        )
                      : null,
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radius),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.medium),
              Expanded(
                child: _searching
                    ? _ProfileResults(
                        profiles: matches,
                        onProfileTap: _openProfile,
                      )
                    : ListView(
                        children: [
                          Text(
                            "Where's the crew heading next?",
                            style: AppTextStyles.appTitle,
                          ),
                          const SizedBox(height: AppSpacing.medium),
                          Card(
                            color: Theme.of(context).cardColor,
                            margin: EdgeInsets.zero,
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.medium),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Plan with your crew',
                                          style: AppTextStyles.label,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Swipe together, decide together.',
                                          style: AppTextStyles.small.copyWith(
                                            color: colors.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.small),
                                  FilledButton(
                                    onPressed: () =>
                                        Navigator.pushNamed(context, '/crews'),
                                    child: const Text('See crews'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.large),
                          const Text(
                            'Saved by others',
                            style: AppTextStyles.label,
                          ),
                          const SizedBox(height: AppSpacing.small),
                          _SavedSpots(onProfileTap: _openProfile),
                          const SizedBox(height: AppSpacing.small),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const SafeArea(
        top: false,
        child: AppBottomNav(currentIndex: 0),
      ),
    );
  }
}

class _ProfileResults extends StatelessWidget {
  final List<DemoProfile> profiles;
  final ValueChanged<DemoProfile> onProfileTap;

  const _ProfileResults({required this.profiles, required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        const Text('Demo profiles', style: AppTextStyles.label),
        const SizedBox(height: AppSpacing.small),
        if (profiles.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.medium),
            child: Text('No profiles found.'),
          ),
        for (final profile in profiles)
          Card(
            margin: const EdgeInsets.only(bottom: AppSpacing.small),
            elevation: 0,
            color: Theme.of(context).cardColor,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(profile.avatarColor),
                foregroundColor: Colors.white,
                child: Text(profile.initials),
              ),
              title: Text(profile.name, style: AppTextStyles.label),
              subtitle: Text(
                '@${profile.username}',
                style: AppTextStyles.small,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => onProfileTap(profile),
            ),
          ),
      ],
    );
  }
}

class _SavedSpots extends StatelessWidget {
  final ValueChanged<DemoProfile> onProfileTap;

  const _SavedSpots({required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    final mostSavedSpots = demoProfiles.fold<int>(
      0,
      (count, profile) =>
          profile.savedSpots.length > count ? profile.savedSpots.length : count,
    );
    final spots = [
      for (var index = 0; index < mostSavedSpots; index++)
        for (final profile in demoProfiles)
          if (index < profile.savedSpots.length)
            (profile: profile, place: profile.savedSpots[index]),
    ];

    if (spots.isEmpty) {
      return const Text('No saved spots yet.');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 6.0;
        final tileWidth = (constraints.maxWidth - gap * 2) / 3;

        Widget tile(int index) {
          final entry = spots[index];
          return _SavedSpot(
            profile: entry.profile,
            place: entry.place,
            onTap: () => onProfileTap(entry.profile),
          );
        }

        Widget stack(int top, int bottom) {
          return Expanded(
            child: Column(
              children: [
                Expanded(child: tile(top)),
                const SizedBox(height: gap),
                Expanded(child: tile(bottom)),
              ],
            ),
          );
        }

        return Column(
          children: [
            for (var start = 0; start < spots.length; start += 5) ...[
              if (start > 0) const SizedBox(height: gap),
              if (start + 5 <= spots.length)
                SizedBox(
                  height: tileWidth * 2 + gap,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (start.isEven) ...[
                        Expanded(child: tile(start)),
                        const SizedBox(width: gap),
                        stack(start + 1, start + 3),
                        const SizedBox(width: gap),
                        stack(start + 2, start + 4),
                      ] else ...[
                        stack(start + 1, start + 3),
                        const SizedBox(width: gap),
                        stack(start + 2, start + 4),
                        const SizedBox(width: gap),
                        Expanded(child: tile(start)),
                      ],
                    ],
                  ),
                )
              else
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: [
                      for (var index = start; index < spots.length; index++)
                        SizedBox.square(
                          dimension: tileWidth,
                          child: tile(index),
                        ),
                    ],
                  ),
                ),
            ],
          ],
        );
      },
    );
  }
}

class _SavedSpot extends StatelessWidget {
  final DemoProfile profile;
  final Place place;
  final VoidCallback onTap;

  const _SavedSpot({
    required this.profile,
    required this.place,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Semantics(
      label: '${place.name}, saved by ${profile.name}',
      button: true,
      onTap: onTap,
      excludeSemantics: true,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            PlacePhoto(place: place),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xDB191815)],
                  stops: [0.22, 1],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.label.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.fromLTRB(3, 3, 6, 3),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 9,
                            backgroundColor: Color(profile.avatarColor),
                            foregroundColor: Colors.white,
                            child: Text(
                              profile.initials,
                              style: const TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              profile.firstName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.label.copyWith(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(onTap: onTap),
            ),
          ],
        ),
      ),
    );
  }
}
