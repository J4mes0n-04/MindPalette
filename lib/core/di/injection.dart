import '../../features/mood/data/datasources/mood_local_data_source.dart';
import '../../features/mood/data/repositories/mood_repository_impl.dart';
import '../../features/mood/domain/repositories/mood_repository.dart';
import '../../features/mood/domain/usecases/add_mood.dart';
import '../../features/mood/domain/usecases/delete_mood.dart';
import '../../features/mood/domain/usecases/get_moods_by_date.dart';
import '../../features/mood/domain/usecases/get_moods_by_date_range.dart';

/// Dependency Injection Container (Simple Manual DI)
class Injection {
  static late MoodLocalDataSource _moodLocalDataSource;
  static late MoodRepository _moodRepository;

  static Future<void> init() async {
    // Data sources
    _moodLocalDataSource = MoodLocalDataSource();
    await _moodLocalDataSource.init();

    // Repositories
    _moodRepository = MoodRepositoryImpl(_moodLocalDataSource);
  }

  // Repository getters
  static MoodRepository get moodRepository => _moodRepository;

  // Use case getters
  static AddMood get addMood => AddMood(_moodRepository);
  static DeleteMood get deleteMood => DeleteMood(_moodRepository);
  static GetMoodsByDate get getMoodsByDate => GetMoodsByDate(_moodRepository);
  static GetMoodsByDateRange get getMoodsByDateRange =>
      GetMoodsByDateRange(_moodRepository);
}