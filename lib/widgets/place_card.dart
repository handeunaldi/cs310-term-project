import 'package:flutter/material.dart';
import '../models/place.dart';


class PlaceCard extends StatelessWidget {
  final Place place;
  final VoidCallback onRemove;

  const PlaceCard({super.key, required this.place, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: ListTile(
        leading: Image.network(
          place.imageUrl,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
        ),
        title: Text(place.name),
        subtitle: Text(place.area),
        trailing: IconButton(
          icon: Icon(Icons.favorite, color: colors.primary),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
