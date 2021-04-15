import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chats').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error:${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading.....');
        }
        return ListView(
          children: snapshot.data.docs
              .map((documen) => ListTile(
                    title: Text(documen['name']),
                    subtitle: Text(documen['message']),
                  ))
              .toList(),
        );
      },
    );
  }
}
