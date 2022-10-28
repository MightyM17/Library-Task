import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:library_task/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:library_task/realtime/managedb.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DatabaseReference _dbref;
  late FirebaseDatabase _fbref;
  String uid = (FirebaseAuth.instance.currentUser?.uid).toString();

  @override
  void initState() {
    super.initState();
    _fbref = FirebaseDatabase(databaseURL: "https://library-task-default-rtdb.asia-southeast1.firebasedatabase.app/");
    _dbref = FirebaseDatabase(databaseURL: "https://library-task-default-rtdb.asia-southeast1.firebasedatabase.app/").ref();
  }

  @override
  Widget build(BuildContext context) {
    String uid = (FirebaseAuth.instance.currentUser?.uid).toString();
    print("Home Screen " + uid);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          ElevatedButton(
            child: Text("Add"),
            onPressed: () {
              modifyData(_dbref.child('Users/$uid'));
            },
          ),
        ElevatedButton(
          child: Text("Logout"),
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              print("Signed out");
              Navigator.push(context,
                MaterialPageRoute(builder: (builder) => SignInScreen()));
            });
          },
        ),
        ],
      ),
    );
  }
}
