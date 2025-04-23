import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/cubits/favourites_cubit/favourites_states.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  final _firestore = FirebaseFirestore.instance;
  String? get _userId => FirebaseAuth.instance.currentUser?.uid;
  List<ProductModel> favoriteItems = [];

  Future<void> fetchFavoritesFromFirestore() async {
    if (_userId == null) return;

    final snapshot =
        await _firestore
            .collection('users')
            .doc(_userId)
            .collection('favorites')
            .get();

    favoriteItems =
        snapshot.docs.map((doc) => ProductModel.fromMap(doc.data())).toList();

    emit(FavoritesUpdated(List.from(favoriteItems)));
  }

  Future<void> toggleFavorite(ProductModel product) async {
    if (_userId == null) return;

    final favRef = _firestore
        .collection('users')
        .doc(_userId)
        .collection('favorites')
        .doc(product.id.toString());

    if (isFavorite(product)) {
      favoriteItems.removeWhere((item) => item.id == product.id);
      await favRef.delete();
    } else {
      favoriteItems.add(product);
      await favRef.set(product.toMap());
    }

    emit(FavoritesUpdated(List.from(favoriteItems)));
  }

  bool isFavorite(ProductModel product) {
    return favoriteItems.any((item) => item.id == product.id);
  }
}
