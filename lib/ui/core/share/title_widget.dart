import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const TitleWidget({super.key, required final String title, final Function()? onTap}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.rubikMedium),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
            child: Text(
              'view_all'.tr,
              style: AppTextStyles.rubikRegular.copyWith(
                fontSize: AppDimens.fontSizeSmall,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
