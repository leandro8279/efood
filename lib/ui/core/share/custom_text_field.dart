import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.hintText = 'Write something...',
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.onSuffixTap,
    this.fillColor,
    this.onSubmit,
    this.onChanged,
    this.capitalization = TextCapitalization.none,
    this.isCountryPicker = false,
    this.isShowBorder = false,
    this.isShowSuffixIcon = false,
    this.isShowPrefixIcon = false,
    this.onTap,
    this.isIcon = false,
    this.isPassword = false,
    this.suffixIconUrl,
    this.prefixIconUrl,
    this.isSearch = false,
    this.inputDecoration,
  });

  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final Color? fillColor;
  final int maxLines;
  final bool isPassword;
  final bool isCountryPicker;
  final bool isShowBorder;
  final bool isIcon;
  final bool isShowSuffixIcon;
  final bool isShowPrefixIcon;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSuffixTap;
  final String? suffixIconUrl;
  final String? prefixIconUrl;
  final bool isSearch;
  final ValueChanged<String>? onSubmit;
  final bool isEnabled;
  final TextCapitalization capitalization;
  final InputDecoration? inputDecoration;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return TextField(
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: textTheme.titleMedium?.copyWith(color: textTheme.bodyMedium?.color, fontSize: 16),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: theme.primaryColor,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      autofocus: false,
      obscureText: widget.isPassword && _obscureText,
      inputFormatters: widget.inputType == TextInputType.phone
          ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9+]'))]
          : null,
      decoration:
          widget.inputDecoration ??
          InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
            isDense: true,
            hintText: widget.hintText,
            fillColor: widget.fillColor ?? theme.cardColor,
            hintStyle: textTheme.bodyMedium?.copyWith(fontSize: AppDimens.fontSizeSmall, color: AppColors.greyChateau),
            filled: true,
            prefixIcon: widget.isShowPrefixIcon && widget.prefixIconUrl != null
                ? Padding(
                    padding: const EdgeInsets.only(left: AppDimens.paddingLarge, right: AppDimens.paddingLarge),
                    child: Image.asset(widget.prefixIconUrl!),
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(minWidth: 23, maxHeight: 20),
            suffixIcon: _buildSuffixIcon(context),
          ),
      onTap: widget.onTap,
      onSubmitted: _onSubmitted,
      onChanged: widget.onChanged,
    );
  }

  Widget? _buildSuffixIcon(BuildContext context) {
    if (!widget.isShowSuffixIcon) {
      return null;
    }

    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Theme.of(context).hintColor.withAlpha(77),
        ),
        onPressed: _toggle,
      );
    }

    if (widget.isIcon && widget.suffixIconUrl != null) {
      return IconButton(
        onPressed: widget.onSuffixTap,
        icon: Image.asset(
          widget.suffixIconUrl!,
          width: 15,
          height: 15,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      );
    }

    return null;
  }

  void _onSubmitted(String text) {
    if (widget.nextFocus != null) {
      FocusScope.of(context).requestFocus(widget.nextFocus);
      return;
    }

    widget.onSubmit?.call(text);
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
