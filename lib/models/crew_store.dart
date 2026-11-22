import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'crew.dart';

enum JoinCrewResult { joined, alreadyMember, codeNotFound }

class CrewStore extends ValueNotifier<List<Crew>> {
  static const _storageKey = 'places_to_go.my_crews';

  static const demoInviteCode = '24680';
  static const _demoInvite = Crew(
    name: 'Moda Coffee Walk',
    letter: 'M',
    members: 3,
    spots: 5,
    code: demoInviteCode,
  );

  final _preferences = SharedPreferences.getInstance();
  final _random = Random();
  late final Future<void> _loading;
  bool _saving = false;
  bool _disposed = false;

  CrewStore() : super(sampleCrews) {
    _loading = _load();
  }

  Future<void> _load() async {
    try {
      final preferences = await _preferences;
      final entries = preferences.getStringList(_storageKey) ?? [];
      final crews = [...sampleCrews];
      for (final entry in entries) {
        final crew = _decode(entry);
        if (crew != null) {
          crews.add(crew);
        }
      }
      if (!_disposed) {
        value = List.unmodifiable(crews);
      }
    } catch (error) {
      debugPrint('Could not load crews: $error');
    }
  }

  Crew? _decode(String entry) {
    try {
      final data = jsonDecode(entry);
      if (data case {
        'name': final String name,
        'letter': final String letter,
        'spots': final int spots,
        'code': final String code,
      }) {
        final members = data['members'];
        return Crew(
          name: name,
          letter: letter,
          members: members is int && members > 0 ? members : 1,
          spots: spots,
          code: code,
        );
      }
    } on FormatException {
      return null;
    }
    return null;
  }

  bool hasName(String name) {
    final normalized = name.trim().toLowerCase();
    return value.any((crew) => crew.name.toLowerCase() == normalized);
  }

  Future<JoinCrewResult> join(String code) async {
    if (_saving) {
      throw StateError('A crew is already being saved.');
    }
    _saving = true;

    try {
      await _loading;
      final inviteCode = code.trim();
      if (value.any((crew) => crew.code == inviteCode)) {
        return JoinCrewResult.alreadyMember;
      }
      if (inviteCode != demoInviteCode) {
        return JoinCrewResult.codeNotFound;
      }

      final crew = Crew(
        name: _demoInvite.name,
        letter: _demoInvite.letter,
        members: _demoInvite.members + 1,
        spots: _demoInvite.spots,
        code: _demoInvite.code,
      );
      await _save([...value, crew]);
      return JoinCrewResult.joined;
    } finally {
      _saving = false;
    }
  }

  Future<Crew> add(String name, {required int spots}) async {
    if (_saving) {
      throw StateError('A crew is already being saved.');
    }
    _saving = true;

    try {
      await _loading;
      final trimmedName = name.trim();
      if (trimmedName.isEmpty || hasName(trimmedName)) {
        throw ArgumentError.value(name, 'name', 'Enter a unique crew name.');
      }

      final usedCodes = {demoInviteCode, ...value.map((crew) => crew.code)};
      String code;
      do {
        code = (10000 + _random.nextInt(90000)).toString();
      } while (usedCodes.contains(code));

      final crew = Crew(
        name: trimmedName,
        letter: String.fromCharCode(trimmedName.runes.first).toUpperCase(),
        members: 1,
        spots: spots,
        code: code,
      );
      await _save([...value, crew]);
      return crew;
    } finally {
      _saving = false;
    }
  }

  Future<void> _save(List<Crew> crews) async {
    final preferences = await _preferences;
    final saved = await preferences.setStringList(_storageKey, [
      for (final crew in crews)
        if (crew.code != null)
          jsonEncode({
            'name': crew.name,
            'letter': crew.letter,
            'members': crew.members,
            'spots': crew.spots,
            'code': crew.code,
          }),
    ]);
    if (!saved) {
      await preferences.reload();
      throw StateError('Could not save the crew.');
    }
    if (!_disposed) {
      value = List.unmodifiable(crews);
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
