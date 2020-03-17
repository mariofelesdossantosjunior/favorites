import 'package:flutter_favorite_bloc/models/Post.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class FavoriteCardBloc extends BlocBase {
  final _favoriteListCotroller = BehaviorSubject<List<Post>>();
  Stream<List<Post>> get favoritesListFlux => _favoriteListCotroller.stream;
  Sink<List<Post>> get favoritesListEvent => _favoriteListCotroller.sink;

  final _isFavoriteCotroller = BehaviorSubject<bool>();
  Stream<bool> get isFavoriteFlux => _isFavoriteCotroller.stream;
  Sink<bool> get isFavoriteEvent => _isFavoriteCotroller.sink;

  FavoriteCardBloc(Post post) {
    favoritesListFlux
        .map((dados) => dados.contains(post))
        .listen(isFavoriteEvent.add);
  }

  @override
  void dispose() {
    _isFavoriteCotroller.close();
  }
}
