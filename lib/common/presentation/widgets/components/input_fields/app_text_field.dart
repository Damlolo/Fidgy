import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../presentation.dart';import '../buttons_and_ctas/app_mini_button_widget.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.isRequired = false,
    this.focusNode,
    this.onChanged,
    this.onFocusChange,
    this.onTap,
    this.onEditComplete,
    this.validator,
    this.validatorMode = AutovalidateMode.disabled,
    this.prefixText,
    this.prefix,
    this.suffix,
    this.keyboardType = TextInputType.text,
    this.keyboardAction = TextInputAction.next,
    this.capitalization = TextCapitalization.sentences,
    this.keyboardPadding = 40,
    this.enabled = true,
    this.formatters,
  })  : _isSecret = false,
        obscuringCharacter = '*';

  const AppTextField.secret({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.isRequired = false,
    this.focusNode,
    this.onChanged,
    this.onFocusChange,
    this.onTap,
    this.onEditComplete,
    this.validator,
    this.validatorMode = AutovalidateMode.disabled,
    this.prefixText,
    this.prefix,
    this.keyboardType = TextInputType.text,
    this.keyboardAction = TextInputAction.next,
    this.capitalization = TextCapitalization.none,
    this.keyboardPadding = 40,
    this.enabled = true,
    this.formatters,
    this.obscuringCharacter = '•',
  })  : _isSecret = true,
        suffix = null;

  final String? label;
  final String? hint;
  final bool isRequired;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onFocusChange;
  final VoidCallback? onTap;
  final VoidCallback? onEditComplete;
  final AutovalidateMode validatorMode;
  final String? Function(String)? validator;
  final String? prefixText;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType keyboardType;
  final TextInputAction keyboardAction;
  final TextCapitalization capitalization;
  final double keyboardPadding;
  final bool enabled;
  final List<TextInputFormatter>? formatters;
  final String obscuringCharacter;
  final bool _isSecret;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final FocusNode _focusNode;
  late bool _visible;

  @override
  void initState() {
    _visible = !widget._isSecret;
    _focusNode = widget.focusNode ?? FocusNode();
    final focusChangeCallback = widget.onFocusChange;
    if (focusChangeCallback != null) {
      _focusNode.addListener(() => focusChangeCallback(_focusNode.hasFocus));
    }
    super.initState();
  }

  void _toggleVisibility() {
    setState(() {
      _visible = !_visible;
    });
  }

  String? _validator(String? value) {
    final hasValidator = widget.validator != null;
    String? error;
    if (!hasValidator &&
        widget.isRequired &&
        (value == null || value.isEmpty)) {
      if (widget.label != null) {
        error = '${widget.label} is required';
      } else {
        error = 'This field is required';
      }
    }

    if (hasValidator) {
      error = widget.validator!(value ?? '');
    }

    return error;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final styles = AppStyles.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              widget.label!,
              style: styles.label14Regular.copyWith(color: colors.textMute),
            ),
          ),
        TextFormField(
          focusNode: _focusNode,
          enabled: widget.enabled,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          textInputAction: widget.keyboardAction,
          textCapitalization: widget.capitalization,
          obscureText: !_visible,
          obscuringCharacter: widget.obscuringCharacter,
          scrollPadding: EdgeInsets.only(bottom: widget.keyboardPadding),
          validator: _validator,
          autovalidateMode: widget.validatorMode,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          onEditingComplete:
              widget.onEditComplete ?? () => FocusScope.of(context).nextFocus(),
          style: styles.value16Medium,
          inputFormatters: widget.formatters,
          textAlignVertical: TextAlignVertical.center,
          cursorColor: AppColors.of(context).textStrong,
          cursorWidth: 1,
          decoration: InputDecoration(
            isDense: false,
            hintText: widget.hint,
            hintMaxLines: 1,
            prefixText:
                widget.prefixText != null ? '${widget.prefixText} ' : null,
            prefixIcon: widget.prefix == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.prefix!,
                      ],
                    ),
                  ),
            suffixIcon: !widget._isSecret && widget.suffix == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(right: 16, left: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget._isSecret)
                          ExcludeFocus(
                            child: AppMiniButton(
                              label: _visible ? 'Hide' : 'Show',
                              onPressed: _toggleVisibility,
                            ),
                          )
                        else
                          widget.suffix!,
                      ],
                    ),
                  ),
            contentPadding: const EdgeInsets.all(16),
            errorStyle: styles.body14Medium.copyWith(
              color: colors.attitudeErrorMain,
              height: 1,
            ),
            hintStyle: styles.value16Medium.copyWith(
              color: colors.textMute,
            ),
            prefixStyle: styles.value16Medium.copyWith(
              color: colors.textMute,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.of(context).grey4,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.of(context).grey4,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: AppColors.of(context).primaryColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: AppColors.of(context).attitudeErrorMain,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: AppColors.of(context).attitudeErrorMain,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
