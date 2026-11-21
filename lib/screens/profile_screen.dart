import 'package:flutter/material.dart';
import '../models/crew.dart';
import '../models/place.dart';
import '../theme/app_spacing.dart';
import '../theme/text_styles.dart';
import '../widgets/app_bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.large),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Menu icon: log out and go back to Login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                        ),
                      ],
                    ),

                    // Avatar and name
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: colors.primary,
                            child: Text(
                              'DY',
                              style: AppTextStyles.appTitle.copyWith(color: colors.onPrimary),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.medium),
                          const Text(
                            'Deniz Yılmaz',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.large),

                    // Stats
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatItem(value: 24, label: 'Liked'),
                        _StatItem(value: 2, label: 'Crews'),
                        _StatItem(value: 8, label: 'Visited'),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.large),

                    // Crews
                    const Text('Crews', style: AppTextStyles.label),
                    const SizedBox(height: AppSpacing.small),
                    Column(
                      children: sampleCrews.map((crew) {
                        return _CrewRow(crew: crew);
                      }).toList(),
                    ),
                    const SizedBox(height: AppSpacing.medium),

                    // Saved
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Saved', style: AppTextStyles.label),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/picks');
                          },
                          child: const Text('See all'),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _SavedItem(place: samplePicks[0])),
                        const SizedBox(width: AppSpacing.small),
                        Expanded(child: _SavedItem(place: samplePicks[1])),
                        const SizedBox(width: AppSpacing.small),
                        Expanded(child: _SavedItem(place: samplePicks[2])),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.large),
                  ],
                ),
              ),
            ),
            const AppBottomNav(currentIndex: 2),
          ],
        ),
      ),
    );
  }
}

// One number in the stats row (e.g. 24 Liked)
class _StatItem extends StatelessWidget {
  final int value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$value', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }
}

// One crew in the Crews list
class _CrewRow extends StatelessWidget {
  final Crew crew;

  const _CrewRow({required this.crew});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${crew.name} spots are coming soon')),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.small),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  crew.letter,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.medium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(crew.name, style: AppTextStyles.label),
                  Text(
                    '${crew.members} members · ${crew.spots} spots',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

// One saved place (photo placeholder + name)
class _SavedItem extends StatelessWidget {
  final Place place;

  const _SavedItem({required this.place});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 90,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          place.name,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
