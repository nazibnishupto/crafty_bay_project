import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/ui/controllers/main_bottom_nav_controller.dart';
import '../../../common/ui/widgets/product_card.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        _backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Wishlist'),
          leading: IconButton(
            onPressed: _backToHome,
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.builder(
            itemCount: 30,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return FittedBox(child: ProductCard());
            },
          ),
        ),
      ),
    );
  }

  void _backToHome() {
    Get.find<MainBottomNavController>().backToHome();
    ;
  }
}
