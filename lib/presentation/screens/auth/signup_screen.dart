import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/validators.dart';
import '../../providers/auth_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  String? _usernameErr, _emailErr, _passwordErr, _confirmErr;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  bool _validate() {
    setState(() {
      _usernameErr = Validators.username(_usernameCtrl.text);
      _emailErr = Validators.email(_emailCtrl.text);
      _passwordErr = Validators.password(_passwordCtrl.text);
      _confirmErr =
          Validators.confirmPassword(_passwordCtrl.text)(_confirmCtrl.text);
    });

    return _usernameErr == null &&
        _emailErr == null &&
        _passwordErr == null &&
        _confirmErr == null;
  }

  Future<void> _handleSignUp() async {
    if (!_validate()) return;

    final success = await ref.read(authProvider.notifier).signUp(
          username: _usernameCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
        );

    if (success && mounted) context.go(AppRoutes.main);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final size = MediaQuery.of(context).size;

    return CupertinoPageScaffold(
      backgroundColor: AppColors.cream,
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

          // ── Diagonal cream overlay (bottom portion) ──
          Positioned.fill(
            child: ClipPath(
              clipper: _DiagonalClipper(
                diagonalStart: size.height * 0.55,
                diagonalEnd: size.height * 0.20,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(
                  color: const Color(0xFFE8D5B0).withOpacity(0.65),
                ),
              ),
            ),
          ),

          // ── Back button (top-left, over dark area) ──
          SafeArea(
            child: Column(
              children: [
                // Back button
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.sp16),
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF).withOpacity(0.18),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFFFFFFF).withOpacity(0.30),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          CupertinoIcons.back,
                          color: Color(0xFFFFFFFF),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),

                // ── Scrollable content ──
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.pagePaddingH,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: size.height * 0.12),

                        // "sign up" headline
                        Text(
                          'sign up',
                          style: AppTextStyles.displayMedium.copyWith(
                            color: const Color(0xFF3B1A08),
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),

                        const SizedBox(height: AppDimensions.sp4),

                        Text(
                          'Create your Bella Vita account',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: const Color(0xFF7A5230),
                          ),
                        ),

                        const SizedBox(height: AppDimensions.sp24),

                        // ── Username ──
                        _StyledField(
                          controller: _usernameCtrl,
                          placeholder: 'username',
                          icon: CupertinoIcons.person_fill,
                          errorText: _usernameErr,
                          onChanged: (_) =>
                              setState(() => _usernameErr = null),
                        ),

                        const SizedBox(height: AppDimensions.sp14),

                        // ── Email ──
                        _StyledField(
                          controller: _emailCtrl,
                          placeholder: 'Email',
                          icon: CupertinoIcons.mail_solid,
                          keyboardType: TextInputType.emailAddress,
                          errorText: _emailErr,
                          onChanged: (_) => setState(() => _emailErr = null),
                        ),

                        const SizedBox(height: AppDimensions.sp14),

                        // ── Password ──
                        _StyledField(
                          controller: _passwordCtrl,
                          placeholder: 'Password',
                          icon: CupertinoIcons.lock_fill,
                          obscureText: true,
                          errorText: _passwordErr,
                          onChanged: (_) =>
                              setState(() => _passwordErr = null),
                        ),

                        const SizedBox(height: AppDimensions.sp14),

                        // ── Confirm Password ──
                        _StyledField(
                          controller: _confirmCtrl,
                          placeholder: 'Confirm password',
                          icon: CupertinoIcons.lock_shield_fill,
                          obscureText: true,
                          errorText: _confirmErr,
                          onChanged: (_) =>
                              setState(() => _confirmErr = null),
                          onEditingComplete: _handleSignUp,
                        ),

                        const SizedBox(height: AppDimensions.sp28),

                        // ── SIGN UP button ──
                        GestureDetector(
                          onTap: authState.isLoading ? null : _handleSignUp,
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E0E00),
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF2E0E00).withOpacity(0.45),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Center(
                              child: authState.isLoading
                                  ? const CupertinoActivityIndicator(
                                      color: Color(0xFFFFFFFF),
                                    )
                                  : const Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        const SizedBox(height: AppDimensions.sp20),

                        // ── Already have account ──
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Text(
                            'already have account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF5C3317),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        const SizedBox(height: AppDimensions.sp12),

                        // ── OR divider ──
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: const Color(0xFF5C3317).withOpacity(0.30),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'or',
                                style: TextStyle(
                                  color: const Color(0xFF5C3317).withOpacity(0.70),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: const Color(0xFF5C3317).withOpacity(0.30),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppDimensions.sp16),

                        // ── Social login icons ──
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Facebook
                            _SocialButton(
                              onTap: () {},
                              child: Image.asset(
                                'assets/images/facebook_icon.png',
                                width: 24,
                                height: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Google
                            _SocialButton(
                              onTap: () {},
                              child: Image.asset(
                                'assets/images/google_icon.png',
                                width: 24,
                                height: 24,
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
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Diagonal clip: cream panel cuts in diagonally
// ─────────────────────────────────────────────
class _DiagonalClipper extends CustomClipper<Path> {
  final double diagonalStart;
  final double diagonalEnd;

  const _DiagonalClipper({
    required this.diagonalStart,
    required this.diagonalEnd,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, diagonalStart);
    path.lineTo(size.width, diagonalEnd);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_DiagonalClipper old) =>
      old.diagonalStart != diagonalStart || old.diagonalEnd != diagonalEnd;
}

// ─────────────────────────────────────────────
//  Styled input field matching the design
// ─────────────────────────────────────────────
class _StyledField extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;
  final IconData icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;

  const _StyledField({
    required this.controller,
    required this.placeholder,
    required this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.errorText,
    this.onChanged,
    this.onEditingComplete,
  });

  @override
  State<_StyledField> createState() => _StyledFieldState();
}

class _StyledFieldState extends State<_StyledField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 54,
          decoration: BoxDecoration(
            color: const Color(0xFFEDD9B0).withOpacity(0.75),
            borderRadius: BorderRadius.circular(30),
            border: widget.errorText != null
                ? Border.all(color: CupertinoColors.destructiveRed, width: 1.2)
                : null,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3B1A08).withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 18),
              Icon(
                widget.icon,
                color: const Color(0xFF5C3317),
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CupertinoTextField(
                  controller: widget.controller,
                  placeholder: widget.placeholder,
                  placeholderStyle: const TextStyle(
                    color: Color(0xFF9B7A55),
                    fontSize: 15,
                  ),
                  style: const TextStyle(
                    color: Color(0xFF2E0E00),
                    fontSize: 15,
                  ),
                  obscureText: _obscure,
                  keyboardType: widget.keyboardType,
                  onChanged: widget.onChanged,
                  onEditingComplete: widget.onEditingComplete,
                  decoration: null,
                  padding: EdgeInsets.zero,
                ),
              ),
              if (widget.obscureText) ...[
                GestureDetector(
                  onTap: () => setState(() => _obscure = !_obscure),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(
                      _obscure
                          ? CupertinoIcons.eye_slash
                          : CupertinoIcons.eye,
                      color: const Color(0xFF9B7A55),
                      size: 18,
                    ),
                  ),
                ),
              ] else
                const SizedBox(width: 16),
            ],
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              widget.errorText!,
              style: const TextStyle(
                color: CupertinoColors.destructiveRed,
                fontSize: 11,
              ),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Social login circle button
// ─────────────────────────────────────────────
class _SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const _SocialButton({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFEDD9B0).withOpacity(0.80),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3B1A08).withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}