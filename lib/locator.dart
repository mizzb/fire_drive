import 'package:fire_drive/repository/auth_repo.dart';
import 'package:fire_drive/repository/storage_repo.dart';
import 'package:fire_drive/view/store/auth_store.dart';
import 'package:fire_drive/view/store/file_store.dart';
import 'package:fire_drive/view_controller/user_controller.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupServices() {
  locator.registerSingleton<AuthRepo>(AuthRepo());
  locator.registerSingleton<StorageRepo>(StorageRepo());
  locator.registerSingleton<UserController>(UserController());
  locator.registerSingleton<AuthStore>(AuthStore());
  locator.registerSingleton<FileStore>(FileStore());
}