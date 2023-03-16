import 'package:flutter_application_1/core/services/auth_service.dart';
import 'package:flutter_application_1/core/services/chat_service.dart';
import 'package:flutter_application_1/core/services/navigator_service.dart';
import 'package:flutter_application_1/core/services/storage_service.dart';
import 'package:flutter_application_1/viewmodels/chats_model.dart';
import 'package:flutter_application_1/viewmodels/contacts_model.dart';
import 'package:flutter_application_1/viewmodels/conversation_model.dart';
import 'package:flutter_application_1/viewmodels/main_model.dart';
import 'package:flutter_application_1/viewmodels/sign_in_model.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

setupLocators() {
  getIt.registerFactory(() => NavigatorService());
  getIt.registerLazySingleton(() => ChatService());
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerFactory(() => StorageService());

  getIt.registerFactory(() => ChatsModel());
  getIt.registerFactory(() => SignInModel());
  getIt.registerFactory(() => MainModel());
  getIt.registerFactory(() => ContactsModel());
  getIt.registerFactory(() => ConversationModel());
}
