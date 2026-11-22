import 'crew.dart';
import 'place.dart';

class DemoProfile {
  final String name;
  final String username;
  final String initials;
  final int avatarColor;
  final List<Place> savedSpots;
  final List<Crew> crews;
  final int visited;

  const DemoProfile({
    required this.name,
    required this.username,
    required this.initials,
    required this.avatarColor,
    required this.savedSpots,
    required this.crews,
    required this.visited,
  });

  String get firstName => name.split(' ').first;
}
