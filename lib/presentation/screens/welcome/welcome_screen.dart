import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/responsive.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _bgCtrl;
  late final AnimationController _contentCtrl;

  late final Animation<double> _bgFade;
  late final Animation<Offset> _taglineSlide;
  late final Animation<double> _taglineFade;
  late final Animation<Offset> _btnSlide;
  late final Animation<double> _btnFade;

  @override
  void initState() {
    super.initState();

    _bgCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _contentCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));

    _bgFade = CurvedAnimation(parent: _bgCtrl, curve: Curves.easeIn);

    _taglineSlide = Tween<Offset>(
            begin: const Offset(0, 0.25), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _contentCtrl,
            curve: const Interval(0.0, 0.65, curve: Curves.easeOut)));

    _taglineFade = CurvedAnimation(
        parent: _contentCtrl,
        curve: const Interval(0.0, 0.65, curve: Curves.easeIn));

    _btnSlide = Tween<Offset>(
            begin: const Offset(0, 0.35), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _contentCtrl,
            curve: const Interval(0.35, 1.0, curve: Curves.easeOut)));

    _btnFade = CurvedAnimation(
        parent: _contentCtrl,
        curve: const Interval(0.35, 1.0, curve: Curves.easeIn));

    // Staggered start
    _bgCtrl.forward().then((_) => _contentCtrl.forward());
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = context.r;

    return CupertinoPageScaffold(
      backgroundColor: AppColors.darkBrown,
      child: Stack(
        fit: StackFit.expand,
        children: [
             // ── Full-screen coffee beans background ──
          Positioned.fill(
            child: Image.asset(
              "assets/images/welcome_bg.jpg",
              fit: BoxFit.cover,
            ),
          ),
            
          // ── Bottom dark gradient scrim ───────────────────
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    CupertinoColors.transparent,
                    AppColors.darkBrown.withOpacity(0.0),
                    AppColors.darkBrown.withOpacity(0.0),
                    AppColors.darkBrown,
                  ],
                  stops: const [0.0, 0.4, 0.72, 1.0],
                ),
              ),
            ),
          ),

          // ── Content ──────────────────────────────────────
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: r.maxContentWidth),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: r.pagePadH),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),

                      // ── Brand name ───────────────────────
                      SlideTransition(
                        position: _taglineSlide,
                        child: FadeTransition(
                          opacity: _taglineFade,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Coffee icon badge
                              Container(
                                width: r.sp(56),
                                height: r.sp(56),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryBrown
                                      .withOpacity(0.85),
                                  borderRadius:
                                      BorderRadius.circular(r.sp(16)),
                                  border: Border.all(
                                    color: AppColors.lightBrown
                                        .withOpacity(0.4),
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '☕',
                                    style: TextStyle(fontSize: r.fs(28)),
                                  ),
                                ),
                              ),

                              SizedBox(height: r.sp(20)),

                              Text(
                                'Bella',
                                style: AppTextStyles.brandItalic.copyWith(
                                  color: AppColors.cream,
                                  fontSize: r.fs(58),
                                  fontWeight: FontWeight.w300,
                                  height: 0.95,
                                ),
                              ),
                              Text(
                                'Vita',
                                style: AppTextStyles.brandItalic.copyWith(
                                  color: AppColors.lightBrown,
                                  fontSize: r.fs(58),
                                  fontWeight: FontWeight.w300,
                                  height: 0.95,
                                ),
                              ),

                              SizedBox(height: r.sp(16)),

                              Text(
                                'The finest coffee,\ndelivered to your soul.',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.cream.withOpacity(0.7),
                                  fontSize: r.fs(15),
                                  height: 1.55,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: r.sp(52)),

                      // ── Buttons ───────────────────────────
                      SlideTransition(
                        position: _btnSlide,
                        child: FadeTransition(
                          opacity: _btnFade,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Get Started
                              GestureDetector(
                                onTap: () =>
                                    context.go(AppRoutes.signup),
                                child: Container(
                                  height: r.buttonHeight,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBrown,
                                    borderRadius:
                                        BorderRadius.circular(32),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryBrown
                                            .withOpacity(0.45),
                                        blurRadius: 20,
                                        offset: const Offset(0, 8),
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Get Started',
                                      style: AppTextStyles.buttonLarge
                                          .copyWith(
                                        fontSize: r.fs(16),
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: r.sp(14)),

                              // Sign In
                              GestureDetector(
                                onTap: () =>
                                    context.go(AppRoutes.login),
                                child: Container(
                                  height: r.buttonHeight,
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.transparent,
                                    borderRadius:
                                        BorderRadius.circular(32),
                                    border: Border.all(
                                      color: AppColors.lightBrown
                                          .withOpacity(0.55),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'I already have an account',
                                      style: AppTextStyles.buttonLarge
                                          .copyWith(
                                        fontSize: r.fs(15),
                                        color: AppColors.lightBrown,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: r.sp(12)),

                              // Guest / skip
                              Center(
                                child: GestureDetector(
                                  onTap: () =>
                                      context.go(AppRoutes.main),
                                  child: Text(
                                    'Browse as guest',
                                    style: AppTextStyles.bodySmall
                                        .copyWith(
                                      color: AppColors.cream
                                          .withOpacity(0.45),
                                      fontSize: r.fs(13),
                                      decoration:
                                          TextDecoration.underline,
                                      decorationColor: AppColors.cream
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: r.sp(40)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Fallback gradient if welcome_bg.jpg is missing ───────────────
class _GradientFallback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF3E1A00),
            Color(0xFF6B3A2A),
            Color(0xFF2C0D00),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Decorative circles
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFFFFF).withOpacity(0.04),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: -80,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFFFFF).withOpacity(0.03),
              ),
            ),
          ),
          // Giant background emoji
          const Center(
            child: Text(
              '☕',
              style: TextStyle(fontSize: 180, height: 1),
            ),
          ),
        ],
      ),
    );
  }
}
