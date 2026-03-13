import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';

class CardPaymentScreen extends StatefulWidget {
  final double total;
  const CardPaymentScreen({super.key, this.total = 0.0});

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  final _nameCtrl   = TextEditingController();
  final _cardCtrl   = TextEditingController();
  final _expiryCtrl = TextEditingController();
  final _cvvCtrl    = TextEditingController();
  bool _isLoading   = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _cardCtrl.dispose();
    _expiryCtrl.dispose();
    _cvvCtrl.dispose();
    super.dispose();
  }

  Future<void> _pay() async {
    if (_nameCtrl.text.isEmpty ||
        _cardCtrl.text.isEmpty ||
        _expiryCtrl.text.isEmpty ||
        _cvvCtrl.text.isEmpty) return;
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
          // Background coffee image
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 20),
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

                    // Card brands
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.beige.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryBrown.withOpacity(0.1),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Card logos
                          Row(
                            children: [
                              _CardBadge(
                                color: const Color(0xFF1A1F71),
                                textColor: CupertinoColors.white,
                                text: 'VISA',
                                bold: true,
                              ),
                              const SizedBox(width: 8),
                              _MastercardBadge(),
                              const SizedBox(width: 8),
                              _CardBadge(
                                color: const Color(0xFF016FD0),
                                textColor: CupertinoColors.white,
                                text: 'American\npayment',
                                small: true,
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Name on card
                          Text(
                            'Name on card',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primaryBrown,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _CardField(
                            controller: _nameCtrl,
                            placeholder: '• • • • • • • • • • • • • • • • • • • •',
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                          ),

                          const SizedBox(height: 24),

                          Text(
                            'card number',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primaryBrown,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _CardField(
                            controller: _cardCtrl,
                            placeholder: '• • • • • • • • • • • • • • • • • • • •',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(16),
                            ],
                          ),

                          const SizedBox(height: 24),

                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Expiry date',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: AppColors.primaryBrown,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'format is MM/YY',
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    _CardField(
                                      controller: _expiryCtrl,
                                      placeholder: '• • • • • • •',
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(4),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Security code',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: AppColors.primaryBrown,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '3 or 4 digit code on your card',
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    _CardField(
                                      controller: _cvvCtrl,
                                      placeholder: '• • • • • • •',
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      obscureText: true,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(4),
                                      ],
                                      onEditingComplete: _pay,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // PAY
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
                                    fontSize: 20,
                                    letterSpacing: 3,
                                    fontWeight: FontWeight.w900,
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
          ),
        ],
      ),
    );
  }
}

class _CardField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onEditingComplete;

  const _CardField({
    required this.controller,
    required this.placeholder,
    required this.keyboardType,
    required this.textInputAction,
    this.obscureText = false,
    this.inputFormatters,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(10),
      ),
      child: CupertinoTextField(
        controller: controller,
        placeholder: placeholder,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        onEditingComplete: onEditingComplete,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.primaryBrown,
        ),
        placeholderStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.lightBrown.withOpacity(0.7),
          letterSpacing: 2,
        ),
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}

class _CardBadge extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  final bool bold;
  final bool small;

  const _CardBadge({
    required this.color,
    required this.textColor,
    required this.text,
    this.bold = false,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: small ? 6 : 10, vertical: small ? 4 : 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: small ? 9 : 13,
          fontWeight: bold ? FontWeight.w900 : FontWeight.w600,
          letterSpacing: bold ? 1 : 0,
          height: 1.2,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _MastercardBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 28,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Color(0xFFEB001B),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Color(0xFFF79E1B),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
