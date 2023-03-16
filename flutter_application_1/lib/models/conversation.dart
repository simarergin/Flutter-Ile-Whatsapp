import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/profile.dart';

class Conversation {
  String? id;
  String? userName;
  String? profileImage;
  String? displayMessage;

  Conversation(
      {this.id, this.userName, this.profileImage, this.displayMessage});

  factory Conversation.fromSnapshot(
      DocumentSnapshot snapshot, Profile profile) {
    return Conversation(
        id: snapshot.id,
        userName: profile.userName,
        profileImage: profile.image,
        displayMessage:
            (snapshot.data() as Map<String, dynamic>)['displayMessage'] ?? '');
  }
}

// class Conversation 
//  String id;
//  String userName;
//  String profileImage;
// String displayMessage;

//  Conversation(
//    this.id,
//    this.userName,
//    this.profileImage,
//    this.displayMessage,
//  );

//  factory Conversation.fromSnapshot(
//      DocumentSnapshot snapshot, Profile otherUser) {
//    return Conversation(
//      snapshot.id,
//      otherUser.userName,
//      otherUser.profileImage,
//      snapshot.data()['displayMessage'],
//    );
//  }
// }
