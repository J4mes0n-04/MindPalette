// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'MindPalette';

  @override
  String get home => 'Home';

  @override
  String get statistics => 'Statistics';

  @override
  String get settings => 'Settings';

  @override
  String get moodDiary => 'Mood Diary';

  @override
  String get addMood => 'Add Mood';

  @override
  String get selectMood => 'Select your mood';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get confirmDelete =>
      'Are you sure you want to delete this mood entry?';

  @override
  String get noMoods => 'No mood entries yet';

  @override
  String get startTracking => 'Start tracking your mood';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get russian => 'Russian';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get notifications => 'Notifications';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get appearance => 'Appearance';

  @override
  String get dailyReminders => 'Daily Reminders';

  @override
  String get getReminded => 'Get reminded to log your mood';

  @override
  String get data => 'Data';

  @override
  String get exportData => 'Export Data';

  @override
  String get lastExported => 'Last exported';

  @override
  String get exportYourData => 'Export your mood data';

  @override
  String get noMoodsToday => 'No moods recorded today';

  @override
  String get addFirstMood =>
      'Tap the button below to add your first mood entry';
}
