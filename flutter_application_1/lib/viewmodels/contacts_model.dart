import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/services/chat_service.dart';
import 'package:flutter_application_1/core/services/locator.dart';
import 'package:flutter_application_1/models/conversation.dart';
import 'package:flutter_application_1/models/profile.dart';
import 'package:flutter_application_1/screens/contacts_page.dart';
import 'package:flutter_application_1/screens/conversation_page.dart';
import 'package:flutter_application_1/viewmodels/base_model.dart';
import '../core/services/chat_service.dart';

class ContactsModel extends BaseModel {
  final ChatService _chatService = getIt<ChatService>();

  late BuildContext context;

  //late BuildContext context;

  Future<List<Profile>> getContacts(String? query) async {
    var contacts = await _chatService.getContacts();

    var filteredContacts = contacts
        .where(
          (profile) => profile.userName.startsWith(query ?? ""),
          //
        )
        .toList();

    return filteredContacts;
  }

  Future<void> startConversation(User? user, Profile profile) async {
    var conversation = await _chatService.startConversation(user, profile);

    onPressed:
    () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationPage(
                    conversation: conversation.id,
                    userId: user?.uid,
                  )));
    };

    // void _navigateToNextScreen(context) {
    //   Navigator.of(context).push(MaterialPageRoute(
    //       builder: (context) => ConversationPage(
    //             conversation: conversation,
    //             userId: user?.uid,
    //           )));

    // //user'ı conversationpage sayfasına yönlendir.
    // navigatorService.navigateTo(ConversationPage(
    //   conversation: conversation,
    //   userId: user?.uid,
    // ));
  }
}

  // final ChatService _chatService = getIt<ChatService>();

  // static get query => null;

  //  Future<List<Profile>> getContacts(String query) async {}

  // var contacts = await_chatService.getContacts();

  // var filteredContacts = contacts.where(

  //  (profile) => profile.userName.startWith(query ?? ""),

  //);


