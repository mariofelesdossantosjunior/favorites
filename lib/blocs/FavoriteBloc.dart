import 'package:flutter_favorite_bloc/models/Favorites.dart';
import 'package:flutter_favorite_bloc/models/Post.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class FavoriteBloc extends BlocBase {
  final Favorites _favorites = Favorites();

  final _favoritesListController = BehaviorSubject<List<Post>>();
  Stream<List<Post>> get favoritesListFlux => _favoritesListController.stream;
  Sink<List<Post>> get favoritesListEvent => _favoritesListController.sink;

  final _favoritesListAddController = BehaviorSubject<Post>();
  Stream<Post> get favoritesAddFlux => _favoritesListAddController.stream;
  Sink<Post> get favoritesAddEvent => _favoritesListAddController.sink;

  final _favoritesListDeleteController = BehaviorSubject<Post>();
  Stream<Post> get favoritesDeleteFlux => _favoritesListDeleteController.stream;
  Sink<Post> get favoritesDeleteEvent => _favoritesListDeleteController.sink;

  FavoriteBloc() {
    favoritesAddFlux.listen(_handleAdd);
    favoritesDeleteFlux.listen(_handleDelete);
  }

  void _handleAdd(Post post) {
    _favorites.posts.add(post);
    updateList();
  }

  void _handleDelete(Post post) {
    _favorites.posts.remove(post);
    updateList();
  }

  void updateList() {
    favoritesListEvent.add(_favorites.posts.toList());
  }

  @override
  void dispose() {
    _favoritesListController.close();
    _favoritesListAddController.close();
    _favoritesListDeleteController.close();
  }
}
