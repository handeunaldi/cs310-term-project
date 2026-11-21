// Used in profile screen

class Crew {
  final String name;
  final String letter;
  final int members;
  final int spots;

  const Crew({
    required this.name,
    required this.letter,
    required this.members,
    required this.spots,
  });
}

// Placeholder Data
const List<Crew> sampleCrews = [
  Crew(name: 'Weekend Brunch Club', letter: 'W', members: 4, spots: 12),
  Crew(name: 'Office Lunch Crew', letter: 'O', members: 6, spots: 9),
];
