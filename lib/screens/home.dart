import "package:flutter/material.dart";
import 'package:library_task/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Logout"),
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              print("Signed out");
              Navigator.push(context,
                MaterialPageRoute(builder: (builder) => SignInScreen()));
            });
          },
        ),
      ),
    );
  }
}
