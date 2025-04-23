import 'package:e_commerce/consts.dart';
import 'package:e_commerce/features/checkout_feature/items/card_item.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/payment_screen.dart';
import 'package:flutter/material.dart';

class UpdatedCartWidget extends StatelessWidget {
  const UpdatedCartWidget({super.key, required this.cartItems});
  final List<ProductModel> cartItems;

  double getTotalPrice() {
    return cartItems.fold(0.0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder:
                  (context, index) => CartItem(product: cartItems[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: cartItems.length,
            ),
          ),
          const Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Payment',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  '\$${getTotalPrice().toStringAsFixed(2)}',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  backgroundColor: WidgetStatePropertyAll(kPrimaryColor),
                ),
                onPressed:
                    cartItems.isEmpty
                        ? null
                        : () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PaymentScreen(),
                            ),
                          );
                        },
                child: const Text('Pay Now'),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
