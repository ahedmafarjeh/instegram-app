

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_project/firbase-services/storage.dart';
import 'package:new_project/models/post.dart';
import 'package:new_project/shared/snackbar.dart';
import 'package:uuid/uuid.dart';

class FBMethods {
  uploadPost(
      {required imgName,
      required imgPath,
      required profileImg,
      required username,
      required description,
      required context}) async {
    try {
      // get img URL
      String imgLink = await getImgURL(
          imgName: imgName,
          imgPath: imgPath,
          folderName: "postImg/${FirebaseAuth.instance.currentUser!.uid}");
      String pid = const Uuid().v1();
      // add user to database
      CollectionReference posts =
          FirebaseFirestore.instance.collection('posts');
      PostData postData = PostData(
          profileImg: profileImg,
          username: username,
          description: description,
          imgPost: imgLink,
          uid: FirebaseAuth.instance.currentUser!.uid,
          postId: pid,
          datePublished: DateTime.now(),
          likes: []);
      posts
          .doc(pid)
          .set(postData.convert2Map()) // .set() take map as a parameter
          .then((value) => print("Post Added"))
          .catchError((error) => print("Failed to add post: $error"));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR :  ${e.code} ");
    }
  }

  uploadComment(
      {required context,
      required commentText,
      required postId,
      required profileImg,
      required username,
      required uid}) async {
    if (commentText.isNotEmpty) {
      String commentId = const Uuid().v1();
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(postId)
          .collection("comments")
          .doc(commentId)
          .set({
        "profilePic": profileImg,
        "username": username,
        "textComment": commentText,
        "dataPublished": DateTime.now(),
        "uid": uid,
        "commentId": commentId
      });
    } else {
      showSnackBar(context, "Empty Comment!!");
    }
  }

  likePost({required Map post, required context}) async {
    try {
      if (post["likes"].contains(FirebaseAuth.instance.currentUser!.uid)) {
        await FirebaseFirestore.instance
            .collection("posts")
            .doc(post["postId"])
            .update({
          "likes":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection("posts")
            .doc(post["postId"])
            .update({
          "likes":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
        });
      }
    } catch (e) {
      showSnackBar(context, "Error happened!");
    }
  }
}
