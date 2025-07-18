import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay_project/app/app_colors.dart';
import 'package:crafty_bay_project/app/asset_paths.dart';
import 'package:crafty_bay_project/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:crafty_bay_project/features/product/ui/screens/product_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/ui/widgets/product_card.dart';
import '../../widgets/app_bar_icon_button.dart';
import '../../widgets/home_carousel_slider.dart';
import '../../../common/ui/widgets/product_category_item.dart';
import '../../widgets/product_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static final String name = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              ProductSearchBar(),
              const SizedBox(height: 16),
              HomeCarouselSlider(),
              const SizedBox(height: 16),
              _buildSectionHeader(
                title: "All Categories",
                onTapSeeAll: () {
                  Get.find<MainBottomNavController>().moveToCategory();
                },
              ),
              const SizedBox(height: 8),
              _getCategoryList(),
              _buildSectionHeader(title: "Popular", onTapSeeAll: () {}),
              _getPopularProducts(),
              _buildSectionHeader(title: "Special", onTapSeeAll: () {}),
              _getSpecialProducts(),
              _buildSectionHeader(title: "New", onTapSeeAll: () {}),
              _getNewProducts(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPopularProducts() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8,
        children: [1, 2, 3, 4].map((e) => ProductCard()).toList(),
      ),
    );
  }

  Widget _getSpecialProducts() {
    return SizedBox(
      height: 185,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return ProductCard();
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 8);
        },
      ),
    );
  }

  Widget _getNewProducts() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8,
        children: [1, 2, 3, 4].map((e) => ProductCard()).toList(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: SvgPicture.asset(AssetPaths.navAppLogoSvg),
      actions: [
        AppBarIconButton(onTap: () {}, iconData: Icons.person),
        AppBarIconButton(onTap: () {}, iconData: Icons.call),
        AppBarIconButton(onTap: () {}, iconData: Icons.notifications),
      ],
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required VoidCallback onTapSeeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        TextButton(onPressed: onTapSeeAll, child: Text("See All")),
      ],
    );
  }

  Widget _getCategoryList() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ProductCategoryItem();
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8),
      ),
    );
  }
}
