import 'package:flutter/material.dart';

class CustomButtomNavigationBar extends StatefulWidget {
  CustomButtomNavigationBar({Key key}) : super(key: key);

  _CustomButtomNavigationBarState createState() => _CustomButtomNavigationBarState();
}

class _CustomButtomNavigationBarState extends State<CustomButtomNavigationBar> {
  
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
          currentIndex: _selectedIndex,

          onTap: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
          
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,

          items: [

            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Tab(child:Image.asset('assets/images/fan.png',color: Colors.white)),
              title: new Text('Home'),
            ),

            BottomNavigationBarItem(
              icon: new Icon(Icons.mail),
              title: new Text('Messages'),
            ),

            BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              title: Text('Profile'),
            )

          ],
      );
  }
}
