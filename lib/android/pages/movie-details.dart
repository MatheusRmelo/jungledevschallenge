import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jungledevs/android/widgets/card_movie.dart';
import 'package:jungledevs/android/widgets/rating_movie.dart';
import 'package:jungledevs/blocs/movie.bloc.dart';
import 'package:jungledevs/blocs/similar.bloc.dart';
import 'package:jungledevs/models/genre_model.dart';
import 'package:jungledevs/models/movie_model.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailsPage extends StatefulWidget {
  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  var bloc = MovieBloc();
  var blocSimilarMovies = SimilarBloc();
  List<GenreModel> genres = [];

  var args;
  int index = 0;
  bool special = false;

  void initState() {
    super.initState();
    getGenres();
    Future.delayed(Duration.zero, () {
      setState(() {
        args = ModalRoute.of(context).settings.arguments;
        special = args["special"];
      });
      getMovie(args['id']);
    });
  }

  void getMovie(int id) {
    bloc.getMovie(id);
    blocSimilarMovies.getSimilarMovies(id);
  }

  void getGenres() async {
    List<GenreModel> newGenres = await blocSimilarMovies.getGenres();
    setState(() {
      genres = newGenres;
    });
  }

  loadingContainer({double height = 100}) {
    return Padding(
        padding: EdgeInsets.only(top: 10),
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
    TextStyle tsTitleMovie =
        TextStyle(fontFamily: "Inter", fontSize: 32, color: Colors.white);
    TextStyle tsParagraph =
        TextStyle(fontFamily: "Inter", fontSize: 14, color: Colors.white);
    TextStyle tsSmall =
        TextStyle(fontFamily: "Inter", fontSize: 12, color: Color(0xFFCDCED1));
    TextStyle tsSmallSpecial =
        TextStyle(fontFamily: "Inter", fontSize: 14, color: Color(0xFFCDCED1));
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
            child: StreamBuilder<MovieModel>(
      stream: bloc.myStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("ERRO");
        } else {
          if (snapshot.data == null) {
            return Container(
              height: size.height,
              width: size.width,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 4,
                ),
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: size.width,
                    height: size.height * 0.8,
                    child: FittedBox(
                      child: Image.network(
                          "https://image.tmdb.org/t/p/w500/${snapshot.data.posterPath}"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      top: 0,
                      child: Container(
                        width: size.width,
                        height: size.height * 0.60,
                        color: Colors.black.withOpacity(0.6),
                      )),
                  Positioned(
                    top: size.height * 0.06,
                    left: 0,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 32,
                        )),
                  ),
                  Positioned(
                      top: size.height * 0.17,
                      left: 32,
                      child: special
                          ? Text(
                              "Top movie of the week",
                              style: tsSmallSpecial,
                            )
                          : Container()),
                  Positioned(
                      top: size.height * 0.21,
                      left: 32,
                      child: special
                          ? Container(
                              height: 38,
                              child: FittedBox(
                                child: Image.asset(
                                  "assets/images/il_goldmedal_small.png",
                                ),
                                fit: BoxFit.fill,
                              ),
                            )
                          : Container()),
                  Positioned(
                      top: size.height * 0.2,
                      child: Container(
                        width: size.width * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data.title,
                              style: tsTitleMovie,
                            ),
                            Row(
                              children: [
                                Text(
                                  bloc.getReleaseYear(),
                                  style: tsSmall,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 4, right: 4),
                                  child: Icon(
                                    Icons.circle,
                                    size: 8,
                                    color: Color(0xFFCDCED1),
                                  ),
                                ),
                                Text(
                                  bloc.getGenreMovie(),
                                  style: tsSmall,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 4, right: 4),
                                  child: Icon(
                                    Icons.circle,
                                    size: 8,
                                    color: Color(0xFFCDCED1),
                                  ),
                                ),
                                Text(
                                  bloc.getTime(),
                                  style: tsSmall,
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16, bottom: 16),
                              child: Text(
                                snapshot.data.overview,
                                style: tsParagraph,
                              ),
                            ),
                            RatingMovie(max: 5, stars: bloc.getStars())
                          ],
                        ),
                      )),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        width: size.width,
                        height: size.height * 0.1,
                        color: Colors.black.withOpacity(0.3),
                      )),
                ],
              ),
              Container(
                  height: size.height * 0.8,
                  margin: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Also trending",
                        style: tsTitleMovie,
                      ),
                      Expanded(
                          child: StreamBuilder<List<MovieModel>>(
                        stream: blocSimilarMovies.myStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Erro no servidor!");
                          } else {
                            if (snapshot.data == null) {
                              return Container(
                                height: double.infinity,
                                child: Center(
                                    child: loadingContainer(height: 168)),
                              );
                            }
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return CardMovie(
                                    handleClickMovie: (int number) {
                                      Navigator.pushNamed(
                                          context, "/movie-details",
                                          arguments: {
                                            "id": snapshot.data[index].id,
                                          });
                                    },
                                    title: snapshot.data[index].title,
                                    posterPath: snapshot.data[index].posterPath,
                                    genresName: genres.length > 0
                                        ? blocSimilarMovies.getGenreMovie(
                                            index, genres)
                                        : "",
                                    //bloc.getGenreMovie(index, blocGenres.genres),
                                    releaseYear:
                                        blocSimilarMovies.getReleaseYear(index),
                                    stars: blocSimilarMovies.getStars(index),
                                    index: index,
                                  );
                                });
                          }
                        },
                      ))
                    ],
                  ))
            ],
          );
        }
      },
    )));
  }

  @override
  void dispose() {
    bloc.closeStream();
    super.dispose();
  }
}
