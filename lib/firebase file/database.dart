import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods {
  /// add
  Future addEmployDetails(Map<String, dynamic> employInfoMap, String Id) async {
    return FirebaseFirestore.instance.collection("Employ").doc(Id).set(employInfoMap);
  }
 /* /// get
   Future<Stream<QuerySnapshot>> getEmployDetails()async{
    return await FirebaseFirestore.instance.collection("Employ").snapshots();
   }*/
  /// Get Employee Details  ///
  Stream<QuerySnapshot> getEmployDetails() {
    return FirebaseFirestore.instance.collection("Employ").snapshots();
  }
  /// update data here ///

  // Future updateEmployDetails(String Id, Map<String,dynamic> updateInfo ){
  //   return await FirebaseFirestore.instance.collection("Employ").doc(Id).update(updateInfo);
  // }

  Future updateEmployDetails(String Id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance.collection("Employ").doc(Id).update(updateInfo);
  }
  /// delete ///
 Future deleteData(String Id )async {
   return await FirebaseFirestore.instance.collection("Employ").doc(Id).delete();
 }
}
