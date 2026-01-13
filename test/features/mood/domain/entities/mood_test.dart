import 'package:flutter_test/flutter_test.dart';
import 'package:my_application/core/constants/mood_constants.dart';
import 'package:my_application/features/mood/domain/entities/mood.dart';

void main() {
  group('Mood Entity', () {
    final testMood = Mood(
      id: '1',
      type: MoodType.joy,
      note: 'Test note',
      timestamp: DateTime(2024, 1, 1),
    );

    test('should create mood with correct properties', () {
      expect(testMood.id, '1');
      expect(testMood.type, MoodType.joy);
      expect(testMood.note, 'Test note');
      expect(testMood.timestamp, DateTime(2024, 1, 1));
    });

    test('should support value equality', () {
      final mood1 = Mood(
        id: '1',
        type: MoodType.joy,
        note: 'Test',
        timestamp: DateTime(2024, 1, 1),
      );

      final mood2 = Mood(
        id: '1',
        type: MoodType.joy,
        note: 'Test',
        timestamp: DateTime(2024, 1, 1),
      );

      expect(mood1, mood2);
    });

    test('copyWith should create new instance with updated fields', () {
      final updated = testMood.copyWith(note: 'Updated note');

      expect(updated.id, testMood.id);
      expect(updated.type, testMood.type);
      expect(updated.note, 'Updated note');
      expect(updated.timestamp, testMood.timestamp);
    });
  });
}