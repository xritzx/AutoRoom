import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:Autoroom/user.dart';
import 'package:Autoroom/main.dart' as globalUser;

class Info extends StatefulWidget {
  Info({Key key}) : super(key: key);

  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  
  final database = FirebaseDatabase.instance.reference();
  String username="User";
  String token;
  bool checkPassed = true;
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
    _checkToken();
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
     globalUser.user = user;
     print(user.toString());
    });
    setUser(user).then((b){
      setState(() {
       usernameController.text="Changes Saved";
      });
    });
    database.child(globalUser.user[0]).child('token').update({'public':globalUser.user[1]}).then((_)=>_checkToken());
  }

  void _checkToken(){
    database.child(globalUser.user[0]).child('token').once().then((DataSnapshot snap){
      if(snap.value['public']==snap.value['private']){
        setState(() {
         checkPassed = true;
        });
      }
      else{
        setState(() {
         checkPassed = false; 
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
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

             Padding(padding: EdgeInsets.all(10)),

             TextField(
               textInputAction: TextInputAction.send,
               controller: tokenController,
               obscureText: true,
               onSubmitted: _saveToken,
               textAlign: TextAlign.center,
             ),

             Padding(padding: EdgeInsets.all(10)),

             RaisedButton(
               onPressed: ()=> _saveToken(tokenController.text),
               textColor: Colors.white,
               color: checkPassed?Colors.green:Colors.redAccent,
               child: Text(!checkPassed?"Login":"Verified"),
             ),
           ],
         ),
      ),
    );
  }
}