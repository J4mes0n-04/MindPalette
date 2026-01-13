import '../entities/mood.dart';
import '../repositories/mood_repository.dart';

/// Use Case: Add a new mood entry
class AddMood {
  final MoodRepository repository;

  AddMood(this.repository);

  Future<void> call(Mood mood) async {
    return await repository.addMood(mood);
  }
}