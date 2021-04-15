import 'package:flutter/material.dart';
import 'package:whatsapp_klon/screens/calls_page.dart';
import 'package:whatsapp_klon/screens/camera_page.dart';
import 'package:whatsapp_klon/screens/chats_page.dart';
import 'package:whatsapp_klon/screens/status_page.dart';

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
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return SliverAppBar(
            floating: true,
            snap: true,
            
            title: Text('Whatsapp Clone'),
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                    icon: Icon(
                  Icons.camera,
                )),
                Tab(
                  text: "Chats",
                ),
                Tab(
                  text: "Status",
                ),
                Tab(
                  text: "Calls",
                ),
              ],
            ),
          );
        },
      ),
      /*TabBarView(
        controller: _tabController,
        children: [CameraPage(), ChatsPage(), StatusPage(), CallsPage()],
      ),*/
      floatingActionButton: _showMessage
          ? FloatingActionButton(
              child: Icon(Icons.message),
              onPressed: () {},
            )
          : null,
    );
  }
}
