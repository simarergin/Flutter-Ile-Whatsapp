import 'package:flutter_application_1/screens/contacts_page.dart';
import 'package:flutter_application_1/viewmodels/base_model.dart';

class MainModel extends BaseModel {
  // Future<void> navigateToContacts() async {
  openContacts() async {
    await navigatorService.navigateTo(ContactsPage());
    //   //gerekli sayfalar arası geçiş
    //   return navigatorService.navigateTo(ContactsPage());
  }
}
