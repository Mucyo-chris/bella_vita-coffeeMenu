import '../../repositories/notification_repository.dart';

class MarkReadUseCase {
  final NotificationRepository _repository;
  const MarkReadUseCase(this._repository);

  Future<void> call(String id) => _repository.markAsRead(id);
  Future<void> markAll()       => _repository.markAllAsRead();
}
