import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme(){
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        backgroundColor: Colors.black,
        accentColor: Color.fromARGB(255, 218, 127, 255),
        scaffoldBackgroundColor: Colors.transparent,
        
        fontFamily: 'RobotoMono',

        splashColor: Colors.deepPurpleAccent,
    );
  }

SliderThemeData customSliderTheme(context) {
    return SliderTheme.of(context).copyWith(
      activeTrackColor: Theme.of(context).accentColor,
      inactiveTrackColor: Theme.of(context).accentColor.withAlpha(100),
      trackHeight: 10.0,
      thumbColor: Colors.white,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
      overlayColor: Colors.purple.withAlpha(200),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
      valueIndicatorColor: Colors.white,
    );
  }