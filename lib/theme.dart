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