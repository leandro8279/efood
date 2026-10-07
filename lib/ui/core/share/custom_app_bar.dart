import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonExist;
  final VoidCallback? onBackPressed;
  final BuildContext context;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isBackButtonExist = true,
    this.onBackPressed,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.rubikMedium.copyWith(
          fontSize: AppDimens.fontSizeLarge,
          color: AppTextStyles.bodyText1().color,
        ),
      ),
      centerTitle: true,
      leading: isBackButtonExist
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: AppTextStyles.bodyText1().color,
              onPressed: () => onBackPressed != null ? onBackPressed!() : Navigator.pop(context),
            )
          : SizedBox(),
      backgroundColor: Theme.of(context).cardColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 50);
}
