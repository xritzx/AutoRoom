import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> getUser() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.containsKey('user')){
    final user = prefs.getStringList('user');
    return user;
  }
  else{
    final user = ["new user", "na"];
    await setUser(user);
    return user;
  }
}

Future<int> setUser(List<String> user) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('user', user);
  return 1;
}