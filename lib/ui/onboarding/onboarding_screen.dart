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
    print(viewModel.onBoardings.length);
    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: SizedBox(
              width: 1170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => RenderConditional(
                      conditional: viewModel.selectedIndex != viewModel.onBoardings.length - 1,
                      widget1: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'skip'.tr,
                            style: Theme.of(context).textTheme.displaySmall!
                                .copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                          ),
                        ),
                      ),
                      widget2: SizedBox(),
                    ),
                  ),

                  SizedBox(
                    height: 400,
                    child: Obx(
                      () => PageView.builder(
                        itemCount: viewModel.onBoardings.length,
                        controller: _pageController,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(30),
                            child: Image.asset(viewModel.onBoardings[index].imageUrl),
                          );
                        },
                        onPageChanged: (index) => viewModel.changeSelectIndex(index),
                      ),
                    ),
                  ),

                  Column(
                    children: [
                      Obx(() => Row(mainAxisAlignment: MainAxisAlignment.center, children: _pageIndicators(context))),
                      Padding(
                        padding: const EdgeInsets.only(left: 60, right: 60, top: 50, bottom: 22),
                        child: Obx(
                          () => Text(
                            viewModel.title,
                            style: Theme.of(context).textTheme.displaySmall!
                                .copyWith(fontSize: 24.0, color: Theme.of(context).textTheme.bodyLarge!.color),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppDimens.fontSizeLarge),
                        child: Obx(
                          () => Text(
                            viewModel.description,
                            style: Theme.of(context).textTheme.displayMedium!
                                .copyWith(fontSize: AppDimens.fontSizeLarge, color: AppColors.gray),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(viewModel.selectedIndex == 2 ? 0 : 22),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => RenderConditional(
                                conditional: viewModel.selectedIndex == 0 || viewModel.selectedIndex == 2,
                                widget1: SizedBox.shrink(),
                                widget2: TextButton(
                                  onPressed: () {
                                    _pageController.previousPage(duration: Duration(seconds: 1), curve: Curves.ease);
                                  },
                                  child: Text(
                                    'previous'.tr,
                                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColors.gray),
                                  ),
                                ),
                              ),
                            ),

                            Obx(
                              () => RenderConditional(
                                conditional: viewModel.selectedIndex == 2,
                                widget1: SizedBox.shrink(),
                                widget2: TextButton(
                                  onPressed: () {
                                    _pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.ease);
                                  },
                                  child: Text(
                                    'next'.tr,
                                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColors.gray),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => RenderConditional(
                          conditional: viewModel.selectedIndex == 2,
                          widget1: Padding(
                            padding: EdgeInsets.all(AppDimens.fontSizeLarge),
                            child: CustomButton(
                              btnTxt: 'lets_start'.tr,
                              onTap: () {
                                // Navigator.pushReplacementNamed(context, Routes.getWelcomeRoute());
                              },
                            ),
                          ),
                          widget2: SizedBox.shrink(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _pageIndicators(BuildContext context) {
    final List<Container> _indicators = [];

    for (int i = 0; i < viewModel.onBoardings.length; i++) {
      _indicators.add(
        Container(
          width: i == viewModel.selectedIndex ? 16 : 7,
          height: 7,
          margin: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: i == viewModel.selectedIndex ? Theme.of(context).primaryColor : AppColors.gray,
            borderRadius: i == viewModel.selectedIndex ? BorderRadius.circular(50) : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return _indicators;
  }
}
