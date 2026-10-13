import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';

class const FilterButtonWidget({
  super.key,
  required final String type,
  required final Function(String value) onSelected,
  required final List<String> items,
  final bool isBorder = false,
  final bool isSmall = false,
}) extends StatelessWidget {
  final TODO = "";
  // final bool _ltr = Provider.of<LocalizationProvider>(context).isLtr;
  bool get ltr => true;
  bool get isVegFilter => true;
  // bool _isVegFilter = Provider.of<ProductProvider>(context).productTypeList == items;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 35,
        margin: EdgeInsets.symmetric(vertical: AppDimens.paddingSmall),
        decoration: isBorder
            ? null
            : BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(AppDimens.radiusSmall)),
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => onSelected(items[index]),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingDefault),
                margin: isBorder ? EdgeInsets.symmetric(horizontal: AppDimens.paddingExtraSmall) : EdgeInsets.zero,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: isBorder
                      ? BorderRadius.all(Radius.circular(AppDimens.radiusSmall))
                      : BorderRadius.horizontal(
                          left: Radius.circular(
                            ltr
                                ? index == 0 && items[index] != type
                                      ? AppDimens.radiusSmall
                                      : 0
                                : index == items.length - 1
                                ? AppDimens.radiusSmall
                                : 0,
                          ),
                          right: Radius.circular(
                            ltr
                                ? index == items.length - 1 && items[index] != type
                                      ? AppDimens.radiusSmall
                                      : 0
                                : index == 0
                                ? AppDimens.radiusSmall
                                : 0,
                          ),
                        ),
                  color: items[index] == type ? Theme.of(context).primaryColor : Theme.of(context).canvasColor,

                  border: isBorder
                      ? Border.all(width: 1.3, color: Theme.of(context).primaryColor.withOpacity(0.4))
                      : null,
                ),
                child: Row(
                  children: [
                    RenderConditional(
                      conditional: items[index] != items[0] && isVegFilter,
                      widget1: Padding(
                        padding: EdgeInsets.all(AppDimens.paddingSmall),
                        child: Image.asset(AppAssets.images.getImageUrl(items[index])),
                      ),
                      widget2: SizedBox(),
                    ),
                    Text(
                      items[index],
                      style: items[index] == type
                          ? AppTextStyles.robotoRegular.copyWith(fontSize: AppDimens.fontSizeSmall, color: Colors.white)
                          : AppTextStyles.robotoRegular.copyWith(
                              fontSize: AppDimens.fontSizeDefault,
                              color: Theme.of(context).hintColor,
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
