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
  
  int state;
  
  String url = "https://autoroom-948ae.firebaseio.com/autoroom/fan.json";

  @override
  void initState() {
    super.initState();
    _fetchState();
  }

  @override
  void dispose() {
    super.dispose();
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

 Future<void> _fetchState() async{
   await http.get(url).then((res){
     setState(() {
      state = json.decode(res.body); 
     });
   });
 }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                child: Text("Toggle",style: TextStyle(fontSize: 30),),
              ),
            ),
            Center(
              child: Container(
                width: 294,
                height: 110,
                child: GestureDetector(
                  onTap: _change,
                  child: FlareActor( 
                    'assets/animations/slide.flr', // 294 X 110
                    animation: state!=0?'On':'Off',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}