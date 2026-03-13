import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../providers/cart_provider.dart';

class PaymentSuccessScreen extends ConsumerStatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  ConsumerState<PaymentSuccessScreen> createState() =>
      _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends ConsumerState<PaymentSuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _scale = Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();

    // Clear cart on success
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cartProvider.notifier).clear();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.darkBrown,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Coffee splash background
          Positioned.fill(
            child: Image.asset(
              'assets/images/milk_pour.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF5C2E00), Color(0xFF2C1200)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          // Dark overlay
          Positioned.fill(
            child: Container(
              color:  const Color.fromARGB(255, 245, 222, 205).withOpacity(0.55),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Back
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GestureDetector(
                      onTap: () => context.go(AppRoutes.main),
                      child: const Icon(
                        CupertinoIcons.back,
                        color: AppColors.textOnDark,
                        size: 28,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                FadeTransition(
                  opacity: _fade,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Text(
                        'PAYMENT\nSUCCESSFUL',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.displayLarge.copyWith( 
                          color: const Color(0xFF3B1A08),
                            fontSize: 50,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                         
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Checkmark circle
                      ScaleTransition(
                        scale: _scale,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.darkBrown,
                              width: 4,
                            ),
                          ),
                          child: const Icon(
                            CupertinoIcons.checkmark,
                            color: AppColors.textOnDark,
                            size: 60,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Thank you button
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 48),
                  child: GestureDetector(
                    onTap: () => context.go(AppRoutes.main),
                    child: Container(
                      width: double.infinity,
                      height: 54,
                      decoration: BoxDecoration(
                        color: AppColors.darkBrown,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.darkBrown.withOpacity(0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'THANK YOU',
                          style: AppTextStyles.buttonLarge.copyWith(
                            fontSize: 18,
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
