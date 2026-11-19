// Used in place card, swipe screen and your picks screen

class Place {
  final String name;
  final String area;
  final String imageUrl;

  const Place({required this.name, required this.area, required this.imageUrl,
  });
}

// Placeholder Data
const List<Place> samplePicks = [
  Place(
    name: 'Little Corner Café',
    area: 'Moda · Café',
    imageUrl: 'https://picsum.photos/seed/cafe1/200',
  ),
  Place(
    name: 'Green Yard Brunch',
    area: 'Caferağa · Brunch',
    imageUrl: 'https://picsum.photos/seed/cafe2/200',
  ),
  Place(
    name: 'Sunday Table',
    area: 'Yeldeğirmeni · Brunch',
    imageUrl: 'https://picsum.photos/seed/cafe3/200',
  ),
  Place(
    name: 'Olive & Crumb',
    area: 'Moda · Bakery',
    imageUrl: 'https://picsum.photos/seed/cafe4/200',
  ),
  Place(
    name: 'The Back Garden',
    area: 'Fenerbahçe · Café',
    imageUrl: 'https://picsum.photos/seed/cafe5/200',
  ),
];
