import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_klon/models/conversation.dart';
import 'package:whatsapp_klon/models/profile.dart';
import 'package:rxdart/rxdart.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Profile>> getContacts() async {
    var ref = _firestore.collection("profile");
    var document = await ref.get();

    return document.docs
        .map((snapshot) => Profile.fromSnapshot(snapshot))
        .toList();
  }

  Future<Conversation> startConversation(User user, Profile profile) async {
    var ref = _firestore.collection("conversation");
    var documneref = await ref.add({
      'displayMessage': '',
      'members': [user.uid, profile.id]
    });

    return Conversation(
        id: documneref.id,
        displayMessage: '',
        name: profile.userName,
        profileImage: profile.image);
  }

  Stream<List<Conversation>> getConversations(String userId) {
    var ref = _firestore
        .collection("conversation")
        .where("members", arrayContains: userId);
    var profileStrams = getContacts().asStream();
    var conversationStreams = ref.snapshots();
    return Rx.combineLatest2(
        conversationStreams,
        profileStrams,
        (QuerySnapshot conversations, List<Profile> profiles) =>
            conversations.docs.map((snapshot) {
              List<String> members = List.from(snapshot['members']);
              var profile = profiles.firstWhere((element) =>
                  element.id ==
                  members.firstWhere((member) => member != userId));
              return Conversation.fromSnapshot(snapshot, profile);
            }).toList());

//    return ref.snapshots().map(
    //    (list) => list.docs.map((e) => Conversation.fromSnapshot(e)).toList());
  }
}
