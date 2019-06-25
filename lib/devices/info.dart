import 'package:flutter/material.dart';
import 'package:Autoroom/user.dart';

class Info extends StatefulWidget {
  Info({Key key}) : super(key: key);

  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  
  String username="User";
  String token;
  List<String> user;

  final usernameController = TextEditingController();
  final tokenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUser().then((List<String> userData){
      setState(() {
        user = userData;
        username = user[0];
      });
    });
    
  }
  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    tokenController.dispose();
  }

  void _saveUser(String _username){
    setState(() {
     username = _username;
    });
  }
  void _saveToken(String _token){
    setState(() {
     token = _token;
     user = [username, token];
     print(user.toString());
    });
    setUser(user).then((b){
      setState(() {
       usernameController.text="Changes Saved";
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[  
             Text("Welcome "+username),
             TextField(
               controller: usernameController,
               onChanged: _saveUser,
               onTap: ()=>usernameController.text="",
               textAlign: TextAlign.center,
             ),
             TextField(
               textInputAction: TextInputAction.send,
               controller: tokenController,
               obscureText: true,
               onSubmitted: _saveToken,
               textAlign: TextAlign.center,
             ),
           ],
         ),
      ),
    );
  }
}