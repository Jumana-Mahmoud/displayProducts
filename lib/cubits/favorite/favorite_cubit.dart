import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/db/cache_keys.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(InitFavoriteState()) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteIds =
        prefs.getStringList(CacheKeys.favorite.toString()) ?? [];
    final List<int> favorites = favoriteIds.map((id) => int.parse(id)).toList();
    emit(FavoriteProductState(favorites: favorites));
  }

  void toggleFavorite(int productId) {
    if (state is FavoriteProductState) {
      final currentFavorites =
          List<int>.from((state as FavoriteProductState).favorites);

      if (currentFavorites.contains(productId)) {
        unfavoriteProduct(productId);
      } else {
        currentFavorites.add(productId);
        _saveToPrefs(CacheKeys.favorite, productId);
      }

      emit(FavoriteProductState(favorites: currentFavorites));
    }
  }

  void _saveToPrefs(CacheKeys key, int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> ids = (prefs.getStringList(key.toString()) ?? [])
      ..add(productId.toString());
    await prefs.setStringList(key.toString(), ids);
  }

  bool isFavorite(int productId) {
    if (state is FavoriteProductState) {
      return (state as FavoriteProductState).favorites.contains(productId);
    }
    return false;
  }

  void unfavoriteProduct(int productId) {
    if (state is FavoriteProductState) {
      final currentFavorites =
          List<int>.from((state as FavoriteProductState).favorites);
      if (currentFavorites.contains(productId)) {
        currentFavorites.remove(productId);
        _removeFromPrefs(CacheKeys.favorite, productId);
        emit(FavoriteProductState(favorites: currentFavorites));
      }
    }
  }

  void _removeFromPrefs(CacheKeys key, int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> ids = (prefs.getStringList(key.toString()) ?? [])
      ..remove(productId.toString());
    await prefs.setStringList(key.toString(), ids);
  }
}
