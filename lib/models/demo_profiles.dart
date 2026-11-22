import 'crew.dart';
import 'demo_profile.dart';
import 'place.dart';

const _nightOwl = Place(
  name: 'Night Owl Bar',
  area: 'Kadıköy · Bar',
  coverAsset: 'assets/spots/night-owl.jpg',
  rating: 4.6,
  review: 'A warm spot for a late catch-up with friends.',
);

const _seaside = Place(
  name: 'Seaside Terrace',
  area: 'Moda · Outdoors',
  coverAsset: 'assets/spots/seaside.jpg',
  rating: 4.8,
  review: 'A quiet stop for a walk and a coffee by the water.',
);

const _morningRitual = Place(
  name: 'Morning Ritual',
  area: 'Yeldeğirmeni · Café',
  coverAsset: 'assets/spots/morning-ritual.jpg',
  rating: 4.7,
  review: 'Good coffee and plenty of light in the mornings.',
);

const _windowSeat = Place(
  name: 'The Window Seat',
  area: 'Moda · Café',
  coverAsset: 'assets/spots/window-seat.jpg',
  rating: 4.5,
  review: 'A small café with a sunny window table.',
);

const _glasshouse = Place(
  name: 'Glasshouse Café',
  area: 'Fenerbahçe · Café',
  coverAsset: 'assets/spots/glasshouse.jpg',
  rating: 4.8,
  review: 'A bright, plant-filled stop for a long brunch.',
);

final demoProfiles = List<DemoProfile>.unmodifiable([
  DemoProfile(
    name: 'Tuna Genç',
    username: 'tunagenc',
    initials: 'TG',
    avatarColor: 0xFFA3473A,
    savedSpots: [samplePicks[0], _nightOwl, _seaside],
    crews: sampleCrews,
    visited: 8,
  ),
  DemoProfile(
    name: 'Hande Ünaldı',
    username: 'handeunaldi',
    initials: 'HÜ',
    avatarColor: 0xFF386557,
    savedSpots: [samplePicks[1], _windowSeat, samplePicks[3]],
    crews: [sampleCrews[0]],
    visited: 6,
  ),
  DemoProfile(
    name: 'Ece Kaya',
    username: 'ecekaya',
    initials: 'EK',
    avatarColor: 0xFF9A4935,
    savedSpots: [_windowSeat, samplePicks[0], _morningRitual],
    crews: [sampleCrews[0]],
    visited: 3,
  ),
  DemoProfile(
    name: 'Yusuf Ali Matyar',
    username: 'yusufalimatyar',
    initials: 'YM',
    avatarColor: 0xFF345B72,
    savedSpots: [samplePicks[2], _seaside, _nightOwl],
    crews: sampleCrews,
    visited: 7,
  ),
  DemoProfile(
    name: 'Mert Aksoy',
    username: 'mertaksoy',
    initials: 'MA',
    avatarColor: 0xFF315B75,
    savedSpots: [_nightOwl, samplePicks[2], samplePicks[4]],
    crews: [sampleCrews[1]],
    visited: 5,
  ),
  DemoProfile(
    name: 'Zeynep Arslan',
    username: 'zeyneparslan',
    initials: 'ZA',
    avatarColor: 0xFF654C65,
    savedSpots: [_glasshouse, samplePicks[1], _windowSeat],
    crews: [sampleCrews[0]],
    visited: 6,
  ),
  DemoProfile(
    name: 'Selin Demir',
    username: 'selindemir',
    initials: 'SD',
    avatarColor: 0xFF386557,
    savedSpots: [samplePicks[4], _glasshouse, _seaside],
    crews: [sampleCrews[0]],
    visited: 4,
  ),
  DemoProfile(
    name: 'Kerem Öz',
    username: 'keremoz',
    initials: 'KÖ',
    avatarColor: 0xFF79496A,
    savedSpots: [samplePicks[3], _morningRitual, samplePicks[2]],
    crews: [sampleCrews[1]],
    visited: 4,
  ),
  DemoProfile(
    name: 'Arda Tan',
    username: 'ardatan',
    initials: 'AT',
    avatarColor: 0xFF545B82,
    savedSpots: [_seaside, samplePicks[4], _nightOwl],
    crews: [sampleCrews[1]],
    visited: 5,
  ),
  DemoProfile(
    name: 'Duru Yıldız',
    username: 'duruyildiz',
    initials: 'DY',
    avatarColor: 0xFF755C35,
    savedSpots: [_morningRitual, samplePicks[3], _glasshouse],
    crews: [sampleCrews[0]],
    visited: 6,
  ),
]);
