import '../entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<List<NotificationEntity>> getNotifications();
  Future<NotificationEntity> markAsRead(String id);
  Future<void> markAllAsRead();
  Future<void> removeNotification(String id);
  int get unreadCount;
}
