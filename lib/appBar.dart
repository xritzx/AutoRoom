import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget{
  
  final String title;
  CustomAppBar(this.title);

  _CustomAppBarState createState() => _CustomAppBarState();
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar>{

  @override
  Widget build(BuildContext context) {
    return AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: new Text(widget.title),
          backgroundColor: Theme.of(context).primaryColor,
      );
  }

}
