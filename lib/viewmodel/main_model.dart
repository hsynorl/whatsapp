import 'package:whatsapp_klon/core/services/navigator_service.dart';
import 'package:whatsapp_klon/screens/contacts_page.dart';
import 'package:whatsapp_klon/viewmodel/base_model.dart';

class MainModel extends BaseModel {
  Future<void> navigateToContacts() {
    return NavigatorService().navigateTo(ContactsPage());
  }
}


 