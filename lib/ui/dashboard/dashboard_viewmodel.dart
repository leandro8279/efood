import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DashboardViewModel() extends GetxController {
  final _pageIndex = 0.obs;
  late PageController _pageController;

  int get pageIndex => _pageIndex.value;
  PageController get pageController => _pageController;

  void setPage(int value) => _pageIndex.value = value;

  bool handleOnBack() {
    if (_pageIndex.value != 0) {
      _pageController.jumpToPage(pageIndex);
      _pageIndex.value = pageIndex;
      return false;
    } else {
      return true;
    }
  }

  @override
  void onInit() {
    super.onInit();

    // if (_configRepository.config.policyModel == null) {
    //   Provider.of<SplashProvider>(context, listen: false).getPolicyPage(context);
    // }

    // Provider.of<OrderProvider>(context, listen: false).changeStatus(true);
    _pageIndex.value = int.tryParse(Get.parameters['pageIndex'] ?? '') ?? 0;
    _pageController = PageController(initialPage: _pageIndex.value);
  }
}
