import 'package:firebase_database/firebase_database.dart';

void createDB(DatabaseReference _dbref, String? uuid) {
  Map<String, dynamic> data = {
    'uuid' : uuid,
    'books' : ['Harry Potter 1', 'Kumbhojkar', 'Wimpy Kid',],
    'fav' : ['Wimpy Kid',],
  };
  _dbref.push().set(data);
}
