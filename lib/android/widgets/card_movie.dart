import 'package:flutter/material.dart';

class CardMovie extends StatelessWidget {
  CardMovie({Key key, this.id, this.title, this.posterPath, this.genresName})
      : super(key: key);

  final String id;
  final String posterPath;
  final String title;
  final String genresName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle tsTitleMovie = TextStyle(color: Colors.white, fontSize: 16);
    TextStyle tsGenresMovie =
        TextStyle(color: Color(0xFFFCDCED1), fontSize: 12);

    return Container(
      margin: EdgeInsets.only(top: 16),
      height: 168,
      width: size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
              width: size.width * 0.35,
              height: 168,
              child: FittedBox(
                child: Image.network(
                    "https://image.tmdb.org/t/p/w500/$posterPath"),
                fit: BoxFit.fill,
              )),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: tsTitleMovie,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                      genresName,
                      style: tsGenresMovie,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
