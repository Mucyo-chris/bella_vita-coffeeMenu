import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.message,
    super.senderName,
    required super.timestamp,
    super.isRead,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) =>
      NotificationModel(
        id: map['id'] as String,
        message: map['message'] as String,
        senderName: map['senderName'] as String?,
        timestamp: map['timestamp'] != null
            ? DateTime.parse(map['timestamp'] as String)
            : DateTime.now(),
        isRead: map['isRead'] as bool? ?? false,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'message': message,
        if (senderName != null) 'senderName': senderName,
        'timestamp': timestamp.toIso8601String(),
        'isRead': isRead,
      };

  @override
  NotificationModel copyWith({
    String? id,
    String? message,
    String? senderName,
    DateTime? timestamp,
    bool? isRead,
  }) =>
      NotificationModel(
        id: id ?? this.id,
        message: message ?? this.message,
        senderName: senderName ?? this.senderName,
        timestamp: timestamp ?? this.timestamp,
        isRead: isRead ?? this.isRead,
      );
}
