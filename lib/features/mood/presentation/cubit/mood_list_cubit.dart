import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/mood.dart';
import '../../domain/usecases/get_moods_by_date.dart';
import '../../domain/usecases/delete_mood.dart';
import '../../domain/repositories/mood_repository.dart';

part 'mood_list_state.dart';

/// Cubit for managing mood list state
class MoodListCubit extends Cubit<MoodListState> {
  final GetMoodsByDate getMoodsByDate;
  final DeleteMood deleteMood;
  final MoodRepository repository;
  StreamSubscription? _moodsSubscription;

  MoodListCubit({
    required this.getMoodsByDate,
    required this.deleteMood,
    required this.repository,
  }) : super(MoodListInitial());

  /// Load moods for today
  Future<void> loadTodayMoods() async {
    emit(MoodListLoading());
    try {
      final today = DateTime.now();
      final moods = await getMoodsByDate(today);
      emit(MoodListLoaded(moods: moods, selectedDate: today));
    } catch (e) {
      emit(MoodListError(message: e.toString()));
    }
  }

  /// Load moods for specific date
  Future<void> loadMoodsForDate(DateTime date) async {
    emit(MoodListLoading());
    try {
      final moods = await getMoodsByDate(date);
      emit(MoodListLoaded(moods: moods, selectedDate: date));
    } catch (e) {
      emit(MoodListError(message: e.toString()));
    }
  }

  /// Watch moods in real-time
  void watchMoods() {
    _moodsSubscription?.cancel();
    _moodsSubscription = repository.watchAllMoods().listen((moods) {
      final today = DateTime.now();
      final todayMoods = moods.where((mood) {
        return mood.timestamp.year == today.year &&
            mood.timestamp.month == today.month &&
            mood.timestamp.day == today.day;
      }).toList();
      emit(MoodListLoaded(moods: todayMoods, selectedDate: today));
    });
  }

  /// Delete mood entry
  Future<void> removeMood(String id) async {
    try {
      await deleteMood(id);
      // State will update via stream
    } catch (e) {
      emit(MoodListError(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _moodsSubscription?.cancel();
    return super.close();
  }
}