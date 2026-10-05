import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String btnTxt;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  const CustomButton({super.key, this.onTap, required this.btnTxt, this.backgroundColor, this.textStyle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final buttonStyle = TextButton.styleFrom(
      backgroundColor: onTap == null ? AppColors.grey : backgroundColor ?? theme.primaryColor,
      minimumSize: const Size.fromHeight(50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );

    return TextButton(
      onPressed: onTap,
      style: buttonStyle,
      child: Text(
        btnTxt,
        style:
            textStyle ??
            theme.textTheme.titleLarge?.copyWith(color: AppColors.white, fontSize: AppDimens.fontSizeLarge),
      ),
    );
  }
}
