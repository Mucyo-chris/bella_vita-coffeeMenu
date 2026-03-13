import 'package:flutter_riverpod/flutter_riverpod.dart';

// Sources
import '../data/sources/auth_local_source.dart';
import '../data/sources/coffee_local_source.dart';
import '../data/sources/notification_local_source.dart';

// Repository impls
import '../data/repositories/auth_repository_impl.dart';
import '../data/repositories/coffee_repository_impl.dart';
import '../data/repositories/notification_repository_impl.dart';

// Domain repositories (interfaces)
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/coffee_repository.dart';
import '../domain/repositories/notification_repository.dart';

// Use cases
import '../domain/usecases/auth/sign_in_usecase.dart';
import '../domain/usecases/auth/sign_up_usecase.dart';
import '../domain/usecases/coffee/get_coffees_usecase.dart';
import '../domain/usecases/coffee/toggle_like_usecase.dart';
import '../domain/usecases/notification/get_notifications_usecase.dart';
import '../domain/usecases/notification/mark_read_usecase.dart';

// ── Sources ───────────────────────────────────────────────────
final authLocalSourceProvider = Provider<AuthLocalSource>(
  (_) => AuthLocalSourceImpl(),
);

final coffeeLocalSourceProvider = Provider<CoffeeLocalSource>(
  (_) => CoffeeLocalSourceImpl(),
);

final notificationLocalSourceProvider = Provider<NotificationLocalSource>(
  (_) => NotificationLocalSourceImpl(),
);

// ── Repositories ──────────────────────────────────────────────
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.watch(authLocalSourceProvider)),
);

final coffeeRepositoryProvider = Provider<CoffeeRepository>(
  (ref) => CoffeeRepositoryImpl(ref.watch(coffeeLocalSourceProvider)),
);

final notificationRepositoryProvider = Provider<NotificationRepository>(
  (ref) => NotificationRepositoryImpl(
      ref.watch(notificationLocalSourceProvider)),
);

// ── Use Cases ─────────────────────────────────────────────────
final signInUseCaseProvider = Provider<SignInUseCase>(
  (ref) => SignInUseCase(ref.watch(authRepositoryProvider)),
);

final signUpUseCaseProvider = Provider<SignUpUseCase>(
  (ref) => SignUpUseCase(ref.watch(authRepositoryProvider)),
);

final getCoffeesUseCaseProvider = Provider<GetCoffeesUseCase>(
  (ref) => GetCoffeesUseCase(ref.watch(coffeeRepositoryProvider)),
);

final toggleLikeUseCaseProvider = Provider<ToggleLikeUseCase>(
  (ref) => ToggleLikeUseCase(ref.watch(coffeeRepositoryProvider)),
);

final getNotificationsUseCaseProvider = Provider<GetNotificationsUseCase>(
  (ref) =>
      GetNotificationsUseCase(ref.watch(notificationRepositoryProvider)),
);

final markReadUseCaseProvider = Provider<MarkReadUseCase>(
  (ref) => MarkReadUseCase(ref.watch(notificationRepositoryProvider)),
);
