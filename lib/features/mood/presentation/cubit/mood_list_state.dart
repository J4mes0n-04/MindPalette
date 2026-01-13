part of 'mood_list_cubit.dart';

/// Mood List States
abstract class MoodListState extends Equatable {
  const MoodListState();

  @override
  List<Object?> get props => [];
}

class MoodListInitial extends MoodListState {}

class MoodListLoading extends MoodListState {}

class MoodListLoaded extends MoodListState {
  final List<Mood> moods;
  final DateTime selectedDate;

  const MoodListLoaded({required this.moods, required this.selectedDate});

  @override
  List<Object?> get props => [moods, selectedDate];
}

class MoodListError extends MoodListState {
  final String message;

  const MoodListError({required this.message});

  @override
  List<Object?> get props => [message];
}