import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/cubits/add_to_cart_cubit/cart_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/models/product_model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final _firestore = FirebaseFirestore.instance;

  String? get _userId => FirebaseAuth.instance.currentUser?.uid;

  List<ProductModel> cartItems = [];

  Future<void> fetchCartItems() async {
    if (_userId == null) return;

    final snapshot =
        await _firestore
            .collection('users')
            .doc(_userId)
            .collection('cart')
            .get();

    cartItems =
        snapshot.docs.map((doc) => ProductModel.fromMap(doc.data())).toList();

    emit(CartUpdated(List.from(cartItems)));
  }

  Future<bool> addToCart(ProductModel product) async {
    if (_userId == null) return false;

    final cartRef = _firestore
        .collection('users')
        .doc(_userId)
        .collection('cart')
        .doc(product.id.toString());

    if (!cartItems.any((item) => item.id == product.id)) {
      cartItems.add(product);
      await cartRef.set(product.toMap());
      emit(CartUpdated(List.from(cartItems)));
      return true; // تم الإضافة
    }

    return false; // موجود بالفعل
  }

  Future<void> removeFromCart(ProductModel product) async {
    if (_userId == null) return;

    cartItems.removeWhere((item) => item.id == product.id);

    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('cart')
        .doc(product.id.toString())
        .delete();

    emit(CartUpdated(List.from(cartItems)));
  }

  bool isInCart(ProductModel product) {
    return cartItems.any((item) => item.id == product.id);
  }
}
