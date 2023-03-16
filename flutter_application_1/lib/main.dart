import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ChatApp_main.dart';
import 'package:flutter_application_1/core/services/auth_service.dart';
import 'package:flutter_application_1/core/services/locator.dart';
import 'package:flutter_application_1/core/services/navigator_service.dart';
import 'package:flutter_application_1/screens/sign_in_page.dart';
import 'package:flutter_application_1/viewmodels/sign_in_model.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  setupLocators();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "firebase",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => getIt<SignInModel>(),
      child: Consumer<SignInModel>(
        builder: (BuildContext context, signIn, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ChatApp',
          navigatorKey: getIt<NavigatorService>().navigatorKey,
          theme: ThemeData(primaryColor: Colors.blue),
          home: signIn.currentUser == null ? SignInPage() : ChatAppMain(),
        ),
        //home: signIn.currentUser == null ? SignInPage() : ChatAppMain();
      ),
      //Consumer<User>(
      // builder: (BuildContext context, User user, child) =>
      //Eğer user sıgnın olmadıysa sıgnın page göster.
      //sıgnın olduysa chatapp page ana widget olarak belirle.
      //  user == null ? SignInPage() : ChatAppMain(),
    );
  }
}
     //.currentUser,
      // child: Consumer<SignInModel>(
      //   builder: (BuildContext context, signIn, child) =>
      //       MaterialApp(
      //     debugShowCheckedModeBanner: false,
      //     title: 'ChatApp',
      //     navigatorKey: getIt<NavigatorService>().navigatorKey,
      //     theme: ThemeData(primaryColor: Colors.blue),
      //   ),
      //   //home: signIn.currentUser == null ? SignInPage() : ChatAppMain();
      //   child: signIn == null ? SignInPage() : ChatAppMain(),
      // ),