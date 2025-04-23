import 'package:e_commerce/features/category_products_feature/product_overview.dart';
import 'package:e_commerce/features/main_feature/items/product.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';

class GridBuilder extends StatelessWidget {
  const GridBuilder({
    super.key,
    required this.products,
    this.shrinkWrap = false,
    this.physics,
  });

  final List<ProductModel> products;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      shrinkWrap: true, // تفعيل الشريط الملتوي لتقليل الحجم
      physics: NeverScrollableScrollPhysics(), // منع التمرير داخل الـ GridView
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // عمودين
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.65, // لتناسب الأبعاد
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return Product(
          product: product,
          ontap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (context) => ProductOverview(
                      sampleImages: [
                        product.image,
                        product.image,
                        product.image,
                      ],
                      productName: product.title,
                      description: product.description,
                      price: product.price,
                      product: product,
                    ),
              ),
            );
          },
        );
      },
    );
  }
}
