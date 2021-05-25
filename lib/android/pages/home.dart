import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
      statusBarIconBrightness: Brightness.light,
    ));

    TextStyle tsTitleMain = TextStyle(
        fontSize: 32,
        color: Colors.white,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600);

    final Map args = ModalRoute.of(context).settings.arguments;

    bloc.movies = args['movies'];
    bloc.genres = args["genres"];

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Top Movies",
            style: tsTitleMain,
          ),
          actions: [
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
                  special: index == 0 ? true : false,
                  title: bloc.movies[index].title,
                  posterPath: bloc.movies[index].posterPath,
                  genresName: bloc.getGenreMovie(bloc.movies[index].id),
                  releaseYear: bloc.getReleaseYear(index),
                  stars: bloc.getStars(index),
                );
              })),
    );
  }
}
