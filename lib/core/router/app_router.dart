import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/welcome/welcome_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/signup_screen.dart';
import '../../presentation/screens/main_tab/main_tab_screen.dart';
import '../../presentation/screens/notification/notification_screen.dart';
import '../../presentation/screens/payment/payment_selection_screen.dart';
import '../../presentation/screens/payment/momo_payment_screen.dart';
import '../../presentation/screens/payment/airtel_payment_screen.dart';
import '../../presentation/screens/payment/card_payment_screen.dart';
import '../../presentation/screens/payment/payment_success_screen.dart';

abstract final class AppRoutes {
  static const String splash         = '/';
  static const String welcome        = '/welcome';        // ← ADDED
  static const String login          = '/login';
  static const String signup         = '/signup';
  static const String main           = '/main';
  static const String notification   = '/notification';
  static const String paymentSelect  = '/payment';
  static const String momoPayment    = '/payment/momo';
  static const String airtelPayment  = '/payment/airtel';
  static const String cardPayment    = '/payment/card';
  static const String paymentSuccess = '/payment/success';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (ctx, state) => _ios(state, const SplashScreen()),
    ),
    GoRoute(                                               // ← ADDED
      path: AppRoutes.welcome,
      pageBuilder: (ctx, state) => _ios(state, const WelcomeScreen()),
    ),
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (ctx, state) => _ios(state, const LoginScreen()),
    ),
    GoRoute(
      path: AppRoutes.signup,
      pageBuilder: (ctx, state) => _ios(state, const SignUpScreen()),
    ),
    GoRoute(
      path: AppRoutes.main,
      pageBuilder: (ctx, state) => _ios(state, const MainTabScreen()),
    ),
    GoRoute(
      path: AppRoutes.notification,
      pageBuilder: (ctx, state) => _ios(state, const NotificationScreen()),
    ),
    GoRoute(
      path: AppRoutes.paymentSelect,
      pageBuilder: (ctx, state) {
        final total = (state.extra as double?) ?? 0.0;
        return _ios(state, PaymentSelectionScreen(total: total));
      },
    ),
    GoRoute(
      path: AppRoutes.momoPayment,
      pageBuilder: (ctx, state) {
        final total = (state.extra as double?) ?? 0.0;
        return _ios(state, MomoPaymentScreen(total: total));
      },
    ),
    GoRoute(
      path: AppRoutes.airtelPayment,
      pageBuilder: (ctx, state) {
        final total = (state.extra as double?) ?? 0.0;
        return _ios(state, AirtelPaymentScreen(total: total));
      },
    ),
    GoRoute(
      path: AppRoutes.cardPayment,
      pageBuilder: (ctx, state) {
        final total = (state.extra as double?) ?? 0.0;
        return _ios(state, CardPaymentScreen(total: total));
      },
    ),
    GoRoute(
      path: AppRoutes.paymentSuccess,
      pageBuilder: (ctx, state) =>
          _ios(state, const PaymentSuccessScreen()),
    ),
  ],
);

CupertinoPage<void> _ios(GoRouterState state, Widget child) =>
    CupertinoPage<void>(key: state.pageKey, child: child);