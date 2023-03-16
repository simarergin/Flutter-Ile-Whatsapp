import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/ChatApp_main.dart';
import 'package:flutter_application_1/core/services/auth_service.dart';
import 'package:flutter_application_1/core/services/locator.dart';
import 'package:flutter_application_1/core/services/navigator_service.dart';
import 'package:flutter_application_1/viewmodels/base_model.dart';
import 'base_model.dart';

class SignInModel extends BaseModel {
  final AuthService _authService = getIt<AuthService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// final NavigatorService _navigatorService = getIt<NavigatorService>();
// Future<User> get currentUser => _authService.currentUser;
//  Future<FirebaseUser> get currentUser => _authService.currrentUser;

  Future<void> signIn(String userName) async {
    if (userName.isEmpty) return;
    busy = true;

    var user = await _authService.signInAnonymously();

    try {
      var user = await _authService.signIn();
      // await _firestore.collection('profile').document(user.uid).setData({
      await _firestore.collection('profile').doc(user?.uid).set({
        'userName': userName,
        'image':
            'http://docs.kariyer.net/job/jobtemplate/000/000/026/avatar/2618720210105090140285.jpeg'
      });

      await navigatorService.navigateTo(ChatAppMain());
    } catch (e) {
      busy = false;
    }
    busy = false;
  }
}
