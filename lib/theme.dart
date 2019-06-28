import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme(){
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        backgroundColor: Colors.black,
        accentColor: Color.fromARGB(255, 218, 127, 255),
        unselectedWidgetColor: Colors.white,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'RobotoMono',
        splashColor: Colors.deepPurpleAccent,
    );
  }
ThemeData lightTheme(){
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        backgroundColor: Colors.white,
        unselectedWidgetColor: Colors.black,
        accentColor: Color.fromARGB(255, 255, 36, 36),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'RobotoMono',
        splashColor: Colors.deepOrangeAccent,
    );
  }


SliderThemeData customSliderTheme(context) {
    return SliderTheme.of(context).copyWith(
      activeTrackColor: Theme.of(context).accentColor,
      inactiveTrackColor: Theme.of(context).accentColor.withAlpha(50),
      trackHeight: 10.0,
      thumbColor: Theme.of(context).unselectedWidgetColor,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
      overlayColor: Theme.of(context).accentColor.withAlpha(200),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
      valueIndicatorColor: Theme.of(context).unselectedWidgetColor,
    );
  }