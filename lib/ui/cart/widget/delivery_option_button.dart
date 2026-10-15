import 'package:efood/ui/core/share/render_conditional.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:efood/utils/price_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const DeliveryOptionButton({
  super.key,
  required final String value,
  required final String title,
  required final bool kmWiseFee,
  required final String orderType,
  required final void Function(String value) setOrderType,
}) extends StatelessWidget {
  ConfigNotifier get _configNotifier => Get.find<ConfigNotifier>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setOrderType(value),
      child: Row(
        children: [
          RadioGroup(
            groupValue: orderType,
            onChanged: (String? value) {
              if (value != null) {
                setOrderType(value);
              }
            },
            child: Radio(value: value, activeColor: Theme.of(context).primaryColor),
          ),
          SizedBox(width: AppDimens.paddingSmall),

          Text(title, style: AppTextStyles.rubikRegular),
          SizedBox(width: 5),

          Obx(
            () => RenderConditional(
              conditional: kmWiseFee,
              widget1: SizedBox(),
              widget2: Text(
                '(${value == 'delivery' ? PriceConverter.convertPrice(price: _configNotifier.config.value!.deliveryCharge, config: _configNotifier.config.value) : 'free'.tr})',
                style: AppTextStyles.rubikMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
