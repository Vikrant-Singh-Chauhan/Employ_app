import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employ_form/firebase%20file/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'employdata.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final user = FirebaseAuth.instance.currentUser;
  Stream<QuerySnapshot>? employ_stream;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    load_employ_data();
  }



  void load_employ_data() {
    employ_stream = DatabaseMethods().getEmployDetails();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Employs",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            Text(
              "_Data",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10),
        child: StreamBuilder(
          stream: employ_stream,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading data'));
            } else {
              if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
                return const Center(child: Text("No Data Found"));
              }
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Name: ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ds["Name"],
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Age: ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ds["Age"].toString(),
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        namecontroller.text = ds["Name"];
                                        agecontroller.text =
                                            ds["Age"].toString();
                                        locationcontroller.text =
                                            ds["Location"];
                                        editEmployDetails(ds.id);
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    GestureDetector(
                                      onTap: () async {
                                        DatabaseMethods().deleteData(ds.id);
                                        Fluttertoast.showToast(
                                            msg: "Employee deleted",
                                            toastLength: Toast.LENGTH_SHORT);
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Location: ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ds["Location"],
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Employdata()),
          );
        },
        child: const Icon(Icons.add, color: Colors.blue),
      ),
    );
  }

  Future editEmployDetails(String id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.cancel),
                  ),
                  const SizedBox(width: 50),
                  const Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const Text(
                    "Details",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text("Name",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextField(controller: namecontroller),
              const SizedBox(height: 10),
              const Text("Age",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextField(
                  controller: agecontroller,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 10),
              const Text("Location",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextField(controller: locationcontroller),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  Map<String, dynamic> updateInfo = {
                    "Name": namecontroller.text,
                    "Age": int.tryParse(agecontroller.text) ?? 0,
                    "Location": locationcontroller.text,
                  };

                  await DatabaseMethods().updateEmployDetails(id, updateInfo);
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: "Employee updated successfully");
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      );
}
