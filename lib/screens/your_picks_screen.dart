import 'package:flutter/material.dart';
import '../models/place.dart';
import '../theme/app_spacing.dart';
import '../theme/text_styles.dart';
import '../widgets/place_card.dart';

class YourPicksScreen extends StatefulWidget {
  final List<Place> picks;

  const YourPicksScreen({super.key, this.picks = samplePicks});

  @override
  State<YourPicksScreen> createState() => _YourPicksScreenState();
}

class _YourPicksScreenState extends State<YourPicksScreen> {
  late List<Place> _picks;

  @override
  void initState() {
    super.initState();
    _picks = List.from(widget.picks);
  }

  void _removePlace(int index) {
    setState(() {
      _picks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your picks', style: AppTextStyles.appTitle),
            const SizedBox(height: AppSpacing.small),
            const Text('The spots that felt right for brunch in Kadıköy.'),
            const SizedBox(height: AppSpacing.medium),
            Expanded(
              child: _picks.isEmpty
                  ? const Center(child: Text('No picks yet. Keep swiping!'))
                  : ListView.builder(
                itemCount: _picks.length,
                itemBuilder: (context, index) {
                  return PlaceCard(
                    place: _picks[index],
                    onRemove: () => _removePlace(index),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.medium),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Shared with the crew!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: colors.onPrimary,
                ),
                child: const Text('Share with the crew'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}