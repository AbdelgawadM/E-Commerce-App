import 'package:e_commerce/features/category_products_feature/components/pop_up.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductOverview extends StatelessWidget {
  const ProductOverview({
    super.key,
    required this.sampleImages,
    required this.productName,
    required this.description,
    required this.price,
    required this.product,
  });

  final List<String> sampleImages;
  final String productName, description;
  final double price;
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        title: Text(
          'Product Overview',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  // Type 1
                  FanCarouselImageSlider.sliderType1(
                    initalPageIndex:
                        (sampleImages.isNotEmpty) ? 0 : 0, // Safe default
                    displayIndicatorOnSlider: false,
                    imageFitMode: BoxFit.cover,
                    expandFitAndZoomable: true,
                    imagesLink:
                        sampleImages.isNotEmpty
                            ? sampleImages
                            : [
                              'https://via.placeholder.com/300',
                            ], // fallback image
                    isAssets: false,
                    autoPlay: true,
                    sliderHeight: 300,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          productName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Text(
                        '\$$price',
                        style: TextStyle(
                          color: Color(0xFFE87376),
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder:
                        (context, _) => Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (double value) {},
                  ),
                  SizedBox(height: 20),
                  Text(
                    softWrap: true,
                    description,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 10),
            PopUp(price: price, product: product),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
