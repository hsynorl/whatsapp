import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firestorage = FirebaseStorage.instance;
 Future<String> uploadImage(File file) async{
    var uploadTask = _firestorage.ref().child("${DateTime.now().millisecondsSinceEpoch}.${file.path.split('.').last}")
          .putFile(file);
     // uploadTask.onError((error, stackTrace) => null).listen((event){} );  
     uploadTask.snapshotEvents.listen((event) { });

     var storageRef=await uploadTask.whenComplete(() => null);
    return await storageRef.ref.getDownloadURL();
  }
}

