import 'dart:io';

import 'package:fire_drive/repository/storage_repo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobx/mobx.dart';

import '../../locator.dart';

part 'file_store.g.dart';

class FileStore = FileStoreBase with _$FileStore;

enum StoreState { init, loading, loaded }

abstract class FileStoreBase with Store {
  FileStoreBase();

  final StorageRepo _storageRepo = locator.get<StorageRepo>();

  @observable
  String? fileResponse;

  @observable
  Reference? fileReference;

  @observable
  ListResult? files;

  @observable
  ObservableFuture<String>? _fileFuture;

  @observable
  ObservableFuture<Reference>? _fileRefFuture;

  @observable
  ObservableFuture<ListResult>? _filesFuture;

  @computed
  StoreState get state {
    if (_fileFuture == null && _fileRefFuture == null && _filesFuture == null) {
      return StoreState.init;
    } else if ((_fileFuture != null &&
            _fileFuture!.status == FutureStatus.pending) ||
        (_fileRefFuture != null &&
            _fileRefFuture!.status == FutureStatus.pending) ||
        (_filesFuture != null &&
            _filesFuture!.status == FutureStatus.pending)) {
      return StoreState.loading;
    } else {
      return StoreState.loaded;
    }
  }

  @action
  Future<String?> uploadFile(File file, Reference path) async {
    _fileFuture = ObservableFuture(
        Future<String>(() async => await _storageRepo.uploadFile(file, path)));
    fileResponse = await _fileFuture!;
    return fileResponse;
  }

  @action
  Future<Reference?> createPath() async {
    _fileRefFuture = ObservableFuture(
        Future<Reference>(() async => await _storageRepo.createPath()));
    fileReference = await _fileRefFuture!;
    return fileReference;
  }

  @action
  Future<Reference?> createFolder(Reference path, String folderName) async {
    _fileRefFuture = ObservableFuture(Future<Reference>(
        () async => await _storageRepo.createFolder(path, folderName)));
    fileReference = await _fileRefFuture!;
    return fileReference;
  }

  @action
  Future<ListResult?> getFiles(Reference path) async {
    _filesFuture = ObservableFuture(
        Future<ListResult>(() async => await _storageRepo.getFiles(path)));
    files = await _filesFuture!;
    return files;
  }

  @action
  Future<void> deleteFile(Reference path) async {
    _storageRepo.deleteFile(path);
  }

  @action
  Future<void> deleteFolder(Reference path) async {
    _storageRepo.deleteFolder(path);
  }
}
