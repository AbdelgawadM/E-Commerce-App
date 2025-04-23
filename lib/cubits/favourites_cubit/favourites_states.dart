import 'package:e_commerce/models/product_model.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesUpdated extends FavoritesState {
  final List<ProductModel> favorites;

  FavoritesUpdated(this.favorites);
}
