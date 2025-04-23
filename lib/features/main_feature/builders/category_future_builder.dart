import 'package:e_commerce/features/category_products_feature/category_screen.dart';
import 'package:e_commerce/features/main_feature/items/categories.dart';
import 'package:flutter/material.dart';

class CategoryFutureBuilder extends StatelessWidget {
  const CategoryFutureBuilder({super.key, required this.categoryfuture});

  final Future<List>? categoryfuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: categoryfuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.black));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No data available!'));
        }

        return SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder:
                (context, index) => Categories(
                  image: 'assets/images/category image.png',
                  onTab: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) => CategoryScreen(
                              categorySlug: snapshot.data![index],
                            ),
                      ),
                    );
                  },
                  data: snapshot.data![index],
                ),
            separatorBuilder: (context, index) => SizedBox(width: 0),
            itemCount: snapshot.data!.length,
          ),
        );
      },
    );
  }
}
