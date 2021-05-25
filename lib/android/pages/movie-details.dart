import 'package:flutter/material.dart';
import 'package:jungledevs/blocs/movies.bloc.dart';

class MovieDetailsPage extends StatefulWidget {
  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  var bloc = new MoviesBloc();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;

    bloc.movies = args['movies'];
    bloc.genres = args["genres"];
    index = args["index"];

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.5,
            padding: EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://image.tmdb.org/t/p/w500/${bloc.movies[index].posterPath}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                Container(
                  width: size.width,
                  height: 120,
                  color: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.4),
                )
              ],
            ),
          ),
          Container(
            child: Text("Also trending"),
          )
        ],
      ),
    );
  }
}
