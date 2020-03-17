import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_favorite_bloc/blocs/FavoriteBloc.dart';
import 'package:flutter_favorite_bloc/blocs/FavoriteCardBloc.dart';
import 'package:flutter_favorite_bloc/models/Post.dart';

class PostCard extends StatefulWidget {
  final Post post;

  PostCard(this.post);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  FavoriteCardBloc _favoriteCardBloc;
  FavoriteBloc _favoriteBloc;

  @override
  void initState() {
    _favoriteCardBloc = FavoriteCardBloc(widget.post);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();

      _favoriteBloc.favoritesListFlux
          .listen(_favoriteCardBloc.favoritesListEvent.add);
    });

    super.initState();
  }

  @override
  void dispose() {
    _favoriteCardBloc.dispose();
    _favoriteBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 200,
        height: 200,
        child: Column(
          children: <Widget>[
            Text(widget.post.id.toString()),
            Text(widget.post.title),
            Text(widget.post.body),
            StreamBuilder(
              stream: _favoriteCardBloc.isFavoriteFlux,
              initialData: false,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return snapshot.data
                    ? IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: (){
                          _favoriteBloc.favoritesDeleteEvent.add(widget.post);
                        })
                    : IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.grey,
                        ),
                        onPressed: (){
                          _favoriteBloc.favoritesAddEvent.add(widget.post);
                        });
              },
            ),
          ],
        ),
      ),
    );
  }
}
