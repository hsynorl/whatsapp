import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_klon/core/services/locator.dart';
import 'package:whatsapp_klon/core/services/navigator_service.dart';
import 'package:whatsapp_klon/viewmodel/sign_in_model.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
  
    return ChangeNotifierProvider(
        create: (BuildContext context) => getIt<SignInModel>(),
        child: Consumer<SignInModel>(
          builder: (BuildContext context, SignInModel model, Widget child) {
            Scaffold(
              appBar: AppBar(
                title: Text("Sıgn In for Whatsapp Clone"),
              ),
              body: Container(
                padding: EdgeInsets.all(8),
                child: model.busy
                    ? CircularProgressIndicator()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("User Name"),
                          TextField(
                            controller: name,
                          ),
                          RaisedButton(
                              child: Text("Sign In"),
                              onPressed: () async {
                                await model.signIn(name.text);
                              
                              })
                        ],
                      ),
              ),
            );
          },
        ));
  }
}
