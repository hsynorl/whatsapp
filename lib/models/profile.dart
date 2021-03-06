import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String id;
  String userName;
  String image;

  Profile({this.id, this.image, this.userName});
  factory Profile.fromSnapshot(DocumentSnapshot snapshot) {
    return Profile(
        id: snapshot.id,
        userName: snapshot["userName"],
        image: snapshot["image"]);
  }
}
