import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';



class RoomParam extends StatefulWidget {
  RoomParam({Key key}) : super(key: key);

  _RoomParamState createState() => _RoomParamState();
}

class _RoomParamState extends State<RoomParam> {
  int state;
  int temperature;
  int humidity;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  void _changeColor(int temp){
    setState(() {
      if(temp>=28){
        state = 1;
      }
      else if(temp<28){
        state = 0;
      }
    });
  }

  Future<void> _fetchData() async{
      String url = "https://autoroom-948ae.firebaseio.com/autoroom/";

      http.get(url+"temp.json").then((res){
          setState(() {
            temperature = json.decode(res.body);
            _changeColor(temperature);
          });
        }
      );
      http.get(url+"humidity.json").then((res){
        setState(() {
         humidity = json.decode(res.body);
        });
      });
  }



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: RefreshIndicator(
          onRefresh: _fetchData,
          child: new ListView(

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
                        children: <Widget>[
                          Text("Temperature | ", style: TextStyle(fontSize:30),),
                          Text(temperature.toString(), style: TextStyle(fontSize:30),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
          ),
        )
      ),
    );
  }
}