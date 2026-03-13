import 'package:flutter/cupertino.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;
  final IconData? prefixIcon;
  final bool obscureText;
  final bool showToggle;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;

  const AppTextField({
    super.key,
    required this.controller,
    required this.placeholder,
    this.prefixIcon,
    this.obscureText = false,
    this.showToggle = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.errorText,
    this.onChanged,
    this.onEditingComplete,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isObscured = true;
  bool _isFocused = false;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
    _focusNode = FocusNode()
      ..addListener(() {
        setState(() => _isFocused = _focusNode.hasFocus);
      });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: AppColors.inputFill,
            borderRadius: BorderRadius.circular(AppDimensions.radius14),
            border: Border.all(
              color: hasError
                  ? AppColors.error
                  : _isFocused
                      ? AppColors.primaryBrown
                      : CupertinoColors.transparent,
              width: 1.5,
            ),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: AppColors.primaryBrown.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]
                : null,
          ),
          child: Row(
            children: [
              if (widget.prefixIcon != null)
                Padding(
                  padding: EdgeInsets.only(left: AppDimensions.sp16),
                  child: Icon(
                    widget.prefixIcon,
                    size: AppDimensions.iconSize,
                    color: _isFocused
                        ? AppColors.primaryBrown
                        : AppColors.textTertiary,
                  ),
                ),
              Expanded(
                child: CupertinoTextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  placeholder: widget.placeholder,
                  obscureText:
                      widget.showToggle ? _isObscured : widget.obscureText,
                  keyboardType: widget.keyboardType,
                  textInputAction: widget.textInputAction,
                  onChanged: widget.onChanged,
                  onEditingComplete: widget.onEditingComplete,
                  placeholderStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  decoration: const BoxDecoration(),
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.prefixIcon != null
                        ? AppDimensions.sp8
                        : AppDimensions.sp16,
                    vertical: AppDimensions.sp14,
                  ),
                ),
              ),
              if (widget.showToggle)
                GestureDetector(
                  onTap: () => setState(() => _isObscured = !_isObscured),
                  child: Padding(
                    padding: EdgeInsets.only(right: AppDimensions.sp16),
                    child: Icon(
                      _isObscured
                          ? CupertinoIcons.eye_slash
                          : CupertinoIcons.eye,
                      size: AppDimensions.iconSize,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (hasError) ...[
          SizedBox(height: AppDimensions.sp4),
          Padding(
            padding: EdgeInsets.only(left: AppDimensions.sp4),
            child: Text(
              widget.errorText!,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ],
    );
  }
}