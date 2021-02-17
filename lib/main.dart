import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
      debugShowCheckedModeBanner: false
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Artboard _riveArtboard;
  RiveAnimationController _animationController;

  @override
  void initState() {
    super.initState();

    rootBundle.load('assets/engineer.riv').then((data) async {
      final file = RiveFile();

      if(file.import(data)) {
        final Artboard artboard = file.mainArtboard;
        _animationController = SimpleAnimation('Animation 1');
        artboard.addController(_animationController);
        setState(() {
          _riveArtboard = artboard;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          child: _riveArtboard == null ? const SizedBox() : Rive(artboard: _riveArtboard)
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: (_animationController == null || _animationController.isActive == true)
          ? Icon(Icons.pause, color: Colors.white)
          : Icon(Icons.play_arrow, color: Colors.white),
        backgroundColor: Colors.redAccent,
        onPressed: () {
          setState(() {
            _animationController.isActive = !_animationController.isActive;
            print(_animationController.isActive);
          });
        },
      ),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((value) => Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Home()
      )
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Text('ANIMAÇÃO', style: TextStyle(color: Colors.black, fontSize: 23)),
        ),
      ),
    );
  }
}