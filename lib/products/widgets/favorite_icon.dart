import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/favorite/favorite_cubit.dart';
import '../../cubits/favorite/favorite_state.dart';

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        bool isFavorite = false;
        if (state is FavoriteProductState) {
          isFavorite = (state).favorites.contains(productId);
        }
        return IconButton(
          icon: isFavorite
              ? const Icon(Icons.favorite, color: Colors.deepPurpleAccent)
              : const Icon(Icons.favorite_border_outlined),
          onPressed: () => BlocProvider.of<FavoriteCubit>(context).toggleFavorite(productId),
        );
      },
    );
  }
}
