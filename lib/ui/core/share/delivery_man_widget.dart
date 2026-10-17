import 'package:efood/domain/models/order/delivery_man.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const DeliveryManWidget({super.key, final DeliveryMan? deliveryMan}) extends StatelessWidget {
  ConfigNotifier get _configNotifier => Get.find<ConfigNotifier>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(AppDimens.paddingSmall),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Get.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('delivery_man'.tr, style: AppTextStyles.rubikRegular.copyWith(fontSize: AppDimens.fontSizeExtraSmall)),
            ListTile(
              leading: ClipOval(
                child: FadeInImage.assetNetwork(
                  placeholder: AppAssets.images.placeholderUser,
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                  image: '${_configNotifier.config.value!.baseUrls.deliveryManImageUrl}/${deliveryMan!.image}',
                  imageErrorBuilder: (c, o, s) =>
                      Image.asset(AppAssets.images.placeholderUser, height: 40, width: 40, fit: BoxFit.cover),
                ),
              ),
              title: Text(
                '${deliveryMan!.fName} ${deliveryMan!.lName}',
                style: AppTextStyles.rubikRegular.copyWith(fontSize: AppDimens.fontSizeLarge),
              ),
              subtitle: RatingBar(
                rating: deliveryMan!.rating.isNotEmpty ? double.parse(deliveryMan!.rating[0].average) : 0,
                size: 15,
              ),
              trailing: InkWell(
                onTap: () {
                  // launchUrl(Uri.parse('tel:${deliveryMan.phone}'))
                },
                child: Container(
                  padding: EdgeInsets.all(AppDimens.paddingExtraSmall),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.getSearchBg()),
                  child: Icon(Icons.call_outlined),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
