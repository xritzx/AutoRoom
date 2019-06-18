import 'package:flutter/material.dart';

class RoomParam extends StatefulWidget {
  RoomParam({Key key}) : super(key: key);

  _RoomParamState createState() => _RoomParamState();
}

class _RoomParamState extends State<RoomParam> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("Temp and Humid"),
    );
  }
}