import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: FadeIn(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/icons/logo.png')),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
