import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/constants/mood_constants.dart';
import '../../domain/entities/mood.dart';
import '../../domain/usecases/add_mood.dart';

part 'add_mood_state.dart';

/// Cubit for adding new mood entries
class AddMoodCubit extends Cubit<AddMoodState> {
  final AddMood addMood;

  AddMoodCubit({required this.addMood}) : super(AddMoodInitial());

  /// Select mood type
  void selectMoodType(MoodType type) {
    if (state is AddMoodInProgress) {
      final currentState = state as AddMoodInProgress;
      emit(currentState.copyWith(selectedType: type));
    } else {
      emit(AddMoodInProgress(selectedType: type, note: ''));
    }
  }

  /// Update note
  void updateNote(String note) {
    if (state is AddMoodInProgress) {
      final currentState = state as AddMoodInProgress;
      emit(currentState.copyWith(note: note));
    } else {
      emit(AddMoodInProgress(selectedType: MoodType.calm, note: note));
    }
  }

  /// Submit mood entry
  Future<void> submitMood() async {
    if (state is! AddMoodInProgress) return;

    final currentState = state as AddMoodInProgress;
    emit(AddMoodSubmitting());

    try {
      final mood = Mood(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: currentState.selectedType,
        note: currentState.note,
        timestamp: DateTime.now(),
      );

      await addMood(mood);
      emit(AddMoodSuccess());
    } catch (e) {
      emit(AddMoodError(message: e.toString()));
    }
  }

  /// Reset form
  void reset() {
    emit(AddMoodInitial());
  }
}