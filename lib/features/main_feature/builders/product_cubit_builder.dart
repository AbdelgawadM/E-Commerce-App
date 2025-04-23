import 'package:e_commerce/cubits/product_cubit/product_cubit.dart';
import 'package:e_commerce/cubits/product_cubit/product_state.dart';
import 'package:e_commerce/features/main_feature/builders/grid_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubitBuilder extends StatelessWidget {
  const ProductCubitBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        } else if (state is ProductError) {
          return Center(child: Text('Errrrrror: ${state.message}'));
        } else if (state is ProductLoaded) {
          final products = state.products;
          if (products.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          return GridBuilder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            products: products,
          );
        } else {
          return const SizedBox(); // For ProductInitial
        }
      },
    );
  }
}
