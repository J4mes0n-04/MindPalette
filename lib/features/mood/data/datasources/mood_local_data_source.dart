import 'package:hive_flutter/hive_flutter.dart';
import '../models/mood_model.dart';

/// Local Data Source - Hive database operations
class MoodLocalDataSource {
  static const String _boxName = 'moods';
  late Box<MoodModel> _moodBox;

  /// Initialize Hive box
  Future<void> init() async {
    _moodBox = await Hive.openBox<MoodModel>(_boxName);
  }

  /// Get all moods
  Future<List<MoodModel>> getAllMoods() async {
    return _moodBox.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  /// Get moods by date
  Future<List<MoodModel>> getMoodsByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return _moodBox.values
        .where((mood) =>
            mood.timestamp.isAfter(startOfDay) &&
            mood.timestamp.isBefore(endOfDay))
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  /// Get moods by date range
  Future<List<MoodModel>> getMoodsByDateRange(
      DateTime start, DateTime end) async {
    return _moodBox.values
        .where((mood) =>
            mood.timestamp.isAfter(start) && mood.timestamp.isBefore(end))
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  /// Add mood
  Future<void> addMood(MoodModel mood) async {
    await _moodBox.put(mood.id, mood);
  }

  /// Update mood
  Future<void> updateMood(MoodModel mood) async {
    await _moodBox.put(mood.id, mood);
  }

  /// Delete mood
  Future<void> deleteMood(String id) async {
    await _moodBox.delete(id);
  }

  /// Watch all moods (Stream)
  Stream<List<MoodModel>> watchAllMoods() {
    return _moodBox.watch().map((_) {
      return _moodBox.values.toList()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    });
  }

  /// Clear all data (for testing)
  Future<void> clearAll() async {
    await _moodBox.clear();
  }
}