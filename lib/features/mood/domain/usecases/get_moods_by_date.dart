import '../entities/mood.dart';
import '../repositories/mood_repository.dart';

/// Use Case: Get moods for a specific date
class GetMoodsByDate {
  final MoodRepository repository;

  GetMoodsByDate(this.repository);

  Future<List<Mood>> call(DateTime date) async {
    return await repository.getMoodsByDate(date);
  }
}