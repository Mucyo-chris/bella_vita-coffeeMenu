// lib/domain/usecases/notification/get_notifications_usecase.dart
import '../../repositories/notification_repository.dart';
import '../../entities/notification_entity.dart';

class GetNotificationsUseCase {
  final NotificationRepository _repository;
  const GetNotificationsUseCase(this._repository);

  Future<List<NotificationEntity>> call() =>
      _repository.getNotifications();
}
