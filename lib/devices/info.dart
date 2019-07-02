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
  Map<String,dynamic> checkPassed = {
    'text' : 'Login',
    'color' : Colors.orange,
  };
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
      database.child(globalUser.user[0]).once().then((DataSnapshot data){
        if(data.value!=null){
          database.child(globalUser.user[0]).child('token').update({'public':globalUser.user[1]}).then((_)=>_checkToken());
        }
        else{
         _checkToken(exists: false);
        }
      });
    });

  }

  void _checkToken({bool exists}){
    if(exists==false){
      setState((){
        checkPassed = {
           'text' : 'Invalid Username',
           'color' : Colors.deepOrangeAccent,
         };
        });
    }
    database.child(globalUser.user[0]).child('token').once().then((DataSnapshot snap){
      if(snap.value['public']==snap.value['private']){
        setState(() {
        checkPassed = {
           'text' : 'Verified',
           'color' : Colors.green,
         };        
        });
      }
      else{
        setState(() {
         checkPassed = {
           'text' : 'Invalid Token',
           'color' : Colors.red,
         }; 
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Color.fromARGB(40, 120, 120, 120),
        padding: EdgeInsets.all(15),
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
               decoration: InputDecoration(
                hintText: 'Username',
               ),
             ),

             Padding(padding: EdgeInsets.all(10)),

             TextField(
               textInputAction: TextInputAction.send,
               controller: tokenController,
               obscureText: true,
               onSubmitted: _saveToken,
               textAlign: TextAlign.center,
               decoration: InputDecoration(
                hintText: 'Token',
               ),
             ),

             Padding(padding: EdgeInsets.all(10)),

             RaisedButton(
               onPressed: ()=> _saveToken(tokenController.text),
               textColor: Colors.white,
               color: checkPassed['color'],
               child: Text(checkPassed['text']),
             ),
           ],
         ),
      ),
    );
  }
}