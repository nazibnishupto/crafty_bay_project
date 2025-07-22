import 'package:crafty_bay_project/features/review/ui/screen/reviews_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../../core/ui/widgets/centered_circular_progress_indicator.dart';
import '../../../../core/ui/widgets/snack_bar_message.dart';
import '../../../auth/ui/screens/login_screen.dart';
import '../../../common/controllers/auth_controller.dart';
import '../../data/models/product_details_model.dart';
import '../controllers/add_to_cart_controller.dart';
import '../controllers/product_details_controller.dart';
import '../widgets/color_picker.dart';
import '../widgets/inc_dec_button.dart';
import '../widgets/product_image_slider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  static const String name = '/product-details';

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

// TODO: Extract this widget tree
class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsController _productDetailsController =
      ProductDetailsController();

  final AddToCartController _addToCartController =
      Get.find<AddToCartController>();

  @override
  void initState() {
    super.initState();
    _productDetailsController.getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: GetBuilder(
        init: _productDetailsController,
        builder: (_) {
          if (_productDetailsController.inProgress) {
            return CenteredCircularProgressIndicator();
          }

          if (_productDetailsController.errorMessage != null) {
            return Center(child: Text(_productDetailsController.errorMessage!));
          }

          final ProductDetailsModel product =
              _productDetailsController.productDetails;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductImageSlider(images: product.photoUrls),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    product.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.6,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                IncDecButton(onChange: (int value) {}),
                              ],
                            ),
                            Row(
                              children: [
                                Wrap(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 18,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                      '4.5',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text('Reviews'),
                                ),
                                Card(
                                  color: AppColors.themeColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Icon(
                                      Icons.favorite_outline_rounded,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: product.colors.isNotEmpty,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Color',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ColorPicker(
                                    colors: product.colors,
                                    onSelected: (String value) {},
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: product.sizes.isNotEmpty,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Size',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ColorPicker(
                                    colors: product.sizes,
                                    onSelected: (String value) {},
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                            Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              product.description,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildPriceAndAddToCartSection(product),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPriceAndAddToCartSection(ProductDetailsModel product) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.15),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('Price', style: Theme.of(context).textTheme.bodyLarge),
              Text(
                '${Constants.takaSign}${product.currentPrice}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: GetBuilder(
              init: _addToCartController,
              builder: (_) {
                return Visibility(
                  visible: _addToCartController.inProgress == false,
                  replacement: CenteredCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: _onTapAddToCartButton,
                    child: Text('Add to Cart'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onTapAddToCartButton() async {
    if (await Get.find<AuthController>().isUserLoggedIn()) {
      final bool result = await _addToCartController.addToCart(
        widget.productId,
      );
      if (result) {
        showSnackBarMessage(context, 'Added to cart');
      } else {
        showSnackBarMessage(context, _addToCartController.errorMessage!);
      }
    } else {
      Navigator.pushNamed(context, LoginScreen.name);
    }
  }
}
