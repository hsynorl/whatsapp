import 'package:flutter/material.dart';
import 'package:whatsapp_klon/core/services/locator.dart';
import 'package:whatsapp_klon/screens/calls_page.dart';
import 'package:whatsapp_klon/screens/camera_page.dart';
import 'package:whatsapp_klon/screens/chats_page.dart';
import 'package:whatsapp_klon/screens/status_page.dart';
import 'package:whatsapp_klon/viewmodel/main_model.dart';

class WhatsappMain extends StatefulWidget {
  @override
  _WhatsappMainState createState() => _WhatsappMainState();
}

class _WhatsappMainState extends State<WhatsappMain>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool _showMessage = false;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    _tabController.addListener(() {
      _showMessage = _tabController.index != 0;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var model = getIt<MainModel>();
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  floating: true,
                  title: Text("Whatsapp Clone"),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ],
                )
              ];
            },
            body: Column(
              children: <Widget>[
                Container(
                  color: Theme.of(context).primaryColor,
                  child: TabBar(
                    controller: _tabController,
                    tabs: <Widget>[
                      Tab(
                        icon: Icon(Icons.camera),
                      ),
                      Tab(
                        text: "Chats",
                      ),
                      Tab(text: "Status"),
                      Tab(text: "Calls"),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        CameraPage(),
                        ChatsPage(),
                        StatusPage(),
                        CallsPage(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _showMessage
          ? FloatingActionButton(
              child: Icon(
                Icons.message,
                color: Colors.white,
              ),
              onPressed: () async {
                await model.navigateToContacts();
              })
          : null,
    );
  }
}
