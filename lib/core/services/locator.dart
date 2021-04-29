import 'package:get_it/get_it.dart';
import 'package:whatsapp_klon/core/services/auth_service.dart';
import 'package:whatsapp_klon/core/services/chats_service.dart';
import 'package:whatsapp_klon/core/services/navigator_service.dart';
import 'package:whatsapp_klon/core/services/storage_service.dart';
import 'package:whatsapp_klon/viewmodel/chats_model.dart';
import 'package:whatsapp_klon/viewmodel/contacts_model.dart';
import 'package:whatsapp_klon/viewmodel/conversation_model.dart';
import 'package:whatsapp_klon/viewmodel/main_model.dart';
import 'package:whatsapp_klon/viewmodel/sign_in_model.dart';

GetIt getIt = GetIt.instance;
setupLocators() {
  getIt.registerLazySingleton(() => ChatService());
  getIt.registerLazySingleton(() => NavigatorService());
  getIt.registerFactory(() => AuthService());
  getIt.registerFactory(() => ChatsModel());
  getIt.registerFactory(() => SignInModel());
  getIt.registerFactory(() => MainModel());
  getIt.registerFactory(() => ContactsModel());
  getIt.registerFactory(() => ConversationModel());
  getIt.registerFactory(() => StorageService());
}
