import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
  fontFamily: GoogleFonts.lato().fontFamily,
  // textTheme: _textTheme,
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
    labelColor: Colors.black,
    unselectedLabelColor: Colors.black54,
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
    indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.red, width: 3)),
  ),
  brightness: Brightness.light,
  primarySwatch: Colors.blueGrey,
  accentColor: Colors.red,
  dividerColor: Colors.black26,
  scaffoldBackgroundColor: Colors.grey[100],
  backgroundColor: Colors.grey[100],
  cardColor: Colors.white,
  splashColor: Colors.red[200],
  bottomAppBarColor: Colors.white,
  indicatorColor: Colors.red,
  iconTheme: IconThemeData(color: Colors.black),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.white70,
    textTheme: ButtonTextTheme.normal,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.black,
    contentTextStyle: TextStyle(color: Colors.white),
  ),
);

final darkTheme = ThemeData(
  fontFamily: GoogleFonts.lato().fontFamily,
  // textTheme: _textTheme,
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
    indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.red, width: 3)),
  ),
  brightness: Brightness.dark,
  primarySwatch: Colors.blueGrey,
  accentColor: Colors.red,
  dividerColor: Colors.white30,
  scaffoldBackgroundColor: Colors.grey[850],
  backgroundColor: Colors.grey[850],
  cardColor: Colors.grey[800],
  splashColor: Colors.red[100],
  indicatorColor: Colors.red,
  bottomAppBarColor: Colors.grey[700],
  iconTheme: IconThemeData(color: Colors.white),
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
  fontFamily: GoogleFonts.lato().fontFamily,
  // textTheme: _textTheme,
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
    indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.red, width: 3)),
  ),
  brightness: Brightness.dark,
  primarySwatch: Colors.blueGrey,
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
