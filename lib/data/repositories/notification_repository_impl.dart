import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../sources/notification_local_source.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationLocalSource _source;
  const NotificationRepositoryImpl(this._source);

  @override
  int get unreadCount => _source.unreadCount;

  @override
  Future<List<NotificationEntity>> getNotifications() => _source.getAll();

  @override
  Future<NotificationEntity> markAsRead(String id) => _source.markAsRead(id);

  @override
  Future<void> markAllAsRead() => _source.markAllAsRead();

  @override
  Future<void> removeNotification(String id) => _source.remove(id);
}
