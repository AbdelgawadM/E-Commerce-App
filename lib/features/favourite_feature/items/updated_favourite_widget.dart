import 'package:e_commerce/cubits/favourites_cubit/favourites_cubit.dart';
import 'package:e_commerce/cubits/favourites_cubit/favourites_states.dart';
import 'package:e_commerce/features/favourite_feature/items/empty_favourites_widget.dart';
import 'package:e_commerce/features/main_feature/builders/grid_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatedFavoritesWidget extends StatelessWidget {
  const UpdatedFavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesUpdated) {
          final favorites = state.favorites;
          if (favorites.isEmpty) {
            return const EmptyFavoritesWidget();
          }
          return GridBuilder(products: state.favorites);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
