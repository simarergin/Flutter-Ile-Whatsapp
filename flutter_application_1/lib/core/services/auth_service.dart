import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_application_1/core/services/auth_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///Future<FirebaseUser> get currentUser => _auth.currentUser();

  User? get currentUser {
    //  print(_auth.currentUser());
    return _auth.currentUser();
  }

  // User? get currentUser => _auth.currentUser;

  Future<User?> signInAnonymously() async {
    try {
      var user = await _auth.signInAnonymously();
      //  print(user.user);

      return user.user;
    } catch (e) {
      return null;
    }
  }

  Future<void> setUserProfile(User user, String userName, String token) async {
    await _firestore.collection('profile').doc(user.uid).set({
      'image':
          'http://docs.kariyer.net/job/jobtemplate/000/000/026/avatar/2618720210105090140285.jpeg',
      'userName': userName,
      'token': token
    });
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  signIn() {}
}

  // Future<User> get currentUser {
  //   if (_auth.currentUser != null) {
  //     return Future<User>.value(_auth.currentUser);
  //   } else {
  //     return Future<User>.value();
  //   }
  // }

//   Future<User?> signIn() async {
//     var user = await _auth.signInAnonymously();
//     return user.user;
//   }

//   signInAnonymously() {}
// }

