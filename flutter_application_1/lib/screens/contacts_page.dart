import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/services/locator.dart';
import 'package:flutter_application_1/viewmodels/contacts_model.dart';
import 'package:flutter_application_1/viewmodels/sign_in_model.dart';
import 'package:provider/provider.dart';
import '../models/profile.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Select contact", style: TextStyle(fontSize: 16)),
          ],
        ),
        // title: Text("Contacts"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ContactSearchDelegate(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ContactsList(),
    );
  }
}

class ContactsList extends StatelessWidget {
  final String? query;
  const ContactsList({
    Key? key,
    this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = getIt<ContactsModel>();
    var user = Provider.of<SignInModel>(context).currentUser;

    return FutureBuilder(
      future: model.getContacts(query),
      builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );

        if (!snapshot.hasData) return CircularProgressIndicator();
        //  return Center(
        //   child: CircularProgressIndicator(),
        // );

        // if(!snapshot.data.length == 0)
        // return Center(
        //   child: Text("Not result found"),
        // );

        return ListView(
            children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.people,
                color: Colors.white,
              ),
            ),
            title: Text("New Group"),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person_add),
            ),
            title: Text("New contact"),
          ),
          //Yeni listedeki bütün elemanları ekle
        ]..addAll(snapshot.data!
                .map(
                  (profile) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(profile.image),
                    ),
                    title: Text(profile.userName),
                    onTap: () async => model.startConversation(user, profile),
                    //user ı almak için provider paketini kullanıyoruz.
                  ),
                  // onTap: () async => model.startConversation(profile ),
                )
                .toList()));
      },
    );
  }
}

class ContactSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return super.appBarTheme(context);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, 'Thanks'),
      //  onPressed: () {  close(context, null);
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ContactsList(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text(
        "Start searching to chat",
      ),
    );
  }
}
