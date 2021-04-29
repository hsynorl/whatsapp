import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_klon/core/services/locator.dart';
import 'package:whatsapp_klon/core/services/navigator_service.dart';
import 'package:whatsapp_klon/screens/sign_page.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_klon/viewmodel/sign_in_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_klon/whatsapp_main.dart';

void main() async {
  setupLocators();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        getIt<SignInModel>()/*.currentUser*/;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Whatsapp Clone',
        navigatorKey: getIt<NavigatorService>().navigatorKey,
        theme: ThemeData(
          primaryColor: Color(0xff075E54),
          accentColor: Color(0xff25D366),
        ),
        home: Consumer<User>(
          builder: (BuildContext context, User user, Widget child) =>
          user==null ? SignInPage() :WhatsappMain()
        ),
      ),
    );
  }
}
