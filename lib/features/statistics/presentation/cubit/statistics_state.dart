part of 'statistics_cubit.dart';

abstract class StatisticsState extends Equatable {
  const StatisticsState();

  @override
  List<Object?> get props => [];
}

class StatisticsInitial extends StatisticsState {}

class StatisticsLoading extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {
  final List<Mood> weeklyMoods;
  final Map<String, int> moodCounts;
  final DateTime startDate;
  final DateTime endDate;

  const StatisticsLoaded({
    required this.weeklyMoods,
    required this.moodCounts,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [weeklyMoods, moodCounts, startDate, endDate];
}

class StatisticsError extends StatisticsState {
  final String message;

  const StatisticsError({required this.message});

  @override
  List<Object?> get props => [message];
}