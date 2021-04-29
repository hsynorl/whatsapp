import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_klon/models/profile.dart';

class Conversation {
  String id;
  String name;
  String profileImage;
  String displayMessage;
  Conversation({this.id, this.name, this.profileImage, this.displayMessage});

  factory Conversation.fromSnapshot(DocumentSnapshot snapshot ,Profile profile ) {
    return Conversation(
        id: snapshot.id,
        name:profile.userName,
        profileImage: profile.image ,
             displayMessage: snapshot.data()["displayMessage"]);
  }
}
