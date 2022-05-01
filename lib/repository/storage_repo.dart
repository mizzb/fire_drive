import 'dart:io';

import 'package:fire_drive/model/user_modal.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

import '../locator.dart';
import 'auth_repo.dart';

class StorageRepo {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final AuthRepo _authRepo = locator.get<AuthRepo>();

  Future<String> uploadFile(File file, Reference storageRef) async {
    String fileName = p.basename(file.path);
    var uploadTask = storageRef.child(fileName).putFile(file);
    var completedTask = await uploadTask;
    String downloadUrl = await completedTask.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<Reference> createPath() async {
    UserModel? user = await _authRepo.getUser();
    var userId = user!.uid;
    var storageRef = _storage.ref().child("user/$userId/files");
    return storageRef;
  }

  Future<Reference> createFolder(Reference path, String folder) async {
    var uploadTask = path.child('/' + folder + '/.ghost').putString('ghost');
    var completedTask = await uploadTask;
    return completedTask.ref;
  }

  Future<ListResult> getFiles(Reference filePath) async {
    ListResult result = await filePath.listAll();
    return result;
  }

  Future<void> deleteFile(Reference filePath) async {
    filePath.delete();
  }

  Future<void> deleteFolder(Reference filePath) async {
    _storage.ref(filePath.fullPath).listAll().then((value) => {
          if (value.items.isNotEmpty)
            {
              value.items.forEach((element) {
                deleteFile(element);
              })
            },
          if (value.prefixes.isNotEmpty)
            {
              value.prefixes.forEach((element) {
                deleteFolder(element);
              })
            }
        });
  }
}
