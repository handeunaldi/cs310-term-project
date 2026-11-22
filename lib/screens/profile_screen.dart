import 'package:flutter/material.dart';

import '../models/crew.dart';
import '../models/demo_profile.dart';
import '../models/place.dart';
import '../theme/app_spacing.dart';
import '../theme/text_styles.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/crew_list_tile.dart';
import '../widgets/place_photo.dart';

class ProfileScreen extends StatelessWidget {
  final DemoProfile? profile;
  final List<Crew> crews;

  const ProfileScreen({super.key, this.profile, this.crews = sampleCrews});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final demo = profile;
    final savedSpots = demo?.savedSpots ?? samplePicks;
    final visibleCrews = demo?.crews ?? crews;
    final savedPreview = savedSpots.take(3).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.large),
              child: Row(
                mainAxisAlignment: demo == null
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  if (demo == null)
                    IconButton(
                      tooltip: 'Log in',
                      icon: const Icon(Icons.menu),
                      onPressed: () => Navigator.pushNamed(context, '/login'),
                    )
                  else
                    const BackButton(),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.large,
                ),
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: demo == null
                              ? colors.primary
                              : Color(demo.avatarColor),
                          foregroundColor: demo == null
                              ? colors.onPrimary
                              : Colors.white,
                          child: Text(
                            demo?.initials ?? 'DY',
                            style: AppTextStyles.appTitle,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.medium),
                        Text(
                          demo?.name ?? 'Deniz Yılmaz',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (demo != null)
                          Text(
                            '@${demo.username}',
                            style: AppTextStyles.small.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.large),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _StatItem(
                        value: demo?.savedSpots.length ?? 24,
                        label: 'Liked',
                      ),
                      _StatItem(value: visibleCrews.length, label: 'Crews'),
                      _StatItem(value: demo?.visited ?? 8, label: 'Visited'),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.large),
                  const Text('Crews', style: AppTextStyles.label),
                  const SizedBox(height: AppSpacing.small),
                  for (final (index, crew) in visibleCrews.indexed)
                    CrewListTile(
                      crew: crew,
                      index: index,
                      onTap: demo == null
                          ? () => Navigator.pushNamed(context, '/crews')
                          : null,
                    ),
                  const SizedBox(height: AppSpacing.medium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Saved', style: AppTextStyles.label),
                      TextButton(
                        onPressed: () {
                          if (demo == null) {
                            Navigator.pushNamed(context, '/picks');
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (_) =>
                                    _SavedSpotsScreen(profile: demo),
                              ),
                            );
                          }
                        },
                        child: const Text('See all'),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final (index, place) in savedPreview.indexed) ...[
                        if (index > 0) const SizedBox(width: AppSpacing.small),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: SizedBox(
                                  height: 90,
                                  child: PlacePhoto(place: place),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(place.name, style: AppTextStyles.label),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: AppSpacing.large),
                ],
              ),
            ),
            AppBottomNav(currentIndex: demo == null ? 2 : 0),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final int value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$value',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: AppTextStyles.small.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _SavedSpotsScreen extends StatelessWidget {
  final DemoProfile profile;

  const _SavedSpotsScreen({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved spots')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.medium),
        children: [
          Text(profile.name, style: AppTextStyles.appTitle),
          const SizedBox(height: AppSpacing.small),
          for (final place in profile.savedSpots)
            Card(
              margin: const EdgeInsets.only(bottom: AppSpacing.small),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: PlacePhoto(place: place),
                  ),
                ),
                title: Text(place.name, style: AppTextStyles.label),
                subtitle: Text(place.area),
              ),
            ),
        ],
      ),
    );
  }
}
