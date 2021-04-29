import 'package:flutter/material.dart';
import 'package:whatsapp_klon/core/services/locator.dart';
import 'package:whatsapp_klon/models/profile.dart';
import 'package:whatsapp_klon/viewmodel/contacts_model.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: ContactSearchDelegate());
              }),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
        ],
      ),
      body: ContactList(),
    );
  }
}

class ContactList extends StatelessWidget {
  final String query;
  const ContactList({
    this.query,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = getIt<ContactsModel>();
  var user=Provider.of<User>(context);
    return FutureBuilder(
        future: model.getContantacts(query),
        builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  child: Icon(
                    Icons.group,
                    color: Colors.white,
                  ),
                ),
                title: Text("New Group"),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  child: Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ),
                ),
                title: Text("New Contact"),
              ),
              ...snapshot.data
                  .map(
                    (profile) => ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).accentColor,
                        backgroundImage: NetworkImage(profile.image),
                      ),
                      title: Text(profile.userName),
                      onTap: (){
                        model.startConversation(user, profile);
                      },
                    ),
                  )
                  .toList()
            ],
          );
        });
  }
}

class ContactSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(primaryColor: Color(0xff075E54));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return ContactList(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
