import 'package:e_commerce/cubits/favourites_cubit/favourites_cubit.dart';
import 'package:e_commerce/cubits/favourites_cubit/favourites_states.dart';
import 'package:e_commerce/features/favourite_feature/items/empty_favourites_widget.dart';
import 'package:e_commerce/features/favourite_feature/items/updated_favourite_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // جلب المفضلات من Firestore
    context.read<FavoritesCubit>().fetchFavoritesFromFirestore();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Favourites',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesUpdated) {
              return const UpdatedFavoritesWidget();
            } else if (state is FavoritesInitial) {
              return const EmptyFavoritesWidget();
            } else {
              return const Center(child: Text('error'));
            }
          },
        ),
      ),
    );
  }
}
