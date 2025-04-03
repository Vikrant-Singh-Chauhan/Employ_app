import 'package:employ_form/firebase%20file/database.dart';
import 'package:employ_form/login_and_sign_up/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Employdata extends StatefulWidget {
  const Employdata({super.key});

  @override
  State<Employdata> createState() => _EmploydataState();
}

class _EmploydataState extends State<Employdata> {

  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  singOut(){
    return FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Employ",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            Text(
              "_Form",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 5,
                ),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Age",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 5,
                ),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: agecontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Location",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 5,
                ),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: locationcontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        String Id  = randomAlphaNumeric(10);
                        Map<String,dynamic>employInfoMap={
                          "Name":namecontroller.text,
                          "Age":agecontroller.text,
                          "Id":Id,
                          "Location":locationcontroller.text
                        };
                        await DatabaseMethods().addEmployDetails(employInfoMap, Id).then((value){
                          Fluttertoast.showToast(
                              msg: "Employ data has filled successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ))),
              Center(child: ElevatedButton(onPressed: (){

                  Fluttertoast.showToast(
                      msg: "Now you are Sign Out",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.yellowAccent,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                  singOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loginscreen(),));
                  }, child: Text("SignOut")))
            ],
          ),
        ),
      ),
    );
  }
}
