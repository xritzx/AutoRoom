// Flutter imports
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
// Custom Utilities imports
import 'package:Autoroom/appBar.dart';
import 'package:Autoroom/bottomNavBar.dart';
import 'package:Autoroom/theme.dart';
// Devices to Control
import 'package:Autoroom/devices/fan.dart';
import 'package:Autoroom/devices/lights.dart';
import 'package:Autoroom/devices/neopixels.dart';
import 'package:Autoroom/devices/room_parameters.dart';
import 'package:Autoroom/devices/info.dart';

void main() {
  runApp(
    new MaterialApp(
      home: AutoRoom(),
      routes: <String, WidgetBuilder>{
        '/main': (BuildContext context) => new AutoRoom(),
        // '/settings': (BuildContext context) => new Fan(),
      },
      theme: darkTheme(),
    )
  );
}



class AutoRoom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AutoRoomState();
  }
}

class AutoRoomState extends State<AutoRoom> {

  int _selectedIndex = 0;

  final List<Widget> _children = [
    Info(),
    Fan(),
    Lights(),
    Neopixels(),
    RoomParam(),
  ];

  final List<String> _titles = [
    "AUTOROOM",
    "Fan",
    "Lights",
    "NeoPixels",
    "Room Parameters",
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

        appBar: CustomAppBar(_titles[_selectedIndex]),
        body: _children[_selectedIndex],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,

          onTap: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
          
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: new Text('Home'),
            ),

            BottomNavigationBarItem(
              icon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/fan.png',color: Colors.white))),
              activeIcon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/fan.png',color: Theme.of(context).accentColor))),
              title: Text('Fan'),
            ),

            BottomNavigationBarItem(
              icon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/led.png',color: Colors.white))),
              activeIcon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/led.png',color: Theme.of(context).accentColor))),
              title: Text('Lights'),
            ),

            BottomNavigationBarItem(
              icon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/neopixels.png',color: Colors.white))),
              activeIcon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/neopixels.png',color: Theme.of(context).accentColor))),
              title: Text('NeoPixels'),
            ),

            BottomNavigationBarItem(
              icon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/thermometer.png',color: Colors.white))),
              activeIcon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/thermometer.png',color: Theme.of(context).accentColor))),
              title: new Text('Stats'),
            ),

          ],
      ), 
    );
  }
}
