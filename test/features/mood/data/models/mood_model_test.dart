import 'package:flutter_test/flutter_test.dart';
import 'package:my_application/core/constants/mood_constants.dart';
import 'package:my_application/features/mood/data/models/mood_model.dart';
import 'package:my_application/features/mood/domain/entities/mood.dart';

void main() {
  group('MoodModel', () {
    final testTimestamp = DateTime(2024, 1, 1, 12, 0);
    final testMood = Mood(
      id: '1',
      type: MoodType.calm,
      note: 'Test note',
      timestamp: testTimestamp,
    );

    final testMoodModel = MoodModel(
      id: '1',
      typeIndex: 0,
      note: 'Test note',
      timestamp: testTimestamp,
    );

    test('fromEntity should convert Mood to MoodModel', () {
      final model = MoodModel.fromEntity(testMood);

      expect(model.id, testMood.id);
      expect(model.typeIndex, testMood.type.index);
      expect(model.note, testMood.note);
      expect(model.timestamp, testMood.timestamp);
    });

    test('toEntity should convert MoodModel to Mood', () {
      final mood = testMoodModel.toEntity();

      expect(mood.id, testMoodModel.id);
      expect(mood.type, MoodType.values[testMoodModel.typeIndex]);
      expect(mood.note, testMoodModel.note);
      expect(mood.timestamp, testMoodModel.timestamp);
    });

    test('fromJson should create MoodModel from JSON', () {
      final json = {
        'id': '1',
        'typeIndex': 0,
        'note': 'Test note',
        'timestamp': testTimestamp.toIso8601String(),
      };

      final model = MoodModel.fromJson(json);

      expect(model.id, '1');
      expect(model.typeIndex, 0);
      expect(model.note, 'Test note');
      expect(model.timestamp, testTimestamp);
    });

    test('toJson should create JSON from MoodModel', () {
      final json = testMoodModel.toJson();

      expect(json['id'], '1');
      expect(json['typeIndex'], 0);
      expect(json['note'], 'Test note');
      expect(json['timestamp'], testTimestamp.toIso8601String());
    });
  });
}