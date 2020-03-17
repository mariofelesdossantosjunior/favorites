import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_favorite_bloc/blocs/PostBloc.dart';
import 'package:flutter_favorite_bloc/components/PostCard.dart';
import 'package:flutter_favorite_bloc/models/Post.dart';

import 'FavoritesPage.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostBloc _postBloc;

  @override
  void initState() {
    _postBloc = PostBloc();
    super.initState();
  }

  @override
  void dispose() {
    _postBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Posts"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: _postBloc.postListFlux,
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var post = snapshot.data[index];
                  return PostCard(post);
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.favorite),
          onPressed: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => FavoritesPage()));
          }),
    );
  }
}
