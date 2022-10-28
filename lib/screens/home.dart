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
  String uid = (FirebaseAuth.instance.currentUser?.uid).toString();
  var bookslist = '';
  var favlist = '';

  @override
  void initState() {
    super.initState();
    _dbref = FirebaseDatabase(databaseURL: "https://library-task-default-rtdb.asia-southeast1.firebasedatabase.app/").ref();
  }

  @override
  Widget build(BuildContext context) {
    String uid = (FirebaseAuth.instance.currentUser?.uid).toString();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          ElevatedButton(
            child: Text("List Books"),
            onPressed: () async {
              List books = await retrieveBooks(_dbref.child('Users/$uid'));
              var stringList = books.join(", ");
              setState(() => bookslist = stringList);
            },
          ),
          ElevatedButton(
            child: Text("List Favs"),
            onPressed: () async {
              List fav = await retrieveFav(_dbref.child('Users/$uid'));
              var stringList = fav.join(", ");
              setState(() => favlist = stringList);
            },
          ),
          ElevatedButton(
            child: Text("Add to Books"),
            onPressed: () {
              addData(_dbref.child('Users/$uid'), 'test1', false);
            },
          ),
          ElevatedButton(
            child: Text("Remove from Books"),
            onPressed: () {
              delData(_dbref.child('Users/$uid'), 'test1', false);
            },
          ),
          ElevatedButton(
            child: Text("Add to Fav"),
            onPressed: () {
              addData(_dbref.child('Users/$uid'), 'test1', true);
            },
          ),
          ElevatedButton(
            child: Text("Remove from Fav"),
            onPressed: () {
              delData(_dbref.child('Users/$uid'), 'test1', true);
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
          Text(
            'Books: $bookslist',
          ),
          Text(
            'Fav: $favlist',
          ),
        ],
      ),
    );
  }
}
