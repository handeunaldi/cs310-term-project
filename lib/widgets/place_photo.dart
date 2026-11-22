import 'package:flutter/material.dart';

import '../models/place.dart';

class PlacePhoto extends StatelessWidget {
  final Place place;

  const PlacePhoto({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final asset = place.coverAsset;
    if (asset != null) {
      return Image.asset(
        asset,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stack) => _placeholder(context),
      );
    }

    if (place.imageUrl.isNotEmpty) {
      return Image.network(
        place.imageUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stack) => _placeholder(context),
      );
    }
    return _placeholder(context);
  }

  Widget _placeholder(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ColoredBox(
      color: colors.surfaceContainerHighest,
      child: Center(
        child: Icon(Icons.image_outlined, color: colors.onSurfaceVariant),
      ),
    );
  }
}
