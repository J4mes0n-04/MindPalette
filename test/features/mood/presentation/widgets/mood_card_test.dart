import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_application/core/constants/mood_constants.dart';
import 'package:my_application/features/mood/domain/entities/mood.dart';
import 'package:my_application/features/mood/presentation/widgets/mood_card.dart';

void main() {
  group('MoodCard Widget', () {
    late Mood testMood;

    setUp(() {
      testMood = Mood(
        id: '1',
        type: MoodType.joy,
        note: 'Feeling great today!',
        timestamp: DateTime(2024, 1, 1, 14, 30),
      );
    });

    testWidgets('displays mood emoji and name', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MoodCard(mood: testMood),
          ),
        ),
      );

      expect(find.text('😊'), findsOneWidget);
      expect(find.text('Joy'), findsOneWidget);
    });

    testWidgets('displays mood note', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MoodCard(mood: testMood),
          ),
        ),
      );

      expect(find.text('Feeling great today!'), findsOneWidget);
    });

    testWidgets('displays timestamp', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MoodCard(mood: testMood),
          ),
        ),
      );

      expect(find.text('14:30'), findsOneWidget);
    });

    testWidgets('shows delete button when onDelete provided', (tester) async {
      var deleteCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MoodCard(
              mood: testMood,
              onDelete: () => deleteCalled = true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.delete_outline), findsOneWidget);
    });

    testWidgets('delete button shows confirmation dialog', (tester) async {
      var deleteCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MoodCard(
              mood: testMood,
              onDelete: () => deleteCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();

      expect(find.text('Delete mood entry?'), findsOneWidget);
      expect(find.text('This action cannot be undone.'), findsOneWidget);
    });
  });
}