import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_klon/core/services/locator.dart';
import 'package:whatsapp_klon/models/conversation.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_klon/viewmodel/conversation_model.dart';

class ConversationPage extends StatefulWidget {
  final String userId;
  final Conversation conversation;

  const ConversationPage({this.userId, this.conversation});

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  CollectionReference _ref;
  TextEditingController gonderilecekMesaj;
  FocusNode _focusNode;
  ScrollController _scrollController;
  var model = getIt<ConversationModel>();
  @override
  void initState() {
    _focusNode = FocusNode();
    _scrollController = ScrollController();
    _ref = FirebaseFirestore.instance
        .collection('conversation/${widget.conversation.id}/messages');
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: -2,
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.conversation.profileImage),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(widget.conversation.name),
              )
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(child: Icon(Icons.phone), onTap: () {}),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(child: Icon(Icons.more_vert), onTap: () {}),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(child: Icon(Icons.camera_alt), onTap: () {}),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.amber),
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _focusNode.unfocus();
                  },
                  child: StreamBuilder(
                      stream: model.getConversation(widget.conversation.id),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        return !snapshot.hasData
                            ? CircularProgressIndicator()
                            : ListView(
                                controller: _scrollController,
                                children: snapshot.data.docs
                                    .map((document) => ListTile(
                                        title: document['media'] == null ||
                                                document['media'].isEmpty
                                            ? Container()
                                            : Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: SizedBox(
                                                    height: 150,
                                                    child: Image.network(
                                                        document['media'])),
                                              ),
                                        subtitle: Align(
                                          alignment: widget.userId !=
                                                  document["senderid"]
                                              ? Alignment.bottomLeft
                                              : Alignment.bottomRight,
                                          child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  borderRadius:
                                                      BorderRadius.horizontal(
                                                          left: Radius.circular(
                                                              10),
                                                          right:
                                                              Radius.circular(
                                                                  10))),
                                              child: Text(
                                                document['message'],
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        )))
                                    .toList());
                      }),
                ),
              ),
              Consumer<ConversationModel>(
                builder: (BuildContext context, ConversationModel value,
                        Widget child) =>
                    model.mediaUrl.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: SizedBox(
                                height: 100,
                                child: Image.network(model.mediaUrl),
                              ),
                            ),
                          )
                        : Container(),
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(25),
                            right: Radius.circular(25))),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Icon(
                              Icons.tag_faces,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _focusNode,
                            controller: gonderilecekMesaj,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Mesaj giriniz"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Icon(
                              Icons.attach_file,
                              color: Colors.grey,
                            ),
                            onTap: () async {
                              await model.uploadMedia(ImageSource.gallery);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey,
                            ),
                            onTap: () async {
                              await model.uploadMedia(ImageSource.camera);
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          await model.add({
                            'senderid': widget.userId,
                            'message': gonderilecekMesaj.text,
                            'timeStamp': DateTime.now(),
                            'media': model.mediaUrl
                          });
                          _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: Duration(microseconds: 200),
                              curve: Curves.easeIn);
                          gonderilecekMesaj.text = '';
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
