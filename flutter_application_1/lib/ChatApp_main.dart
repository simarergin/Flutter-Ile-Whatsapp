import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/services/locator.dart';
import 'package:flutter_application_1/screens/calls_page.dart';
import 'package:flutter_application_1/screens/camera_page.dart';
import 'package:flutter_application_1/screens/chats_page.dart';
import 'package:flutter_application_1/screens/contacts_page.dart';
import 'package:flutter_application_1/screens/status_page.dart';
import 'package:flutter_application_1/viewmodels/main_model.dart';

class ChatAppMain extends StatefulWidget {
  const ChatAppMain({Key? key}) : super(key: key);

  @override
  State<ChatAppMain> createState() => _ChatAppMainState();
}

class _ChatAppMainState extends State<ChatAppMain>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showMessage = true;

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
                  title: Text('ChatApp'),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {},
                    )
                  ],
                )
              ];
            },
            body: Column(
              children: <Widget>[
                TabBar(
                  controller: _tabController,
                  tabs: <Widget>[
                    Tab(icon: Icon(Icons.camera)),
                    Tab(text: 'Chats'),
                    Tab(text: 'Status'),
                    Tab(text: 'Calls'),
                  ],
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactsPage()),
                );
              }
              // () async => model.openContacts(),
              //onPressed: () async {
              // await model.navigateToContacts();
              )
          : null,
    );
  }
}
