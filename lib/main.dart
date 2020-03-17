import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_favorite_bloc/blocs/FavoriteBloc.dart';
import 'package:flutter_favorite_bloc/views/PostPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [Bloc((i) => FavoriteBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Favorite Posts',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: PostPage(),
      ),
    );
  }
}
