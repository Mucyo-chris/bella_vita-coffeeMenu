import '../models/notification_model.dart';

abstract class NotificationLocalSource {
  Future<List<NotificationModel>> getAll();
  Future<NotificationModel> markAsRead(String id);
  Future<void> markAllAsRead();
  Future<void> remove(String id);
  int get unreadCount;
}

class NotificationLocalSourceImpl implements NotificationLocalSource {
  final List<NotificationModel> _items = [
    NotificationModel(
      id: 'n1',
      senderName: 'John',
      message: 'requested menu of all coffee',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    NotificationModel(
      id: 'n2',
      senderName: 'MIKE',
      message: 'Paid two cups of cappuccino',
      timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
    ),
    NotificationModel(
      id: 'n3',
      message: 'New customer has requested menus',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    NotificationModel(
      id: 'n4',
      message: 'You have received 20,000 from Destin',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationModel(
      id: 'n5',
      message: 'Your new credit card code is 1200783',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    NotificationModel(
      id: 'n6',
      message:
          'Your account balance has been updated. Current balance: \$12,867.92',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    NotificationModel(
      id: 'n7',
      message: 'Your statement for March 2026 is now available',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
    NotificationModel(
      id: 'n8',
      message: 'Your recent transaction of \$230.00 at Chaichai has been confirmed',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  @override
  int get unreadCount => _items.where((n) => !n.isRead).length;

  @override
  Future<List<NotificationModel>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_items);
  }

  @override
  Future<NotificationModel> markAsRead(String id) async {
    final idx = _items.indexWhere((n) => n.id == id);
    if (idx == -1) throw StateError('Notification not found: $id');
    final updated = _items[idx].copyWith(isRead: true) as NotificationModel;
    _items[idx] = updated;
    return updated;
  }

  @override
  Future<void> markAllAsRead() async {
    for (int i = 0; i < _items.length; i++) {
      _items[i] = _items[i].copyWith(isRead: true) as NotificationModel;
    }
  }

  @override
  Future<void> remove(String id) async {
    _items.removeWhere((n) => n.id == id);
  }
}
