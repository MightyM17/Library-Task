class Person{
  String? key;
  PersonData? personData;

  Person({this.key,this.personData});
}

class PersonData{
  String? uuid;
  Map<String, String>? books;
  Map<String, String>? fav;

  PersonData({this.uuid, this.books, this.fav});

  PersonData.fromJson(Map<dynamic,dynamic> json){
    uuid = json["uuid"];
    books = json["books"];
    books = json["fav"];
  }
}