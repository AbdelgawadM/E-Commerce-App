import 'package:e_commerce/cubits/add_to_cart_cubit/cart_cubit.dart';
import 'package:e_commerce/cubits/add_to_cart_cubit/cart_states.dart';
import 'package:e_commerce/features/checkout_feature/items/empty_cart_widget.dart';
import 'package:e_commerce/features/checkout_feature/items/updated_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Cart', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartUpdated) {
              return UpdatedCartWidget(cartItems: state.cartItems);
            } else if (state is CartInitial) {
              return EmptyCartWidget();
            } else {
              return Center(child: Text('error'));
            }
          },
        ),
      ),
    );
  }
}
