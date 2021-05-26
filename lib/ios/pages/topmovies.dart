import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:jungledevs/ios/widgets/card_movie.dart';
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
              baseColor: CupertinoColors.systemGrey2,
              highlightColor: CupertinoColors.systemGrey5,
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
                                    color: CupertinoColors.black),
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
      statusBarColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      statusBarIconBrightness: Brightness.light,
    ));

    TextStyle tsTitleMain = TextStyle(
        fontSize: 32,
        color: CupertinoColors.white,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600);

    return CupertinoPageScaffold(
      child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Movies",
                    style: tsTitleMain,
                  ),
                  GestureDetector(
                    child: Icon(
                      CupertinoIcons.search,
                      color: CupertinoColors.white,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              Expanded(
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
              ))
            ],
          )),
      // bottomNavigationBar: BottomNavigationBar(
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   backgroundColor: Color(0xFF1B1C2A),
      //   selectedItemColor: Theme.of(context).primaryColor,
      //   unselectedItemColor: Colors.white,
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Image.asset(
      //         "assets/images/home.png",
      //         color: Colors.white,
      //       ),
      //       activeIcon: Image.asset(
      //         "assets/images/home.png",
      //         color: Theme.of(context).primaryColor,
      //       ),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Image.asset(
      //         "assets/images/topmovies.png",
      //         color: Colors.white,
      //       ),
      //       activeIcon: Image.asset(
      //         "assets/images/topmovies.png",
      //         color: Theme.of(context).primaryColor,
      //       ),
      //       label: 'Top movies',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Image.asset(
      //         "assets/images/trailers.png",
      //         color: Colors.white,
      //       ),
      //       activeIcon: Image.asset(
      //         "assets/images/trailers.png",
      //         color: Theme.of(context).primaryColor,
      //       ),
      //       label: 'Trailers',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Image.asset(
      //         "assets/images/statistics.png",
      //         color: Colors.white,
      //       ),
      //       activeIcon: Image.asset(
      //         "assets/images/statistics.png",
      //         color: Theme.of(context).primaryColor,
      //       ),
      //       label: 'Statistics',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   onTap: (int index) {
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //   },
      // ),
    );
  }

  @override
  void dispose() {
    bloc.closeStream();
    super.dispose();
  }
}

class CupertinoTabBarPage extends StatefulWidget {
  @override
  _CupertinoTabBarPageState createState() => _CupertinoTabBarPageState();
}

class _CupertinoTabBarPageState extends State<CupertinoTabBarPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(backgroundColor: Color(0xFF1B1C2A), items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/home.png",
              color: CupertinoColors.white,
            ),
            activeIcon: Image.asset(
              "assets/images/home.png",
              color: CupertinoTheme.of(context).primaryColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/topmovies.png",
              color: CupertinoColors.white,
            ),
            activeIcon: Image.asset(
              "assets/images/topmovies.png",
              color: CupertinoTheme.of(context).primaryColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/trailers.png",
              color: CupertinoColors.white,
            ),
            activeIcon: Image.asset(
              "assets/images/trailers.png",
              color: CupertinoTheme.of(context).primaryColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/statistics.png",
              color: CupertinoColors.white,
            ),
            activeIcon: Image.asset(
              "assets/images/statistics.png",
              color: CupertinoTheme.of(context).primaryColor,
            ),
          ),
        ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return TopMoviesPage();
              break;
            case 1:
              return TopMoviesPage();
              break;
            case 2:
              return TopMoviesPage();
              break;
            default:
              return TopMoviesPage();
              break;
          }
        });
  }
}
