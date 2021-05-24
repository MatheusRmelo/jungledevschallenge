import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jungledevs/android/pages/home.dart';
import 'package:jungledevs/android/pages/splashscreen.dart';

class AndroidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFFF007CFF),
      statusBarIconBrightness: Brightness.light,
    ));
    return MaterialApp(
      title: "Movie",
      theme: ThemeData(
          primaryColor: Color(0xFFF007CFF),
          scaffoldBackgroundColor: Color(0xFFF070818),
          accentColor: Color(0xFFF1B1C2A),
          appBarTheme: AppBarTheme(backgroundColor: Color(0xFFF070818))),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
