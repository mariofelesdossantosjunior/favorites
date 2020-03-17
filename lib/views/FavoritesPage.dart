import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_favorite_bloc/blocs/FavoriteBloc.dart';
import 'package:flutter_favorite_bloc/models/Post.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    FavoriteBloc favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Posts Favorites"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: favoriteBloc.favoritesListFlux,
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Post post = snapshot.data[index];
                  return Dismissible(
                    onDismissed: (direction) {
                      favoriteBloc.favoritesDeleteEvent.add(post);
                    },
                    key: Key(post.id.toString()),
                    child: Card(
                      child: Container(
                        height: 200,
                        width: 200,
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(post.id.toString()),
                            Text(post.title),
                            Text(post.body),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("Você ainda não possui favoritos"),
              );
            }
          },
        ),
      ),
    );
  }
}
