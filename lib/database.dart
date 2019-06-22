import 'package:firebase_database/firebase_database.dart';

class Database{

  final database = FirebaseDatabase.instance.reference();

  Future<void> createData({String child, Map<String,dynamic> payload}) async{
    if(child!=null) database.child(child).set(payload);
    else database.set(payload);
  }

  Future<void> updateData(Map<String, dynamic> payload,{String child}) async{
    if(child!=null)database.child(child).update(payload);
    else database.update(payload);
  }

  Future<void> fetchData(String child, void onData(DataSnapshot snapshot)) async{
    database.child(child).once().then(onData);
  }

  Future<void> removeData(String child) async{
    database.child(child).remove();
  }
}