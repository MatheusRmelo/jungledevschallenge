import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jungledevs/android/widgets/card_movie.dart';
import 'package:jungledevs/blocs/movies.bloc.dart';

class TopMoviesPage extends StatefulWidget {
  @override
  _TopMoviesPageState createState() => _TopMoviesPageState();
}

class _TopMoviesPageState extends State<TopMoviesPage> {
  var bloc = new MoviesBloc();
  int _selectedIndex = 1;

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
                  handleClickMovie: (int number) {
                    print(number);
                    Navigator.pushNamed(context, "/movie-details", arguments: {
                      "index": number,
                      "movies": bloc.movies,
                      "genres": bloc.genres
                    });
                  },
                  special: index == 0 ? true : false,
                  title: bloc.movies[index].title,
                  posterPath: bloc.movies[index].posterPath,
                  genresName: bloc.getGenreMovie(bloc.movies[index].id),
                  releaseYear: bloc.getReleaseYear(index),
                  stars: bloc.getStars(index),
                  index: index,
                );
              })),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Color(0xFF1B1C2A),
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/home.png",
              color: Colors.white,
            ),
            activeIcon: Image.asset(
              "assets/images/home.png",
              color: Theme.of(context).primaryColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/topmovies.png",
              color: Colors.white,
            ),
            activeIcon: Image.asset(
              "assets/images/topmovies.png",
              color: Theme.of(context).primaryColor,
            ),
            label: 'Top movies',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/trailers.png",
              color: Colors.white,
            ),
            activeIcon: Image.asset(
              "assets/images/trailers.png",
              color: Theme.of(context).primaryColor,
            ),
            label: 'Trailers',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/statistics.png",
              color: Colors.white,
            ),
            activeIcon: Image.asset(
              "assets/images/statistics.png",
              color: Theme.of(context).primaryColor,
            ),
            label: 'Statistics',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
