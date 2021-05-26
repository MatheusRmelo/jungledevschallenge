import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jungledevs/android/widgets/card_movie.dart';
import 'package:jungledevs/blocs/movies.bloc.dart';
import 'package:jungledevs/models/genre_model.dart';
import 'package:jungledevs/models/movie_model.dart';
import 'package:shimmer/shimmer.dart';

class TopMoviesPage extends StatefulWidget {
  @override
  _TopMoviesPageState createState() => _TopMoviesPageState();
}

class _TopMoviesPageState extends State<TopMoviesPage> {
  var bloc = MoviesBloc();
  List<GenreModel> genres = [];

  int _selectedIndex = 1;

  void initState() {
    super.initState();
    bloc.getTopMovies();
    getGenres();
  }

  void getGenres() async {
    List<GenreModel> newGenres = await bloc.getGenres();
    setState(() {
      genres = newGenres;
    });
  }

  loadingContainer({double height = 100}) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: Colors.grey[500],
              highlightColor: Colors.grey[100],
              child: Column(
                children: <int>[0, 1, 3]
                    .map((_) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.black),
                                width: double.infinity,
                                height: height,
                              )),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ));
  }

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
          child: StreamBuilder<List<MovieModel>>(
            stream: bloc.myStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Erro no servidor!");
              } else {
                if (snapshot.data == null) {
                  return Container(
                    height: double.infinity,
                    child: Center(child: loadingContainer(height: 168)),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return CardMovie(
                        handleClickMovie: (int number) {
                          Navigator.pushNamed(context, "/movie-details",
                              arguments: {
                                "id": snapshot.data[index].id,
                                "special": index == 0 ? true : false
                              });
                        },
                        special: index == 0 ? true : false,
                        title: snapshot.data[index].title,
                        posterPath: snapshot.data[index].posterPath,
                        genresName: genres.length > 0
                            ? bloc.getGenreMovie(index, genres)
                            : "",
                        //bloc.getGenreMovie(index, blocGenres.genres),
                        releaseYear: bloc.getReleaseYear(index),
                        stars: bloc.getStars(index),
                        index: index,
                      );
                    });
              }
            },
          )
          // child: ListView.builder(
          //     itemCount: bloc.movies.length,
          //     itemBuilder: (context, index) {
          //       return CardMovie(
          //         handleClickMovie: (int number) {
          //           Navigator.pushNamed(context, "/movie-details", arguments: {
          //             "index": number,
          //             "movies": bloc.movies,
          //             "genres": bloc.genres
          //           });
          //         },
          //         special: index == 0 ? true : false,
          //         title: bloc.movies[index].title,
          //         posterPath: bloc.movies[index].posterPath,
          //         genresName: bloc.getGenreMovie(index),
          //         releaseYear: bloc.getReleaseYear(index),
          //         stars: bloc.getStars(index),
          //         index: index,
          //       );
          //     })
          ),
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

  @override
  void dispose() {
    bloc.closeStream();
    super.dispose();
  }
}
