import 'package:flutter/cupertino.dart';

Widget RatingMovie({int stars, int max, bool special = false}) {
  TextStyle tsNumbers = TextStyle(fontSize: 12, color: Color(0xFFCDCED1));

  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: special ? Color(0xFF1F8CFF) : Color(0xFF252634)),
    padding: EdgeInsets.all(8),
    child: Row(
      children: [
        Icon(
          stars >= 1 ? CupertinoIcons.star_fill : CupertinoIcons.star,
          color: CupertinoColors.systemYellow,
          size: 16,
        ),
        Icon(
          stars >= 2 ? CupertinoIcons.star_fill : CupertinoIcons.star,
          color: CupertinoColors.systemYellow,
          size: 16,
        ),
        Icon(
          stars >= 3 ? CupertinoIcons.star_fill : CupertinoIcons.star,
          color: CupertinoColors.systemYellow,
          size: 16,
        ),
        Icon(
          stars >= 4 ? CupertinoIcons.star_fill : CupertinoIcons.star,
          color: CupertinoColors.systemYellow,
          size: 16,
        ),
        Icon(
          stars >= 5 ? CupertinoIcons.star_fill : CupertinoIcons.star,
          color: CupertinoColors.systemYellow,
          size: 16,
        ),
        Container(
          margin: EdgeInsets.only(left: 8),
          child: Text(
            "${stars.toString()} / ${max.toString()}",
            style: tsNumbers,
          ),
        )
      ],
    ),
  );
}
