import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:library_task/models/model.dart';
import 'package:library_task/realtime/managedb.dart';
import 'package:library_task/screens/signin.dart';
import 'package:library_task/util/reuuse.dart';
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
  late DatabaseReference _dbref;
  var user = FirebaseAuth.instance.currentUser;

  List<Person> personList = [];

  void retrieveData() async {
    //Stream or once?
    Stream<DatabaseEvent> stream = _dbref.onValue;

    stream.listen((DatabaseEvent event) {
      print('Event Type: ${event.type}'); // DatabaseEventType.value;
      print('Snapshot: ${event.snapshot}'); // DataSnapshot
      print(event.snapshot.value);
    });
  }

  void modifyData(String uid) async{
    DatabaseReference _ref = FirebaseDatabase(databaseURL: "https://library-task-default-rtdb.asia-southeast1.firebasedatabase.app/").ref().child('Users/$uid');
    await _ref.set({
      'books' : ['Harry Potter 909090',],
      'fav' : ['Wimpy Kid 909090',],
    });
  }

  @override
  void initState() {
    super.initState();
    _dbref = FirebaseDatabase(databaseURL: "https://library-task-default-rtdb.asia-southeast1.firebasedatabase.app/").ref().child('Users');
    retrieveData();
  }

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
                  String uid = (FirebaseAuth.instance.currentUser?.uid).toString();
                  print(_error);
                  createDB(_dbref, uid);
                  modifyData(uid);
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
