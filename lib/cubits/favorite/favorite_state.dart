abstract class FavoriteState {}

class InitFavoriteState extends FavoriteState {}

class FavoriteProductState extends FavoriteState {
  final List<int> favorites;

  FavoriteProductState({this.favorites = const []});
}
