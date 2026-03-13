import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';

class MomoPaymentScreen extends StatefulWidget {
  final double total;
  const MomoPaymentScreen({super.key, this.total = 0.0});

  @override
  State<MomoPaymentScreen> createState() => _MomoPaymentScreenState();
}

class _MomoPaymentScreenState extends State<MomoPaymentScreen> {
  final _amountCtrl = TextEditingController();
  final _phoneCtrl  = TextEditingController();
  bool _isLoading   = false;

  @override
  void initState() {
    super.initState();
    if (widget.total > 0) {
      _amountCtrl.text = widget.total.toStringAsFixed(0);
    }
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _pay() async {
    if (_amountCtrl.text.isEmpty || _phoneCtrl.text.isEmpty) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() => _isLoading = false);
      context.go(AppRoutes.paymentSuccess);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.cream,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Coffee beans bg
          Positioned.fill(
            child: Image.asset(
              'assets/images/beans.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: AppColors.beige),
            ),
          ),
          Positioned.fill(
            child: Container(color: AppColors.cream.withOpacity(0.85)),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 24),
                      child: GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.cream.withOpacity(0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryBrown.withOpacity(0.12),
                                blurRadius: 8,
                              )
                            ],
                          ),
                          child: const Icon(CupertinoIcons.back,
                              color: AppColors.primaryBrown, size: 20),
                        ),
                      ),
                    ),
                  ),

                  // MOMO Logo box
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: const Color(0xFF003580),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF003580).withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        )
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        '▲',
                        style: TextStyle(
                          color: Color(0xFFFFCC00),
                          fontSize: 60,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Text(
                    'MOMO',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppColors.primaryBrown,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 36),

                  // Amount
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter amount',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.primaryBrown,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.cream,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primaryBrown, width: 1.5),
                    ),
                    child: CupertinoTextField(
                      controller: _amountCtrl,
                      placeholder: 'Frw',
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.primaryBrown,
                        fontWeight: FontWeight.w600,
                      ),
                      placeholderStyle: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.mediumBrown,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Phone number
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Phone Number',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.primaryBrown,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.cream,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primaryBrown, width: 1.5),
                    ),
                    child: CupertinoTextField(
                      controller: _phoneCtrl,
                      placeholder: '+250.............',
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: _pay,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.primaryBrown,
                      ),
                      placeholderStyle: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.mediumBrown,
                      ),
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // PAY button
                  GestureDetector(
                    onTap: _isLoading ? null : _pay,
                    child: Container(
                      width: double.infinity,
                      height: 54,
                      decoration: BoxDecoration(
                        color: AppColors.darkBrown,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Center(
                        child: _isLoading
                            ? const CupertinoActivityIndicator(
                                color: AppColors.textOnDark, radius: 12)
                            : Text(
                                'PAY',
                                style: AppTextStyles.buttonLarge.copyWith(
                                  fontSize: 18,
                                  letterSpacing: 2,
                                ),
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
