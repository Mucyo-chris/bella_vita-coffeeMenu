import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/responsive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _controller.forward();

    // → Welcome screen
    Future.delayed(const Duration(milliseconds: 2400), () {
      if (mounted) context.go(AppRoutes.welcome);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = context.r;

    return CupertinoPageScaffold(
      backgroundColor: AppColors.primaryBrown,
      child: Center(
        child: FadeTransition(
          opacity: _fade,
          child: ScaleTransition(
            scale: _scale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: r.sp(100),
                  height: r.sp(100),
                  decoration: BoxDecoration(
                    color: AppColors.beige.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.lightBrown.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text('☕', style: TextStyle(fontSize: r.fs(44))),
                  ),
                ),
                SizedBox(height: r.sp(24)),
                Text(
                  AppStrings.appName,
                  style: AppTextStyles.brandItalic.copyWith(
                    color: AppColors.cream,
                    fontSize: r.fs(40),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: r.sp(8)),
                Text(
                  AppStrings.appTagline,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.lightBrown,
                    fontSize: r.fs(12),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: r.sp(48)),
                const CupertinoActivityIndicator(
                  color: AppColors.lightBrown,
                  radius: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}