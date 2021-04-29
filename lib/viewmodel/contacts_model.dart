

import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_klon/core/services/chats_service.dart';
import 'package:whatsapp_klon/core/services/locator.dart';
import 'package:whatsapp_klon/models/profile.dart';
import 'package:whatsapp_klon/screens/converstaion_page.dart';
import 'package:whatsapp_klon/viewmodel/base_model.dart';

class ContactsModel extends BaseModel{
  final _chatService = getIt<ChatService>();
  Future <List<Profile>> getContantacts(String query) async{
    var contacts=await _chatService.getContacts();

    var filteredContacts=contacts.where((profile) => profile.userName.startsWith(query ?? ""),);
  
    return filteredContacts;
  }

 Future <void> startConversation(User user, Profile profile) async {
   var conversation=await _chatService.startConversation(user,profile);
   navigatorService.navigateTo(ConversationPage(conversation: conversation, userId: user.uid,));
 }
}