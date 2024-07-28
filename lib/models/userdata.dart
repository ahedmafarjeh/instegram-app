import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String username;
  String title;
  String email;
  String password;
  String imgURL;
  String uid;
  List folowers;
  List folowing;
  UserData(
      {required this.username,
      required this.title,
      required this.email,
      required this.password,
      required this.imgURL,
      required this.uid,
      required this.folowers,
      required this.folowing});
  // To convert the UserData(Data type) to   Map<String, Object>
  Map<String, dynamic> convert2Map() {
    return {
      "username": username,
      "title": title,
      "email": email,
      "passwrod": password,
      "imgLink": imgURL,
      "uid":uid,
      "folowers":folowers,
      "folowing":folowing,
    };
  }

   // function that convert "DocumentSnapshot" to a User
// function that takes "DocumentSnapshot" and return a User
 
 static convertSnap2Model(DocumentSnapshot snap) {
 var snapshot = snap.data() as Map<String, dynamic>;
 return UserData(
      username: snapshot["username"],
      title: snapshot["title"],
      email: snapshot["email"],
      password: snapshot["passwrod"],
      imgURL:snapshot["imgLink"] ,
      uid:snapshot["uid"],
      folowers:snapshot["folowers"],
      folowing:snapshot["folowing"],);
 }
}
