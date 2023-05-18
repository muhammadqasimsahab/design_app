import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ShowOwnData extends StatefulWidget {
  const ShowOwnData({super.key});

  @override
  State<ShowOwnData> createState() => _ShowOwnDataState();
}

class _ShowOwnDataState extends State<ShowOwnData> {
  final auth = FirebaseAuth.instance;
  final showdatref = FirebaseDatabase.instance.ref('Own');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Own Data'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
                  defaultChild: Text('Loading...'),
                  query: showdatref,
                  itemBuilder: (context, snapshot, animation, index) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      // subtitle: Text(snapshot.child('id').value.toString()),
                      onTap: () {},
                    );
                  })),
        ],
      ),
    );
  }
}
