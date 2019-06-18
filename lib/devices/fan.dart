import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class Fan extends StatefulWidget {
  Fan({Key key}) : super(key: key);

  _FanState createState() => _FanState();
}

class _FanState extends State<Fan> {
  
  int state=0;
  
  String url = "https://autoroom-948ae.firebaseio.com/autoroom/fan.json";

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Column(
        children: <Widget>[
          Container(
            width: 500,
            height: 500,
            child: GestureDetector(
              onTap: _change,
              child: FlareActor(
                'assets/animations/switch.flr',
                animation: state!=0?'On':'Off',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _change(){
    setState(() {
      if(state==1){
        state = 0;
        _updateDB();
      }
      else if(state==0){
        state = 1;
        _updateDB();
      }
    });
  }

  Future<void> _updateDB() async{
        Map<String,int> data ={
          "fan":(state+2)%2,
        };
        await http.put(url, body:jsonEncode((state+2)%2));
        print(jsonEncode(data).toString());
  }

}