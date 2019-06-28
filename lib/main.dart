// Flutter imports
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// Custom Utilities imports
import 'package:Autoroom/appBar.dart';
import 'package:Autoroom/theme.dart';
// Devices to Control
import 'package:Autoroom/devices/fan.dart';
import 'package:Autoroom/devices/lights.dart';
import 'package:Autoroom/devices/neopixels.dart';
import 'package:Autoroom/devices/room_parameters.dart';
import 'package:Autoroom/devices/info.dart';
import 'package:Autoroom/user.dart';


List<String> user;

void main() async{

  await getUser().then((List<String> _user){
    user = _user;
  });

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
        theme: themeMode?lightTheme():darkTheme(),
        home: GestureDetector(
          onLongPress: ()=>setState(()=>themeMode=!themeMode),
          onHorizontalDragEnd: _shiftPage,
          child: Scaffold(
            appBar: CustomAppBar(_titles[_selectedIndex]),
            body: _children[_selectedIndex],

            bottomNavigationBar: BottomNavigationBar(
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
                  icon: Icon(Icons.home,color: Colors.deepPurple,),
                  activeIcon: Icon(Icons.home,color: Colors.deepOrangeAccent,),
                  title: Text('Home',style: TextStyle(color: Colors.deepOrangeAccent),),
                ),

                BottomNavigationBarItem(
                  icon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/fan.png', color: Color.fromARGB(255,150,150,150)))),
                  activeIcon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/fan.png',color: Colors.deepOrangeAccent))),
                  title: Text('Fan',style: TextStyle(color: Colors.deepOrangeAccent),),
                ),

                BottomNavigationBarItem(
                  icon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/led.png',color: Color.fromARGB(255,150,150,150)))),
                  activeIcon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/led.png',color: Colors.deepOrangeAccent))),
                  title: Text('Lights',style: TextStyle(color: Colors.deepOrangeAccent),),
                ),

                BottomNavigationBarItem(
                  icon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/neopixels.png',color: Color.fromARGB(255,150,150,150)))),
                  activeIcon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/neopixels.png',color: Colors.deepOrangeAccent))),
                  title: Text('NeoPixels',style: TextStyle(color: Colors.deepOrangeAccent),),
                ),

                BottomNavigationBarItem(
                  icon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/thermometer.png',color: Color.fromARGB(255,150,150,150)))),
                  activeIcon: SizedBox( width:35, height:25, child: Tab(child:Image.asset('assets/images/thermometer.png',color: Colors.deepOrangeAccent))),
                  title: Text('Stats',style: TextStyle(color: Colors.deepOrangeAccent),),
                ),

              ],
          ), 
        ),  
      ),
    );
  }
}
