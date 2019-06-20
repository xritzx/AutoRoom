import 'package:flutter/material.dart';

class Lights extends StatefulWidget {
  Lights({Key key}) : super(key: key);

  _LightsState createState() => _LightsState();
}

class _LightsState extends State<Lights> {
  double _intensity=0;

  void _updateIntensity(val){
    setState(() {
     _intensity = val; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(_intensity.toString()),
          Padding(padding: EdgeInsets.all(30),),
          Container(
             child: Slider(
              min: 0,
              max: 100,
              value: _intensity,
              onChanged: _updateIntensity,
              activeColor: Theme.of(context).accentColor,
              inactiveColor: Theme.of(context).accentColor.withAlpha(100),
             ),
          ),
        ],
      ),
    );
  }
}