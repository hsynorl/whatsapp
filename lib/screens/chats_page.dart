import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get_it/get_it.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_klon/models/conversation.dart';
import 'package:whatsapp_klon/screens/converstaion_page.dart';
import 'package:whatsapp_klon/viewmodel/chats_model.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_klon/viewmodel/sign_in_model.dart';

class ChatsPage extends StatelessWidget {
  //final String userid = "XR22RpiceqWlo10yF2Sbhpn5Fno1";
  @override
  Widget build(BuildContext context) {
    var model = GetIt.instance<ChatsModel>();
    var user = Provider.of<SignInModel>(context).currentUser;
    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: StreamBuilder(
        stream: model.conversations(user.uid),
        builder:
            (BuildContext context, AsyncSnapshot<List<Conversation>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error:${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading.....');
          }
          return ListView(
            children: snapshot.data
                .map((documen) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(documen.profileImage),
                    ),
                    title: Text(documen.name),
                    subtitle: Text(documen.displayMessage),
                    trailing: Column(
                      children: [
                        Text("19.30"),
                        Container(
                          width: 20,
                          height: 20,
                          margin: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).accentColor),
                          child: Center(
                            child: Text(
                              "16",
                              textScaleFactor: 0.8,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => ConversationPage(
                                  userId: user.uid,
                                  conversation: documen)));
                    }))
                .toList(),
          );
        },
      ),
    );
  }
}
