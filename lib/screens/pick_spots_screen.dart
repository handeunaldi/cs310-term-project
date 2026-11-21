import 'package:flutter/material.dart';
import '../models/place.dart';
import '../theme/app_spacing.dart';
import '../theme/text_styles.dart';
import 'your_picks_screen.dart';

class PickSpotsScreen extends StatefulWidget {
  const PickSpotsScreen({super.key});

  @override
  State<PickSpotsScreen> createState() => _PickSpotsScreenState();
}

class _PickSpotsScreenState extends State<PickSpotsScreen> {
  // For now, spots come from placeholder data
  final List<Place> _spots = samplePicks;
  final List<Place> _liked = [];
  int _currentIndex = 0;

  bool get _isFinished => _currentIndex >= _spots.length;

  void _like() {
    setState(() {
      _liked.add(_spots[_currentIndex]);
      _currentIndex++;
    });
    // After the last card, go to Your Picks
    if (_isFinished) {
      _done();
    }
  }

  void _skip() {
    setState(() {
      _currentIndex++;
    });
    if (_isFinished) {
      _done();
    }
  }

  void _done() {
    // Liked places are sent to Your Picks with its constructor
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => YourPicksScreen(picks: _liked),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final total = _spots.length;
    final shown = _isFinished ? total : _currentIndex + 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your spots', style: AppTextStyles.label),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _isFinished
                  ? const Center(child: Text('No more spots. Tap Done to see your picks.'))
                  // The card scrolls on small screens
                  : SingleChildScrollView(
                      child: _SpotCard(place: _spots[_currentIndex]),
                    ),
            ),
            const SizedBox(height: AppSpacing.medium),

            // Skip / Like buttons (hidden after the last card)
            if (!_isFinished)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _skip,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back, size: 18, color: Colors.grey),
                        SizedBox(width: 4),
                        Text('Skip', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: _like,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Like', style: TextStyle(color: colors.primary)),
                        const SizedBox(width: 4),
                        Icon(Icons.arrow_forward, size: 18, color: colors.primary),
                      ],
                    ),
                  ),
                ],
              ),
            const SizedBox(height: AppSpacing.large),

            // Progress and Done button
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$shown / $total spots', style: AppTextStyles.label),
                      const SizedBox(height: AppSpacing.small),
                      // Progress bar: red part = seen, grey part = left
                      Row(
                        children: [
                          Expanded(
                            flex: shown,
                            child: Container(height: 4, color: colors.primary),
                          ),
                          if (total - shown > 0)
                            Expanded(
                              flex: total - shown,
                              child: Container(height: 4, color: Colors.grey),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.large),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _done,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: colors.onPrimary,
                    ),
                    child: const Text('Done'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// The card that shows one spot
class _SpotCard extends StatelessWidget {
  final Place place;

  const _SpotCard({required this.place});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.small),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Photo placeholder with the rating on top
            SizedBox(
              height: 240,
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.small),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(AppSpacing.radius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Chip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, size: 16),
                          const SizedBox(width: 4),
                          Text('${place.rating}', style: AppTextStyles.label),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image_outlined, size: 32, color: Colors.white),
                            Text('Spot photo', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.small),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          place.area,
                          style: const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.small),
                  Text(place.review, style: AppTextStyles.body),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
