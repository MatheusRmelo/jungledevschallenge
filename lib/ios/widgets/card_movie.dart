import 'package:flutter/cupertino.dart';
import 'package:jungledevs/ios/widgets/rating_movie.dart';

class CardMovie extends StatelessWidget {
  CardMovie(
      {Key key,
      this.special = false,
      this.id,
      this.title,
      this.posterPath,
      this.genresName,
      this.releaseYear,
      this.stars,
      this.index,
      this.handleClickMovie})
      : super(key: key);

  final bool special;
  final String id;
  final String posterPath;
  final String title;
  final String genresName;
  final String releaseYear;
  final int stars;
  final int index;
  final Function handleClickMovie;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle tsTitle = TextStyle(
        color: CupertinoColors.white,
        fontSize: 16,
        fontFamily: "Inter",
        fontWeight: FontWeight.w500);
    TextStyle tsParagraph =
        TextStyle(color: Color(0xFFFCDCED1), fontSize: 12, fontFamily: "Inter");
    TextStyle tsSmall =
        TextStyle(color: Color(0xFFFCDCED1), fontSize: 14, fontFamily: "Inter");

    return GestureDetector(
      onTap: () {
        handleClickMovie(index);
        // Navigator.pushNamed(context, "/movie-details",
        //     arguments: {"index": index, "movies":});
      },
      child: Container(
        margin: EdgeInsets.only(top: 16),
        height: 176,
        width: size.width,
        decoration: BoxDecoration(
            color: special
                ? CupertinoTheme.of(context).primaryColor
                : CupertinoTheme.of(context).primaryContrastingColor,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Container(
                width: size.width * 0.35,
                height: 176,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(32)),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                  child: FittedBox(
                    child: Image.network(
                        "https://image.tmdb.org/t/p/w500/$posterPath"),
                    fit: BoxFit.fill,
                  ),
                )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        special
                            ? Container(
                                margin: EdgeInsets.only(bottom: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "assets/images/il_goldmedal_small.png",
                                      width: 24,
                                      height: 24,
                                    ),
                                    Text(
                                      "Top movie this week",
                                      style: tsSmall,
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                        Text(
                          title,
                          style: tsTitle,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4, bottom: 4),
                          child: Text(
                            genresName,
                            style: tsParagraph,
                          ),
                        ),
                        Text(
                          releaseYear,
                          style: tsParagraph,
                        ),
                      ],
                    ),
                    Container(
                      width: size.width * 0.35,
                      child:
                          RatingMovie(max: 5, stars: stars, special: special),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
