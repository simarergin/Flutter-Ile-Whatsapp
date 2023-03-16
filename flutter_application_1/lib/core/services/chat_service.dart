import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/models/conversation.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/profile.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Conversation>> getConversations(String userId) {
    var ref = _firestore
        .collection('conversations')
        .where('members', arrayContains: userId);

    var conversationsStream = ref.snapshots();

    var profilesStreams = getContacts().asStream();

    return Rx.combineLatest2(
      conversationsStream,
      profilesStreams,
      (QuerySnapshot conversation, List<Profile> profiles) =>
          conversation.docs.map(
        (snapshot) {
          List<String> members = List.from(snapshot['members']);
          var profile = profiles.firstWhere((element) =>
              element.id == members.firstWhere((member) => member != userId));

          return Conversation.fromSnapshot(snapshot, profile);
        },
      ).toList(),
    );
  }
  //Servisten bütün kişileri çekip ekrana yazdırma.

  Future<List<Profile>> getContacts() async {
    var ref = _firestore.collection("profile");

    var documents = await ref.get();

    return documents.docs
        .map((snapshot) => Profile.fromSnapshot(snapshot))
        .toList();
  }

  //İki kişi arasında sohbet başlatma.
  Future<Conversation> startConversation(User? user, Profile profile) async {
    var ref = _firestore.collection('conversations');
    var documentRef = await ref.add({
      'displayMessage': "",
      'members': [user?.uid, profile.id]
    });
    //Kaydettiğimiz sohbeti döndürüyoruz.
    return Conversation(
      id: documentRef.id,
      displayMessage: '',
      userName: profile.userName,
      profileImage: profile.image,
    );
  }
}
