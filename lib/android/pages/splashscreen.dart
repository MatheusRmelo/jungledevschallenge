import 'package:flutter/material.dart';
import 'package:jungledevs/blocs/movies.bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var bloc = MoviesBloc();

  void initState() {
    super.initState();
    getMovies();
  }

  void getMovies() async {
    List<GenreModel> genres = await bloc.getGenres();
    List<MovieModel> movies = await bloc.getMovies();
    Navigator.pushReplacementNamed(context, '/topmovies',
        arguments: {"movies": movies, "genres": genres});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: Theme.of(context).primaryColor,
      child: Image.asset("assets/images/il_splash.png"),
    );
  }
}
