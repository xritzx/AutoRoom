import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:Autoroom/theme.dart';
import 'dart:async';


class Lights extends StatefulWidget {
  Lights({Key key}) : super(key: key);

  _LightsState createState() => _LightsState();
}

class _LightsState extends State<Lights> {

  final database = FirebaseDatabase.instance.reference();
  int _intensity=0;

  @override
  void initState() {
    super.initState();
    _fetchIntensity();
  }

  void _updateIntensity(val){
    setState(() {
     _intensity = val.toInt(); 
    });
  }

  Future<void> _fetchIntensity() async{
    database.child("light").once().then((DataSnapshot snapshot){
      setState(() {
       _intensity = (snapshot.value/2.55).toInt(); 
      });
    });
  }

  Future<void> _updateIntensityDB(double val) async{
    database.update({'light': (val*2.55).toInt()});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
            child: Text("INTENSITY", style: TextStyle(fontSize: 20, color: Colors.black),),
            ),
          Padding(padding: EdgeInsets.all(30),),
          Container(
            padding: EdgeInsets.all(50),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).accentColor,
                  blurRadius: _intensity/5,
                  spreadRadius: _intensity/5,
                ),
              ],
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Text(_intensity.toString()+"%",
             style: TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: 30,
               color: Theme.of(context).accentColor.withAlpha((_intensity*2)+50),
               ),
              ),
          ),
          Padding(padding: EdgeInsets.all(30),),
          Container(
             child: SliderTheme(
              data: customSliderTheme(context),
              child: Slider(
                min: 0,
                divisions: 100,
                max: 100,
                value: _intensity.toDouble(),
                onChanged: _updateIntensity,
                onChangeEnd: _updateIntensityDB,
               ),
             ),
          ),
        ],
      ),
    );
  }
}