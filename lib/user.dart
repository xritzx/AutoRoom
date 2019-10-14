import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> getUser() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   List<dynamic> user = prefs.containsKey("user")? prefs.getStringList("user"):["0", "0"];
   return user;
}

Future<int> setUser(List<String> user) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList("user", user);
  return 1;
}