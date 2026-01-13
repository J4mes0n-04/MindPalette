import '../entities/mood.dart';
import '../repositories/mood_repository.dart';

/// Use Case: Get moods within a date range
class GetMoodsByDateRange {
  final MoodRepository repository;

  GetMoodsByDateRange(this.repository);

  Future<List<Mood>> call(DateTime start, DateTime end) async {
    return await repository.getMoodsByDateRange(start, end);
  }
}