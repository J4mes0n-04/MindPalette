// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'MindPalette';

  @override
  String get home => 'Главная';

  @override
  String get statistics => 'Статистика';

  @override
  String get settings => 'Настройки';

  @override
  String get moodDiary => 'Дневник настроения';

  @override
  String get addMood => 'Добавить настроение';

  @override
  String get selectMood => 'Выберите ваше настроение';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get confirmDelete => 'Вы уверены, что хотите удалить эту запись?';

  @override
  String get noMoods => 'Пока нет записей настроения';

  @override
  String get startTracking => 'Начните отслеживать ваше настроение';

  @override
  String get language => 'Язык';

  @override
  String get english => 'Английский';

  @override
  String get russian => 'Русский';

  @override
  String get darkMode => 'Тёмный режим';

  @override
  String get notifications => 'Уведомления';

  @override
  String get about => 'О приложении';

  @override
  String get version => 'Версия';

  @override
  String get appearance => 'Внешний вид';

  @override
  String get dailyReminders => 'Ежедневные напоминания';

  @override
  String get getReminded => 'Получать напоминания о записи настроения';

  @override
  String get data => 'Данные';

  @override
  String get exportData => 'Экспорт данных';

  @override
  String get lastExported => 'Последний экспорт';

  @override
  String get exportYourData => 'Экспортируйте ваши данные настроения';

  @override
  String get noMoodsToday => 'Сегодня нет записей настроения';

  @override
  String get addFirstMood =>
      'Нажмите кнопку ниже, чтобы добавить первую запись настроения';
}
