import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String message;
  final String? senderName;
  final DateTime timestamp;
  final bool isRead;

  const NotificationEntity({
    required this.id,
    required this.message,
    this.senderName,
    required this.timestamp,
    this.isRead = false,
  });

  String get displayText =>
      senderName != null ? '$senderName $message' : message;

  NotificationEntity copyWith({
    String? id,
    String? message,
    String? senderName,
    DateTime? timestamp,
    bool? isRead,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      message: message ?? this.message,
      senderName: senderName ?? this.senderName,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object?> get props =>
      [id, message, senderName, timestamp, isRead];
}
