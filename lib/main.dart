// Flutter imports
import 'package:flutter/material.dart';
// Custom Utilities imports
import 'package:Autoroom/appBar.dart';
import 'package:Autoroom/theme.dart';
import 'package:Autoroom/user.dart';
// Devices to Control
import 'package:Autoroom/devices/fan.dart';
import 'package:Autoroom/devices/lights.dart';
import 'package:Autoroom/devices/neopixels.dart';
import 'package:Autoroom/devices/room_parameters.dart';
import 'package:Autoroom/devices/info.dart';


List<String> user;

void main() {
  runApp(new AutoRoom());
}

class AutoRoom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AutoRoomState();
  }
}

class AutoRoomState extends State<AutoRoom> {

  int _selectedIndex = 0;
  bool themeMode = true;

  @override
  void initState() {

    getUser().then((List<String> _user){
      user = _user;
    });
    super.initState();
  }

  void _shiftPage(DragEndDetails details){
    double v = details.velocity.pixelsPerSecond.dx;
    if (v > 1000){
      setState(() {
       if(_selectedIndex>0) _selectedIndex--; 
      });
    }
    if(v < -1000){
      setState(() {
       if(_selectedIndex<_children.length-1) _selectedIndex++; 
      });
    }
    else return;
  }


  final List<Widget> _children = [
    Info(),
    Fan(),
    Lights(),
    NeoPixels(),
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
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeMode? lightTheme(): darkTheme(),
        home: GestureDetector(
          onLongPress: ()=>setState(()=>themeMode=!themeMode),
          onHorizontalDragEnd: _shiftPage,
          child: Scaffold(
            appBar: CustomAppBar(_titles[_selectedIndex]),
            body: _children[_selectedIndex],

            bottomNavigationBar: Theme(
              data: themeMode? lightTheme() : darkTheme(),
              child: BottomNavigationBar(
              currentIndex: _selectedIndex,

              onTap: (index){
                setState(() {
                  _selectedIndex = index;
                });
              },
              
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.shifting,

              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home,color: Color.fromRGBO(228, 172, 14, 1),),
                  activeIcon: Icon(Icons.home,color: Colors.pink[100],),
                  title: Text('Home',style: TextStyle(color: Colors.pink[100]),),
                ),

                BottomNavigationBarItem(
                  icon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/fan.png', color: Color.fromARGB(255,150,150,150)))),
                  activeIcon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/fan.png',color: Colors.pink[100]))),
                  title: Text('Fan',style: TextStyle(color: Colors.pink[100]),),
                ),

                BottomNavigationBarItem(
                  icon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/led.png',color: Color.fromARGB(255,150,150,150)))),
                  activeIcon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/led.png',color: Colors.pink[100]))),
                  title: Text('Lights',style: TextStyle(color: Colors.pink[100]),),
                ),

                BottomNavigationBarItem(
                  icon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/neopixels.png',color: Color.fromARGB(255,150,150,150)))),
                  activeIcon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/neopixels.png',color: Colors.pink[100]))),
                  title: Text('NeoPixels',style: TextStyle(color: Colors.pink[100]),),
                ),

                BottomNavigationBarItem(
                  icon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/thermometer.png',color: Color.fromARGB(255,150,150,150)))),
                  activeIcon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/thermometer.png',color: Colors.pink[100]))),
                  title: Text('Stats', style: TextStyle(color: Colors.pink[100]),),
                ),

              ],
            ),
          ), 
        ),  
      ),
    );
  }
}
