import 'package:equatable/equatable.dart';
import '../../../../core/constants/mood_constants.dart';

/// Mood Entity - Core business object
class Mood extends Equatable {
  final String id;
  final MoodType type;
  final String note;
  final DateTime timestamp;

  const Mood({
    required this.id,
    required this.type,
    required this.note,
    required this.timestamp,
  });

  /// Create copy with updated fields
  Mood copyWith({
    String? id,
    MoodType? type,
    String? note,
    DateTime? timestamp,
  }) {
    return Mood(
      id: id ?? this.id,
      type: type ?? this.type,
      note: note ?? this.note,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [id, type, note, timestamp];

  @override
  String toString() => 'Mood(id: $id, type: $type, note: $note, timestamp: $timestamp)';
}