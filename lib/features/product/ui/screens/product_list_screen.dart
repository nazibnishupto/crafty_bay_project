import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../core/ui/widgets/centered_circular_progress_indicator.dart';
import '../../../common/models/category_model.dart';
import '../../../common/ui/widgets/product_card.dart';
import '../controllers/product_list_category_controller.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.category});

  final CategoryModel category;

  static final String name = '/product-list';

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();
  final ProductListByCategoryController _productListByCategoryController =
      ProductListByCategoryController();

  @override
  void initState() {
    super.initState();
    _productListByCategoryController.getProductList(widget.category.id);
    _scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    if (_scrollController.position.extentAfter < 300) {
      Get.find<ProductListByCategoryController>().getProductList(
        widget.category.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.title)),
      body: GetBuilder(
        init: _productListByCategoryController,
        builder: (controller) {
          if (controller.initialLoadingInProgress) {
            return CenteredCircularProgressIndicator();
          }

          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GridView.builder(
                    itemCount: controller.productModelList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      return FittedBox(
                        child: ProductCard(
                          productModel: controller.productModelList[index],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Visibility(
                visible: controller.inProgress,
                child: LinearProgressIndicator(),
              ),
            ],
          );
        },
      ),
    );
  }
}
