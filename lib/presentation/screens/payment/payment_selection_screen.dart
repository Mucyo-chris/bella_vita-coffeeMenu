import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/responsive.dart';

class PaymentSelectionScreen extends StatelessWidget {
  final double total;
  const PaymentSelectionScreen({super.key, this.total = 0.0});

  @override
  Widget build(BuildContext context) {
    final r = context.r;

    return CupertinoPageScaffold(
      backgroundColor: AppColors.cream,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background ───────────────────────────────────
          Positioned.fill(
            child: Image.asset(
              'assets/images/beans.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: AppColors.beige),
            ),
          ),
          Positioned.fill(
            child: Container(color: AppColors.cream.withOpacity(0.85)),
          ),

          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: r.maxContentWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ── Back ─────────────────────────────
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(r.sp(16)),
                        child: GestureDetector(
                          onTap: () => context.pop(),
                          child: Container(
                            width: r.sp(40),
                            height: r.sp(40),
                            decoration: BoxDecoration(
                              color: AppColors.cream.withOpacity(0.9),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryBrown
                                      .withOpacity(0.12),
                                  blurRadius: 8,
                                )
                              ],
                            ),
                            child: Icon(CupertinoIcons.back,
                                color: AppColors.primaryBrown,
                                size: r.fs(20)),
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    // ── MOMO + AIRTEL row ─────────────────
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: r.pagePadH),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // MOMO — uses momo.png logo
                          _PayMethodTile(
                            label: 'MOMO',
                            color: const Color(0xFF003580),
                            size: r.payLogoSize,
                            onTap: () => context.push(
                                AppRoutes.momoPayment,
                                extra: total),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  r.payLogoSize * 0.5),
                              child: Image.asset(
                                'assets/images/momo.png',
                                width: r.payLogoSize,
                                height: r.payLogoSize,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Text(
                                  '▲',
                                  style: TextStyle(
                                    color: const Color(0xFFFFCC00),
                                    fontSize: r.fs(44),
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // AIRTEL — keeps italic 'a' symbol
                          _PayMethodTile(
                            label: 'AIRTEL',
                            color: const Color(0xFFE4002B),
                            size: r.payLogoSize,
                            onTap: () => context.push(
                                AppRoutes.airtelPayment,
                                extra: total),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'a',
                                  style: TextStyle(
                                    color: CupertinoColors.white,
                                    fontSize: r.fs(52),
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                Text(
                                  'airtel\nmoney',
                                  style: TextStyle(
                                    color: CupertinoColors.white,
                                    fontSize: r.fs(11),
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: r.sp(48)),

                    // ── PAY button ────────────────────────
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: r.pagePadH),
                      child: GestureDetector(
                        onTap: () => context.push(
                            AppRoutes.momoPayment,
                            extra: total),
                        child: Container(
                          width: double.infinity,
                          height: r.buttonHeight,
                          decoration: BoxDecoration(
                            color: AppColors.darkBrown,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Center(
                            child: Text(
                              'PAY',
                              style: AppTextStyles.buttonLarge.copyWith(
                                fontSize: r.fs(18),
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: r.sp(28)),

                    // ── Other payments ────────────────────
                    GestureDetector(
                      onTap: () => context.push(
                          AppRoutes.cardPayment,
                          extra: total),
                      child: Text(
                        'other payments',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primaryBrown,
                          fontSize: r.fs(14),
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryBrown,
                        ),
                      ),
                    ),

                    SizedBox(height: r.sp(48)),
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

// ── Shared tile wrapper ───────────────────────────────────────────
class _PayMethodTile extends StatelessWidget {
  final String label;
  final Color color;
  final double size;
  final VoidCallback onTap;
  final Widget child;

  const _PayMethodTile({
    required this.label,
    required this.color,
    required this.size,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(size * 0.2),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            child: Center(child: child),
          ),
          SizedBox(height: r.sp(14)),
          Text(
            label,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.primaryBrown,
              fontWeight: FontWeight.w800,
              fontSize: r.fs(14),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}