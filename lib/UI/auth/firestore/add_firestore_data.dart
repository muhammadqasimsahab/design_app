import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/UI/utlis/utlis.dart';
import 'package:flutter_application_1/Widget/rounded_button.dart';

class AddFirestoreData extends StatefulWidget {
  const AddFirestoreData({super.key});

  @override
  State<AddFirestoreData> createState() => _AddFirestoreDataState();
}

class _AddFirestoreDataState extends State<AddFirestoreData> {
  final postController = TextEditingController();
  bool loading = false;
  final fireStore = FirebaseFirestore.instance.collection('users');
  // final databaseRef = FirebaseDatabase.instance.ref('Post');
  // final databaseRef = FirebaseDatabase.instance
  //     .ref('test'); //for example we create table on firebase
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add firestore data'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "What is in your mind?",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            RoundButton(
                loading: loading,
                title: 'Add',
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  String id = DateTime.now().microsecondsSinceEpoch.toString();
                  fireStore
                      .doc()
                      .set({'title': postController.text.toString(), 'id': id})
                      .then((value) {})
                      .onError((error, stackTrace) {
                        utils().toastMessage(error.toString());
                      });
                })
          ],
        ),
      ),
    );
  }
}
