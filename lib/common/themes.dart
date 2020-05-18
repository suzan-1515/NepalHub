import 'package:flutter/material.dart';

//Todo: Use proper text theme sizes
final TextTheme _textTheme = TextTheme(
  headline: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
  title: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
  subtitle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
  subhead: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
  button: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
  body1: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
  body2: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
  display1: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
  display2: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
  display3: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700),
  display4: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
);

final lightTheme = ThemeData(
  fontFamily: 'Raleway',
  textTheme: _textTheme,
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w700, fontSize: 16),
    labelColor: Colors.black,
    unselectedLabelColor: Colors.black54,
    unselectedLabelStyle: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w700, fontSize: 16),
    indicator: UnderlineTabIndicator(borderSide: BorderSide(color: Colors.red, width: 3)),
  ),
  brightness: Brightness.light,
  primarySwatch: Colors.grey,
  accentColor: Colors.red,
  dividerColor: Colors.black26,
  scaffoldBackgroundColor: Colors.grey[100],
  backgroundColor: Colors.grey[100],
  cardColor: Colors.white,
  splashColor: Colors.red[200],
  bottomAppBarColor: Colors.white,
  indicatorColor: Colors.red,
  iconTheme: IconThemeData(
    color: Colors.black
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.white70,
    textTheme: ButtonTextTheme.normal,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.white,
    contentTextStyle: TextStyle(color: Colors.black87),
  ),
);

final darkTheme = ThemeData(
  fontFamily: 'Raleway',
  textTheme: _textTheme,
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w700, fontSize: 16),
    unselectedLabelStyle: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w700, fontSize: 16),
    indicator: UnderlineTabIndicator(borderSide: BorderSide(color: Colors.red, width: 3)),
  ),
  brightness: Brightness.dark,
  primarySwatch: Colors.grey,
  accentColor: Colors.red,
  dividerColor: Colors.white30,
  scaffoldBackgroundColor: Colors.grey[850],
  backgroundColor: Colors.grey[850],
  cardColor: Colors.grey[800],
  splashColor: Colors.red[100],
  indicatorColor: Colors.red,
  bottomAppBarColor: Colors.grey[700],
  iconTheme: IconThemeData(
    color: Colors.white
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.white30,
    textTheme: ButtonTextTheme.normal,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.grey[800],
    contentTextStyle: TextStyle(color: Colors.white70),
  ),
);

final pitchBlack = ThemeData(
  fontFamily: 'Raleway',
  textTheme: _textTheme,
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w700, fontSize: 16),
    unselectedLabelStyle: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w700, fontSize: 16),
    indicator: UnderlineTabIndicator(borderSide: BorderSide(color: Colors.red, width: 3)),
  ),
  brightness: Brightness.dark,
  primarySwatch: Colors.grey,
  accentColor: Colors.red,
  dividerColor: Colors.white30,
  scaffoldBackgroundColor: Colors.black,
  backgroundColor: Colors.black,
  cardColor: Colors.grey[900],
  splashColor: Colors.red[100],
  bottomAppBarColor: Colors.grey[900],
  indicatorColor: Colors.red,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.white30,
    textTheme: ButtonTextTheme.normal,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.grey[900],
    contentTextStyle: TextStyle(color: Colors.white60),
  ),
);
