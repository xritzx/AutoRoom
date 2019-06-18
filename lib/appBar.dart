import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget{
  
  final String title;

  CustomAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: new Text(this.title),
          backgroundColor: Color.fromARGB(255, 3, 3, 3),
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
