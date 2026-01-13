import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_application/core/constants/mood_constants.dart';
import 'package:my_application/features/mood/domain/entities/mood.dart';
import 'package:my_application/features/mood/domain/usecases/add_mood.dart';
import 'package:my_application/features/mood/presentation/cubit/add_mood_cubit.dart';

class MockAddMood extends Mock implements AddMood {}

void main() {
  late AddMoodCubit cubit;
  late MockAddMood mockAddMood;

  setUp(() {
    mockAddMood = MockAddMood();
    cubit = AddMoodCubit(addMood: mockAddMood);
    registerFallbackValue(
      Mood(
        id: '1',
        type: MoodType.calm,
        note: '',
        timestamp: DateTime.now(),
      ),
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('AddMoodCubit', () {
    test('initial state is AddMoodInitial', () {
      expect(cubit.state, AddMoodInitial());
    });

    blocTest<AddMoodCubit, AddMoodState>(
      'selectMoodType emits AddMoodInProgress with selected type',
      build: () => cubit,
      act: (cubit) => cubit.selectMoodType(MoodType.joy),
      expect: () => [
        const AddMoodInProgress(selectedType: MoodType.joy, note: ''),
      ],
    );

    blocTest<AddMoodCubit, AddMoodState>(
      'updateNote emits AddMoodInProgress with updated note',
      build: () => cubit,
      act: (cubit) => cubit.updateNote('Test note'),
      expect: () => [
        const AddMoodInProgress(selectedType: MoodType.calm, note: 'Test note'),
      ],
    );

    blocTest<AddMoodCubit, AddMoodState>(
      'submitMood emits AddMoodSubmitting then AddMoodSuccess',
      build: () {
        when(() => mockAddMood.call(any())).thenAnswer((_) async => {});
        return cubit;
      },
      seed: () => const AddMoodInProgress(
        selectedType: MoodType.calm,
        note: 'Test',
      ),
      act: (cubit) => cubit.submitMood(),
      expect: () => [
        AddMoodSubmitting(),
        AddMoodSuccess(),
      ],
      verify: (_) {
        verify(() => mockAddMood.call(any())).called(1);
      },
    );

    blocTest<AddMoodCubit, AddMoodState>(
      'submitMood emits error when add fails',
      build: () {
        when(() => mockAddMood.call(any())).thenThrow(Exception('Failed'));
        return cubit;
      },
      seed: () => const AddMoodInProgress(
        selectedType: MoodType.calm,
        note: 'Test',
      ),
      act: (cubit) => cubit.submitMood(),
      expect: () => [
        AddMoodSubmitting(),
        isA<AddMoodError>(),
      ],
    );

    blocTest<AddMoodCubit, AddMoodState>(
      'reset emits AddMoodInitial',
      build: () => cubit,
      seed: () => const AddMoodInProgress(
        selectedType: MoodType.calm,
        note: 'Test',
      ),
      act: (cubit) => cubit.reset(),
      expect: () => [AddMoodInitial()],
    );
  });
}