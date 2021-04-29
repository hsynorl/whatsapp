import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_klon/core/services/auth_service.dart';
import 'package:whatsapp_klon/core/services/locator.dart';
import 'package:whatsapp_klon/viewmodel/base_model.dart';
import 'package:whatsapp_klon/whatsapp_main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInModel extends BaseModel {
  final AuthService _authService = getIt<AuthService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth=FirebaseAuth.instance;
 User get currentUser => _auth.currentUser;
  Future<void> signIn(String userName) async {
    if (userName.isEmpty) {
      return;
    }
    busy = true;
    try {
      var user = await _authService.signIn();
      await _firestore.collection('profile').doc(user.uid).set({
        'userName': userName,
        'image':
            "https://i2.cnnturk.com/i/cnnturk/75/800x400/5bc059ec61361f1780382469.jpg"
      });
      await navigatorService.navigateAndReplace(WhatsappMain());
    } catch (e) {
      busy = false;
    }

    busy = false;
  }
}
