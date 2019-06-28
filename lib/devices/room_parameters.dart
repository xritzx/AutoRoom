import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:Autoroom/main.dart';


class RoomParam extends StatefulWidget {
  RoomParam({Key key}) : super(key: key);

  _RoomParamState createState() => _RoomParamState();
}

class _RoomParamState extends State<RoomParam> {
  
  final database = FirebaseDatabase.instance.reference().child(user[0]);
  int state;
  int temperature;
  int humidity;
  StreamSubscription _streamSub;

  Future<StreamSubscription<Event>> getParamStream(void onData(var value)) async{
    StreamSubscription<Event> subscription = database.child("params").onValue.listen((Event event){
      var data = event.snapshot.value;
      onData(data);
    });
    return subscription;
  }

  @override
  void initState() {
    super.initState();
    getParamStream(_changeParams).then((StreamSubscription s)=>_streamSub = s);
  }

  @override
  void dispose() {
    super.dispose();
    _streamSub.cancel();
  }

  void _changeColor(int temp){
    setState(() {
      state = (temp<28)?0:1;
    });
  }

  void _changeParams(var data){
    int temp = data['temp'];
    int humid = data['humidity'];
    setState(() {
     temperature = temp;
     humidity = humid;
    });
    _changeColor(temp);
  }

  Widget _dataTile(String title, int value, {String unit}){
      return Container(
        width: 150,
        padding: EdgeInsets.all(10),
        color: Theme.of(context).unselectedWidgetColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(title, style: TextStyle(fontSize:20, color:Theme.of(context).primaryColor),),
            Text(value.toString()+unit, style: TextStyle(fontSize:30, color:Theme.of(context).primaryColor),),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                color: Theme.of(context).unselectedWidgetColor.withAlpha(2),
                height: 384,
                width: 172,
                child: FlareActor(
                  'assets/animations/thermometer.flr',
                  animation: (state!=0)?'red_glow':'blue_glow',
                ),
              ),
            ),

            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _dataTile("Temperature", temperature, unit:'\u00B0'),
                    _dataTile("Humidity", humidity, unit:'%'),
                  ],
                ),
              ),
            ),

          ],
        )
      ),
    );
  }
}