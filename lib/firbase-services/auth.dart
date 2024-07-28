import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_project/firbase-services/storage.dart';
import 'package:new_project/models/userdata.dart';
import 'package:new_project/shared/snackbar.dart';

class AuthMethods {
  register(
      {required email,
      required password,
      required context,
      required username,
      required title,
      required imgName,
      required imgPath}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // get img URL
      String imgLink = await getImgURL(imgName: imgName, imgPath: imgPath, folderName: "profileImg");
      // add user to database
      CollectionReference users =
          FirebaseFirestore.instance.collection('userss');
      UserData userData = UserData(
          username: username,
          title: title,
          email: email,
          password: password,
          imgURL: imgLink,
          uid: credential.user!.uid,
          folowers: [],
          folowing: []);
      users
          .doc(credential.user!.uid)
          .set(userData.convert2Map()) // .set() take map as a parameter
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR :  ${e.code} ");
    }
  }
// sign in function
signIn({required email, required password, required context}) async {
  try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password
  );
} on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR :  ${e.code} ");
    }

}

   // functoin to get user details from Firestore (Database)
Future<UserData> getUserDetails() async {
   DocumentSnapshot snap = await FirebaseFirestore.instance.collection('userss').doc(FirebaseAuth.instance.currentUser!.uid).get(); 
   return UserData.convertSnap2Model(snap);
 }

}
