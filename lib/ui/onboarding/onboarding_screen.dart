import 'package:efood/routing/app_routes.dart';
import 'package:efood/ui/core/share/custom_button.dart';
import 'package:efood/ui/core/share/render_conditional.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/ui/onboarding/onboarding_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen({super.key, required final OnBoardingViewModel viewModel}) extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Scrollbar(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: SizedBox(
                  width: 1170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RenderConditional(
                        conditional: viewModel.selectedIndex != viewModel.onBoardings.length - 1,
                        widget1: Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () => Get.offAllNamed(AppRoutes.welcome),
                            child: Text('skip'.tr, style: AppTextStyles.headline3()),
                          ),
                        ),
                        widget2: SizedBox(),
                      ),

                      SizedBox(
                        height: 400,
                        child: PageView.builder(
                          itemCount: viewModel.onBoardings.length,
                          controller: _pageController,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: .all(30),
                              child: Image.asset(viewModel.onBoardings[index].imageAsset),
                            );
                          },
                          onPageChanged: (index) => viewModel.changeSelectIndex(index),
                        ),
                      ),

                      Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: _pageIndicators(context)),
                          Padding(
                            padding: .only(left: 60, right: 60, top: 50, bottom: 22),
                            child: Text(
                              viewModel.currentSlide.titleKey.tr,
                              style: AppTextStyles.headline3(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: .symmetric(horizontal: AppDimens.fontSizeLarge),
                            child: Text(
                              viewModel.currentSlide.descriptionKey.tr,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.headline2(color: AppColors.gray),
                            ),
                          ),
                          Container(
                            padding: .all(viewModel.selectedIndex == 2 ? 0 : 22),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RenderConditional(
                                  conditional: viewModel.selectedIndex == 0 || viewModel.selectedIndex == 2,
                                  widget1: SizedBox.shrink(),
                                  widget2: TextButton(
                                    onPressed: () {
                                      _pageController.previousPage(duration: Duration(seconds: 1), curve: Curves.ease);
                                    },
                                    child: Text('previous'.tr, style: AppTextStyles.headline3(color: AppColors.gray)),
                                  ),
                                ),

                                RenderConditional(
                                  conditional: viewModel.selectedIndex == 2,
                                  widget1: SizedBox.shrink(),
                                  widget2: TextButton(
                                    onPressed: () {
                                      _pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.ease);
                                    },
                                    child: Text('next'.tr, style: AppTextStyles.headline3(color: AppColors.gray)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RenderConditional(
                            conditional: viewModel.selectedIndex == 2,
                            widget1: Padding(
                              padding: .all(AppDimens.fontSizeLarge),
                              child: CustomButton(
                                btnTxt: 'lets_start'.tr,
                                onTap: () => Get.offAllNamed(AppRoutes.welcome),
                                // Navigator.pushReplacementNamed(context, Routes.getWelcomeRoute());
                              ),
                            ),
                            widget2: SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ),
      ),
    );
  }

  List<Widget> _pageIndicators(BuildContext context) {
    final List<Container> indicators = [];

    for (int i = 0; i < viewModel.onBoardings.length; i++) {
      indicators.add(
        Container(
          width: i == viewModel.selectedIndex ? 16 : 7,
          height: 7,
          margin: .only(right: 5),
          decoration: BoxDecoration(
            color: i == viewModel.selectedIndex ? Theme.of(context).primaryColor : AppColors.gray,
            borderRadius: i == viewModel.selectedIndex ? BorderRadius.circular(50) : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return indicators;
  }
}
