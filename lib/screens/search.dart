import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:new_project/screens/profile.dart';


class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    textController.addListener(onTextChange);
  }

  onTextChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: textController,
          decoration: const InputDecoration(
            labelText: "Search for a user...",
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('userss')
            .where("username", isEqualTo: textController.text)
            .get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile(
                                userID: snapshot.data.docs[index]["uid"]),
                          ));
                    },
                    title: Text(snapshot.data.docs[index]["username"]),
                    leading: CircleAvatar(
                      radius: 33,
                      backgroundImage:
                          NetworkImage(snapshot.data.docs[index]["imgLink"]),
                    ),
                  );
                });
          }

          return const CircularProgressIndicator(
            color: Colors.white,
          );
        },
      ),
    );
  }
}
