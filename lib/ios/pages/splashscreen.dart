import 'package:flutter/cupertino.dart';
import 'package:jungledevs/blocs/movies.bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var bloc = MoviesBloc();

  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacementNamed(context, '/topmovies');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: CupertinoTheme.of(context).primaryColor,
      child: Image.asset("assets/images/il_splash.png"),
    );
  }
}
