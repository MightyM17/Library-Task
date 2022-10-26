import 'package:flutter/material.dart';
import 'package:library_task/screens/signin.dart';
import 'package:library_task/screens/util/reuuse.dart';
import 'package:library_task/screens/home.dart';
  import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _pass = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _user = TextEditingController();
  var _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30,),
              inputText('Username', Icons.email_outlined, false, _user),
              SizedBox(height: 20,),
              inputText('Email', Icons.email_outlined, false, _email),
              SizedBox(height: 20,),
              inputText('Password', Icons.person_outline, true, _pass),
              SizedBox(height: 20,),
              singInUp(context, false, () {
                FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _email.text,
                    password: _pass.text,
                ).then((value) {
                  setState(() => _error = 'Signed Up Successfully');
                  print(_error);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => HomePage()));
                }).onError((error, stackTrace) {
                  setState(() => _error = error.toString());
                  print(_error);
                });
              }),
              SizedBox(height: 20,),
              Text(
                _error,
                style: TextStyle(color: Colors.red,),
              ),
              SizedBox(height: 20,),
              signIn(),
            ],
          ),
        ),
      ),
    );
  }

  Row signIn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account? ",
          style: TextStyle(color: Colors.black),),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          },
          child: Text("Sign In!",
            style: TextStyle(color: Colors.blue),),
        ),
      ],
    );
  }
}
