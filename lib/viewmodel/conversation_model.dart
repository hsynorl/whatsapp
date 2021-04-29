import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_klon/core/services/locator.dart';
import 'package:whatsapp_klon/core/services/storage_service.dart';
import 'package:whatsapp_klon/viewmodel/base_model.dart';
import 'package:image_picker/image_picker.dart';

class ConversationModel extends BaseModel {
  final StorageService _storageService = getIt<StorageService>();
  String mediaUrl = '';
  CollectionReference _ref;
  Stream<QuerySnapshot> getConversation(String id) {
    _ref = FirebaseFirestore.instance.collection('conversation/$id/messages');
    return _ref.orderBy('timeStamp').snapshots();
  }

  Future<DocumentReference> add(Map<String, dynamic> data) {
    mediaUrl = '';
    notifyListeners();
    return _ref.add(data);
  }

  uploadMedia(ImageSource source) async {
    var pickedFile = await ImagePicker().getImage(source: source);
    if (pickedFile == null) {
      return;
    }
    mediaUrl = await _storageService.uploadImage(File(pickedFile.path));
    notifyListeners();
  }
}
