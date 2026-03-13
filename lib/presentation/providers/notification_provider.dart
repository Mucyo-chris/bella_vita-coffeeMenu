import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/notification_entity.dart';
import '../../injection/dependency_injection.dart';

// ── State ─────────────────────────────────────────────────────
class NotificationState {
  final List<NotificationEntity> notifications;
  final bool showIntro;
  final bool isLoading;
  final String? error;

  const NotificationState({
    this.notifications = const [],
    this.showIntro = true,
    this.isLoading = false,
    this.error,
  });

  int get unreadCount =>
      notifications.where((n) => !n.isRead).length;

  NotificationState copyWith({
    List<NotificationEntity>? notifications,
    bool? showIntro,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) =>
      NotificationState(
        notifications: notifications ?? this.notifications,
        showIntro: showIntro ?? this.showIntro,
        isLoading: isLoading ?? this.isLoading,
        error: clearError ? null : error ?? this.error,
      );
}

// ── Notifier ──────────────────────────────────────────────────
class NotificationNotifier extends StateNotifier<NotificationState> {
  final Ref _ref;

  NotificationNotifier(this._ref) : super(const NotificationState()) {
    _load();
  }

  Future<void> _load() async {
    state = state.copyWith(isLoading: true);
    try {
      final items =
          await _ref.read(getNotificationsUseCaseProvider).call();
      state = state.copyWith(notifications: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void proceedToList() => state = state.copyWith(showIntro: false);
  void resetToIntro()  => state = state.copyWith(showIntro: true);

  Future<void> markAsRead(String id) async {
    try {
      await _ref.read(markReadUseCaseProvider).call(id);
      final updated = state.notifications.map((n) {
        return n.id == id ? n.copyWith(isRead: true) : n;
      }).toList();
      state = state.copyWith(notifications: updated);
    } catch (_) {}
  }

  Future<void> markAllAsRead() async {
    try {
      await _ref.read(markReadUseCaseProvider).markAll();
      final updated = state.notifications
          .map((n) => n.copyWith(isRead: true))
          .toList();
      state = state.copyWith(notifications: updated);
    } catch (_) {}
  }

  Future<void> remove(String id) async {
    try {
      await _ref
          .read(notificationRepositoryProvider)
          .removeNotification(id);
      final updated =
          state.notifications.where((n) => n.id != id).toList();
      state = state.copyWith(notifications: updated);
    } catch (_) {}
  }
}

// ── Provider ──────────────────────────────────────────────────
final notificationProvider =
    StateNotifierProvider<NotificationNotifier, NotificationState>(
  (ref) => NotificationNotifier(ref),
);
