
import 'package:get_it/get_it.dart';

import 'package:whatsapp_klon/core/services/chats_service.dart';
import 'package:whatsapp_klon/models/conversation.dart';
import 'package:whatsapp_klon/viewmodel/base_model.dart';

class ChatsModel extends BaseModel{
  final ChatService _db= GetIt.instance<ChatService>();
  Stream<List<Conversation>> conversations(String userId){
    return _db.getConversations(userId);
  }
}