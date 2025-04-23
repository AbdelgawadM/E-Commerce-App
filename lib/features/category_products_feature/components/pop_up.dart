import 'package:e_commerce/consts.dart';
import 'package:e_commerce/cubits/add_to_cart_cubit/cart_cubit.dart';
import 'package:e_commerce/features/auth_feature/screens/regist_screen.dart';
import 'package:e_commerce/features/checkout_feature/screens/checkout_screen.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopUp extends StatelessWidget {
  const PopUp({super.key, required this.price, required this.product});
  final double price;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.black12,
          ),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckoutScreen()),
              );
            },
            color: kPrimaryColor,
            icon: Icon(CupertinoIcons.cart_fill),
          ),
        ),
        SizedBox(
          height: 50,
          width: 250,
          child: ElevatedButton(
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(Colors.white),
              backgroundColor: WidgetStatePropertyAll(kPrimaryColor),
            ),
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;

              if (user == null || user.isAnonymous) {
                // المستخدم غير مسجل أو Anonymous
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'You need to sign in to add products to your cart.',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => RegistScreen()));
                return;
              }

              final wasAdded = await context.read<CartCubit>().addToCart(
                product,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    wasAdded
                        ? 'Product added to cart.'
                        : 'Product is already in cart.',
                  ),
                  duration: Duration(seconds: 1),
                  backgroundColor: wasAdded ? Colors.green : Colors.orange,
                ),
              );
            },

            child: Text('Add to cart'),
          ),
        ),
      ],
    );
  }
}
