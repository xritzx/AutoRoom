import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_database/firebase_database.dart';




class RoomParam extends StatefulWidget {
  RoomParam({Key key}) : super(key: key);

  _RoomParamState createState() => _RoomParamState();
}

class _RoomParamState extends State<RoomParam> {
  
  final database = FirebaseDatabase.instance.reference();
  int state;
  int temperature;
  int humidity;
  StreamSubscription _streamSub;

  Future<StreamSubscription<Event>> getParamStream(void onData(var value)) async{
    StreamSubscription<Event> subscription = database.child("params").onValue.listen((Event event){
      var data = event.snapshot.value;
      print(data.toString());
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

  // Future<void> _fetchData() async{
  //   database.child("temp").once().then((DataSnapshot snapshot){
  //     setState(() {
  //      temperature = snapshot.value;
  //      _changeParams(temp: temperature);
  //     });
  //   });
  //   database.child("humidity").once().then((DataSnapshot snapshot){
  //     setState(() {
  //       humidity = snapshot.value;
  //       _changeParams(humid: humidity);
  //     });
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: new Column(
          children: <Widget>[
            Center(
              child: Container(
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
                child: Column(
                  children: <Widget>[
                    
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text("Temperature | ", style: TextStyle(fontSize:30),),
                        Text(temperature.toString() , style: TextStyle(fontSize:30),),
                      ],
                    ),
                  
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text("Humidity | ", style: TextStyle(fontSize:30),),
                        Text(humidity.toString()+"%", style: TextStyle(fontSize:30),),
                      ],
                    ),
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