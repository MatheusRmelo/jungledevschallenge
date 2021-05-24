import 'package:flutter/material.dart';
import 'package:jungledevs/android/widgets/card_movie.dart';
import 'package:jungledevs/blocs/movies.bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var bloc = new MoviesBloc();

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;

    bloc.movies = args['movies'];
    bloc.genres = args["genres"];

    return Scaffold(
      appBar: AppBar(title: Text("Top Movies"), actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ]),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: ListView.builder(
              itemCount: bloc.movies.length,
              itemBuilder: (context, index) {
                return CardMovie(
                  title: bloc.movies[index].title,
                  posterPath: bloc.movies[index].posterPath,
                  genresName: bloc.getGenreMovie(bloc.movies[index].id),
                );
              })),
    );
  }
}
