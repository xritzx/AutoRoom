// Flutter imports
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
    return  GestureDetector(
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
      ),
    );
  }
}
