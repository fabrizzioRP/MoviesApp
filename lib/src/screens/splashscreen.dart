// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors,, unnecessary_this, unused_field, must_call_super, avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> scaleUp;
  late Animation<double> moveUp;
  late Animation<double> opacity;

  void animationFirt() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));

    scaleUp = Tween(begin: 3.0, end: 0.2).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.bounceOut)));

    moveUp = CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut));

    opacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.7, 1.0, curve: Curves.easeOutCubic)));

    _controller.forward();
  }

  @override
  void initState() {
    this.animationFirt();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: Listenable.merge([_controller]),
        builder: (context, _) => Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Transform.scale(
                  scale: scaleUp.value,
                  child: Transform.translate(
                    offset:
                        Offset(600.0 * moveUp.value, -1600.0 * moveUp.value),
                    child: Image.asset('assets/icons/iconNetflix.png'),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 140,
                right: 140,
                bottom: 0,
                child: Opacity(
                  opacity: opacity.value, // aca poner el opacity
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'homescreen'),
                        child: Hero(
                          tag: 'avatar-superhero',
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child:
                                  Image.asset('assets/avatar/superhero.png')),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Usuario',
                          style: TextStyle(fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 90,
                left: 35,
                child: Opacity(
                    opacity: opacity.value,
                    child: Hero(
                      tag: 'logonetflix',
                      child: Image.asset(
                        'assets/logonetflix.png',
                        height: 50,
                      ),
                    )),
              ),
              Positioned(
                top: 295,
                left: 55,
                child: Opacity(
                  opacity: opacity.value,
                  child: Text('¿Quien esta viendo ahora?',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 25)),
                ),
              ),
            ],
          ),
        ),
      );
}
