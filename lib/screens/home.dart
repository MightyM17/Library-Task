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

  @override
  void initState() {
    super.initState();
    _dbref = FirebaseDatabase(databaseURL: "https://library-task-default-rtdb.asia-southeast1.firebasedatabase.app/").ref().child('Users');
  }

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    print(user?.uid);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          ElevatedButton(
            child: Text("Add"),
            onPressed: () {
              //updateDB(_dbref, user?.uid);
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
