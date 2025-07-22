import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../product/ui/screens/product_list_screen.dart';
import '../../models/category_model.dart';

class ProductCategoryItem extends StatelessWidget {
  const ProductCategoryItem({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductListScreen.name,
          arguments: categoryModel,
        );
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.themeColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              categoryModel.iconUrl,
              width: 32,
              height: 32,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.image_not_supported,
                  size: 32,
                  color: Colors.grey,
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getTitle(categoryModel.title),
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.themeColor),
          ),
        ],
      ),
    );
  }

  String _getTitle(String title) {
    if (title.length > 9) {
      return '${title.substring(0, 8)}..';
    }

    return title;
  }
}
