import 'package:firebase_database/firebase_database.dart';

void createDB(DatabaseReference _dbref, String? uuid) {
  Map<String, dynamic> data = {
    'uuid' : uuid,
    'books' : ['Harry Potter 1', 'Kumbhojkar', 'Wimpy Kid',],
    'fav' : ['Wimpy Kid',],
  };
  _dbref.set(data);
}

void retrieveData(DatabaseReference _dbref) async {
  //Stream or once?
  Stream<DatabaseEvent> stream = _dbref.onValue;

  stream.listen((DatabaseEvent event) {
    print('Event Type: ${event.type}'); // DatabaseEventType.value;
    print('Snapshot: ${event.snapshot}'); // DataSnapshot
    print(event.snapshot.value);
  });
}

void modifyData(DatabaseReference _dbref) async{
  //DatabaseReference _ref = FirebaseDatabase(databaseURL: "https://library-task-default-rtdb.asia-southeast1.firebasedatabase.app/").ref().child('Users/$uid');
  await _dbref.set({
    'books' : ['Harry Potter 909090',],
    'fav' : ['Wimpy Kid 909090',],
  });
}

void delData(DatabaseReference _dbref) async{
  //DatabaseReference _ref = FirebaseDatabase(databaseURL: "https://library-task-default-rtdb.asia-southeast1.firebasedatabase.app/").ref().child('Users/$uid');
  await _dbref.remove();
}
