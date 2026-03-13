import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'presentation/providers/theme_provider.dart';

class BellaVitaApp extends ConsumerWidget {
  const BellaVitaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = ref.watch(themeProvider);
    final theme = brightness == Brightness.dark
        ? AppTheme.dark
        : AppTheme.light;

    return CupertinoApp.router(
      title: 'Bella Vita',
      theme: theme,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
