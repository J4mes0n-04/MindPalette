import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../mood/domain/entities/mood.dart';
import '../../../mood/domain/usecases/get_moods_by_date_range.dart';
import '../../../mood/domain/repositories/mood_repository.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final GetMoodsByDateRange getMoodsByDateRange;
  final MoodRepository repository;

  StatisticsCubit({
    required this.getMoodsByDateRange,
    required this.repository,
  }) : super(StatisticsInitial());

  /// Load weekly statistics
  Future<void> loadWeeklyStatistics() async {
    emit(StatisticsLoading());
    try {
      final now = DateTime.now();
      final weekStart = now.subtract(Duration(days: now.weekday - 1));
      final weekEnd = weekStart.add(const Duration(days: 6, hours: 23, minutes: 59));

      final moods = await getMoodsByDateRange(weekStart, weekEnd);
      final counts = await repository.getMoodCountByType();

      emit(StatisticsLoaded(
        weeklyMoods: moods,
        moodCounts: counts,
        startDate: weekStart,
        endDate: weekEnd,
      ));
    } catch (e) {
      emit(StatisticsError(message: e.toString()));
    }
  }
}