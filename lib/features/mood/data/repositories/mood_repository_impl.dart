import '../../../../core/constants/mood_constants.dart';
import '../../domain/entities/mood.dart';
import '../../domain/repositories/mood_repository.dart';
import '../datasources/mood_local_data_source.dart';
import '../models/mood_model.dart';

/// Mood Repository Implementation
class MoodRepositoryImpl implements MoodRepository {
  final MoodLocalDataSource localDataSource;

  MoodRepositoryImpl(this.localDataSource);

  @override
  Future<List<Mood>> getAllMoods() async {
    final models = await localDataSource.getAllMoods();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Mood>> getMoodsByDate(DateTime date) async {
    final models = await localDataSource.getMoodsByDate(date);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Mood>> getMoodsByDateRange(DateTime start, DateTime end) async {
    final models = await localDataSource.getMoodsByDateRange(start, end);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> addMood(Mood mood) async {
    final model = MoodModel.fromEntity(mood);
    await localDataSource.addMood(model);
  }

  @override
  Future<void> updateMood(Mood mood) async {
    final model = MoodModel.fromEntity(mood);
    await localDataSource.updateMood(model);
  }

  @override
  Future<void> deleteMood(String id) async {
    await localDataSource.deleteMood(id);
  }

  @override
  Future<Map<String, int>> getMoodCountByType() async {
    final moods = await getAllMoods();
    final Map<String, int> counts = {};

    for (var type in MoodType.values) {
      counts[type.name] = moods.where((m) => m.type == type).length;
    }

    return counts;
  }

  @override
  Stream<List<Mood>> watchAllMoods() {
    return localDataSource
        .watchAllMoods()
        .map((models) => models.map((m) => m.toEntity()).toList());
  }
}