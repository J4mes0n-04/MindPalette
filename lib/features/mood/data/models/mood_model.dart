import 'package:hive/hive.dart';
import '../../../../core/constants/mood_constants.dart';
import '../../domain/entities/mood.dart';

part 'mood_model.g.dart';

/// Mood Model - Data layer representation with Hive annotations
@HiveType(typeId: 0)
class MoodModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int typeIndex; // Store as int for Hive

  @HiveField(2)
  final String note;

  @HiveField(3)
  final DateTime timestamp;

  MoodModel({
    required this.id,
    required this.typeIndex,
    required this.note,
    required this.timestamp,
  });

  /// Convert from domain entity
  factory MoodModel.fromEntity(Mood mood) {
    return MoodModel(
      id: mood.id,
      typeIndex: mood.type.index,
      note: mood.note,
      timestamp: mood.timestamp,
    );
  }

  /// Convert to domain entity
  Mood toEntity() {
    return Mood(
      id: id,
      type: MoodType.values[typeIndex],
      note: note,
      timestamp: timestamp,
    );
  }

  /// Create from JSON (for testing/export)
  factory MoodModel.fromJson(Map<String, dynamic> json) {
    return MoodModel(
      id: json['id'] as String,
      typeIndex: json['typeIndex'] as int,
      note: json['note'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  /// Convert to JSON (for testing/export)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'typeIndex': typeIndex,
      'note': note,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}