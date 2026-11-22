// Used in place card, swipe screen and your picks screen

class Place {
  final String name;
  final String area;
  final String imageUrl;
  final String? coverAsset;
  final double rating;
  final String review;

  const Place({
    required this.name,
    required this.area,
    this.imageUrl = '',
    this.coverAsset,
    required this.rating,
    required this.review,
  });
}

// Placeholder Data
const List<Place> samplePicks = [
  Place(
    name: 'Little Corner Café',
    area: 'Moda · Café',
    imageUrl: 'https://picsum.photos/seed/cafe1/200',
    coverAsset: 'assets/spots/little-corner.jpg',
    rating: 4.8,
    review: '"Great coffee and a quiet garden in the back. Perfect for slow Sundays."',
  ),
  Place(
    name: 'Green Yard Brunch',
    area: 'Caferağa · Brunch',
    imageUrl: 'https://picsum.photos/seed/cafe2/200',
    coverAsset: 'assets/spots/green-yard.jpg',
    rating: 4.6,
    review: '"Huge brunch plates and a sunny terrace."',
  ),
  Place(
    name: 'Sunday Table',
    area: 'Yeldeğirmeni · Brunch',
    imageUrl: 'https://picsum.photos/seed/cafe3/200',
    coverAsset: 'assets/spots/sunday-table.jpg',
    rating: 4.5,
    review: '"Long wooden tables, great for big groups."',
  ),
  Place(
    name: 'Olive & Crumb',
    area: 'Moda · Bakery',
    imageUrl: 'https://picsum.photos/seed/cafe4/200',
    coverAsset: 'assets/spots/olive-and-crumb.jpg',
    rating: 4.7,
    review: '"Fresh bread every morning and very friendly staff."',
  ),
  Place(
    name: 'The Back Garden',
    area: 'Fenerbahçe · Café',
    imageUrl: 'https://picsum.photos/seed/cafe5/200',
    coverAsset: 'assets/spots/back-garden.jpg',
    rating: 4.4,
    review: '"A hidden garden close to the sea."',
  ),
];
