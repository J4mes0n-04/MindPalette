import '../entities/mood.dart';

/// Mood Repository Interface - Abstract contract for data operations
abstract class MoodRepository {
  /// Get all moods
  Future<List<Mood>> getAllMoods();

  /// Get moods for a specific date
  Future<List<Mood>> getMoodsByDate(DateTime date);

  /// Get moods within a date range
  Future<List<Mood>> getMoodsByDateRange(DateTime start, DateTime end);

  /// Add a new mood entry
  Future<void> addMood(Mood mood);

  /// Update an existing mood entry
  Future<void> updateMood(Mood mood);

  /// Delete a mood entry
  Future<void> deleteMood(String id);

  /// Get mood count by type
  Future<Map<String, int>> getMoodCountByType();

  /// Stream of all moods (for real-time updates)
  Stream<List<Mood>> watchAllMoods();
}