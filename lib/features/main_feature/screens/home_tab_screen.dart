import 'package:e_commerce/consts.dart';
import 'package:e_commerce/cubits/product_cubit/product_cubit.dart';
import 'package:e_commerce/features/auth_feature/screens/login_screen.dart';
import 'package:e_commerce/features/main_feature/builders/category_future_builder.dart';
import 'package:e_commerce/features/main_feature/builders/product_cubit_builder.dart';
import 'package:e_commerce/features/main_feature/components/home_icon_button.dart';
import 'package:e_commerce/services/store_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  Future<List>? categoryfuture;

  @override
  void initState() {
    super.initState();
    categoryfuture = StoreService().fetchCategories();

    Future.microtask(() {
      context.read<ProductCubit>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeIconButton(icon: Icons.search, onPressed: () {}),
              Text(
                'CartCove',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: kPrimaryColor,
                ),
              ),
              HomeIconButton(
                icon: CupertinoIcons.person_fill,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 15),
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 241, 221, 195),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image(image: AssetImage('assets/images/freed.png')),
          ),
          SizedBox(height: 15),
          CategoryFutureBuilder(categoryfuture: categoryfuture),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Best Sellers',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          ProductCubitBuilder(),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
