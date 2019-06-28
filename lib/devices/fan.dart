import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

import 'package:Autoroom/main.dart';

class Fan extends StatefulWidget {
  Fan({Key key}) : super(key: key);

  _FanState createState() => _FanState();
}

class _FanState extends State<Fan> {
  
  final database = FirebaseDatabase.instance.reference().child(user[0]);
  int state;
  
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
      state = (state==0)?1:0;
      _updateDB();
    });
  }

  Future<void> _updateDB() async{
    database.update({'fan':state});
  }

  Future<void> _fetchState() async{
    database.child('fan').once().then((DataSnapshot snapshot){
      setState(() {
       state = snapshot.value;
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
            Container(
              decoration: BoxDecoration(
                color: state==1?Theme.of(context).unselectedWidgetColor:Theme.of(context).primaryColor,
                border: Border.all(color: Theme.of(context).unselectedWidgetColor),
              ),
              padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
              child: Text("TOGGLE", style: TextStyle(fontSize: 25, color: state==1?Theme.of(context).primaryColor:Theme.of(context).unselectedWidgetColor),),
            ),
            Padding(padding: EdgeInsets.all(30),),
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