import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String id;
  String userName;
  String image;

  Profile({required this.id, required this.userName, required this.image});

  factory Profile.fromSnapshot(DocumentSnapshot snapshot) {
    var splittedString = snapshot.data().toString().split(":");
    print(splittedString);
    return Profile(
      id: snapshot.id,
      userName: splittedString[3].replaceAll("}", ""),
      image: splittedString[1].split(",")[0].replaceAll(" ", "") +
          ":" +
          splittedString[2].split(",")[0],
    );
  }
}
