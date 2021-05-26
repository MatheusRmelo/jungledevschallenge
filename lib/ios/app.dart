import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:jungledevs/ios/pages/movie-details.dart';
import 'package:jungledevs/ios/pages/splashscreen.dart';
import 'package:jungledevs/ios/pages/topmovies.dart';

class IOSApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFFF007CFF),
      statusBarIconBrightness: Brightness.light,
    ));

    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
          primaryColor: Color(0xFFF007CFF),
          scaffoldBackgroundColor: Color(0xFFF070818),
          primaryContrastingColor: Color(0xFFF1B1C2A),
          barBackgroundColor: Color(0xFFF070818)),
      home: SplashScreen(),
      routes: {
        '/home': (context) => SplashScreen(),
        '/topmovies': (context) => CupertinoTabBarPage(),
        '/movie-details': (context) => MovieDetailsPage(),
      },
    );
  }
}
