import 'package:efood/ui/core/share/render_conditional.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/ui/dashboard/dashboard_viewmodel.dart';
import 'package:efood/ui/home/home_screen.dart';
import 'package:efood/utils/network_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const DashboardScreen({super.key, required final DashboardViewModel viewModel}) extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<Widget> _screens;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _screens = [
      HomeScreen(result: true),
      // CartScreen(),
      // OrderScreen(),
      // WishListScreen(),
      // MenuScreen(
      //   onTap: (int pageIndex) {
      //     _setPage(pageIndex);
      //   },
      // ),
    ];

    NetworkInfo.checkConnectivity(_scaffoldKey);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {},
      child: Obx(
        () => Scaffold(
          key: _scaffoldKey,
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: AppColors.grey,
            showUnselectedLabels: true,
            currentIndex: widget.viewModel.pageIndex,
            type: BottomNavigationBarType.fixed,

            items: [
              _barItem(Icons.home, 'home'.tr, 0),
              _barItem(Icons.shopping_cart, 'cart'.tr, 1),
              _barItem(Icons.shopping_bag, 'order'.tr, 2),
              _barItem(Icons.favorite, 'favourite'.tr, 3),
              _barItem(Icons.menu, 'menu'.tr, 4),
            ],
            onTap: widget.viewModel.setPage,
          ),

          body: PageView.builder(
            itemCount: _screens.length,
            controller: widget.viewModel.pageController,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => _screens[index],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Obx(
            () => Icon(
              icon,
              color: index == widget.viewModel.pageIndex ? Theme.of(context).primaryColor : AppColors.gray,
              size: 25,
            ),
          ),
          RenderConditional(
            conditional: index == 1,
            widget1: Positioned(
              top: -7,
              right: -7,
              child: Container(
                padding: EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                child: Text('10', style: AppTextStyles.rubikMedium.copyWith(color: AppColors.white, fontSize: 8)),
              ),
            ),
            widget2: SizedBox(),
          ),
        ],
      ),
      label: label,
    );
  }
}
