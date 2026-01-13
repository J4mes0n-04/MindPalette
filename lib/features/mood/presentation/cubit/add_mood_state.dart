part of 'add_mood_cubit.dart';

/// Add Mood States
abstract class AddMoodState extends Equatable {
  const AddMoodState();

  @override
  List<Object?> get props => [];
}

class AddMoodInitial extends AddMoodState {}

class AddMoodInProgress extends AddMoodState {
  final MoodType selectedType;
  final String note;

  const AddMoodInProgress({
    required this.selectedType,
    required this.note,
  });

  AddMoodInProgress copyWith({
    MoodType? selectedType,
    String? note,
  }) {
    return AddMoodInProgress(
      selectedType: selectedType ?? this.selectedType,
      note: note ?? this.note,
    );
  }

  @override
  List<Object?> get props => [selectedType, note];
}

class AddMoodSubmitting extends AddMoodState {}

class AddMoodSuccess extends AddMoodState {}

class AddMoodError extends AddMoodState {
  final String message;

  const AddMoodError({required this.message});

  @override
  List<Object?> get props => [message];
}