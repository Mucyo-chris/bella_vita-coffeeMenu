import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/validators.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailCtrl = TextEditingController();
  String? _emailError;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleNext() async {
    // Validate
    final err = Validators.required(_emailCtrl.text);
    if (err != null) {
      setState(() => _emailError = err);
      return;
    }
    setState(() => _emailError = null);

    final success =
        await ref.read(authProvider.notifier).signIn(_emailCtrl.text.trim());
    if (success && mounted) {
      context.go(AppRoutes.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return CupertinoPageScaffold(
      backgroundColor: AppColors.primaryBrown,
      child: Stack(
        fit: StackFit.expand,
        
        children: [
          // ── Full-screen coffee beans background ──
          Positioned.fill(
            child: Image.asset(
              "assets/images/coffee_splash.jpg",
              fit: BoxFit.cover,
            ),
          ),
          // ── Warm cream overlay ─────────────────────────────
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryBrown,
                    AppColors.mediumBrown.withOpacity(0.55),
                    AppColors.cream.withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.pagePaddingH,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDimensions.sp48),

                  // ── Google G badge ───────────────────────
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      color: AppColors.textOnDark.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.lightBrown.withOpacity(0.4),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'G',
                        style: AppTextStyles.displayMedium.copyWith(
                          color: AppColors.textOnDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.sp20),

                  Text(
                    AppStrings.signUp,
                    style: AppTextStyles.displayLarge.copyWith(
                      color: AppColors.textOnDark,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.sp6),
                  Text(
                    AppStrings.continueGoogle,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.lightBrown,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.sp48),

                  // ── Email / phone field ──────────────────
                  AppTextField(
                    controller: _emailCtrl,
                    placeholder: AppStrings.emailPhone,
                    prefixIcon: CupertinoIcons.person,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.go,
                    errorText: _emailError ?? (authState.error),
                    onEditingComplete: _handleNext,
                    onChanged: (_) {
                      if (_emailError != null) {
                        setState(() => _emailError = null);
                      }
                      ref.read(authProvider.notifier).clearError();
                    },
                  ),
                  const SizedBox(height: AppDimensions.sp16),

                  // ── Guest mode note ──────────────────────
                  Text.rich(
                    TextSpan(
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.lightBrown,
                      ),
                      children: [
                        const TextSpan(text: '${AppStrings.guestMode}  '),
                        TextSpan(
                          text: AppStrings.learnMore,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textOnDark,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.textOnDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.sp40),

                  // ── Action row ───────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          label: AppStrings.createAccount,
                          style: AppButtonStyle.outlined,
                          backgroundColor:
                              AppColors.textOnDark.withOpacity(0.08),
                          textColor: AppColors.textOnDark,
                          onTap: () => context.push(AppRoutes.signup),
                        ),
                      ),
                      const SizedBox(width: AppDimensions.sp12),
                      Expanded(
                        child: AppButton(
                          label: AppStrings.next,
                          isLoading: authState.isLoading,
                          onTap: _handleNext,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.sp32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
