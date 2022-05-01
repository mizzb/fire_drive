// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FileStore on FileStoreBase, Store {
  Computed<StoreState>? _$stateComputed;

  @override
  StoreState get state => (_$stateComputed ??=
          Computed<StoreState>(() => super.state, name: 'FileStoreBase.state'))
      .value;

  late final _$fileResponseAtom =
      Atom(name: 'FileStoreBase.fileResponse', context: context);

  @override
  String? get fileResponse {
    _$fileResponseAtom.reportRead();
    return super.fileResponse;
  }

  @override
  set fileResponse(String? value) {
    _$fileResponseAtom.reportWrite(value, super.fileResponse, () {
      super.fileResponse = value;
    });
  }

  late final _$fileReferenceAtom =
      Atom(name: 'FileStoreBase.fileReference', context: context);

  @override
  Reference? get fileReference {
    _$fileReferenceAtom.reportRead();
    return super.fileReference;
  }

  @override
  set fileReference(Reference? value) {
    _$fileReferenceAtom.reportWrite(value, super.fileReference, () {
      super.fileReference = value;
    });
  }

  late final _$filesAtom = Atom(name: 'FileStoreBase.files', context: context);

  @override
  ListResult? get files {
    _$filesAtom.reportRead();
    return super.files;
  }

  @override
  set files(ListResult? value) {
    _$filesAtom.reportWrite(value, super.files, () {
      super.files = value;
    });
  }

  late final _$_fileFutureAtom =
      Atom(name: 'FileStoreBase._fileFuture', context: context);

  @override
  ObservableFuture<String>? get _fileFuture {
    _$_fileFutureAtom.reportRead();
    return super._fileFuture;
  }

  @override
  set _fileFuture(ObservableFuture<String>? value) {
    _$_fileFutureAtom.reportWrite(value, super._fileFuture, () {
      super._fileFuture = value;
    });
  }

  late final _$_fileRefFutureAtom =
      Atom(name: 'FileStoreBase._fileRefFuture', context: context);

  @override
  ObservableFuture<Reference>? get _fileRefFuture {
    _$_fileRefFutureAtom.reportRead();
    return super._fileRefFuture;
  }

  @override
  set _fileRefFuture(ObservableFuture<Reference>? value) {
    _$_fileRefFutureAtom.reportWrite(value, super._fileRefFuture, () {
      super._fileRefFuture = value;
    });
  }

  late final _$_filesFutureAtom =
      Atom(name: 'FileStoreBase._filesFuture', context: context);

  @override
  ObservableFuture<ListResult>? get _filesFuture {
    _$_filesFutureAtom.reportRead();
    return super._filesFuture;
  }

  @override
  set _filesFuture(ObservableFuture<ListResult>? value) {
    _$_filesFutureAtom.reportWrite(value, super._filesFuture, () {
      super._filesFuture = value;
    });
  }

  late final _$uploadFileAsyncAction =
      AsyncAction('FileStoreBase.uploadFile', context: context);

  @override
  Future<String?> uploadFile(File file, Reference path) {
    return _$uploadFileAsyncAction.run(() => super.uploadFile(file, path));
  }

  late final _$createPathAsyncAction =
      AsyncAction('FileStoreBase.createPath', context: context);

  @override
  Future<Reference?> createPath() {
    return _$createPathAsyncAction.run(() => super.createPath());
  }

  late final _$createFolderAsyncAction =
      AsyncAction('FileStoreBase.createFolder', context: context);

  @override
  Future<Reference?> createFolder(Reference path, String folderName) {
    return _$createFolderAsyncAction
        .run(() => super.createFolder(path, folderName));
  }

  late final _$getFilesAsyncAction =
      AsyncAction('FileStoreBase.getFiles', context: context);

  @override
  Future<ListResult?> getFiles(Reference path) {
    return _$getFilesAsyncAction.run(() => super.getFiles(path));
  }

  late final _$deleteFileAsyncAction =
      AsyncAction('FileStoreBase.deleteFile', context: context);

  @override
  Future<void> deleteFile(Reference path) {
    return _$deleteFileAsyncAction.run(() => super.deleteFile(path));
  }

  late final _$deleteFolderAsyncAction =
      AsyncAction('FileStoreBase.deleteFolder', context: context);

  @override
  Future<void> deleteFolder(Reference path) {
    return _$deleteFolderAsyncAction.run(() => super.deleteFolder(path));
  }

  @override
  String toString() {
    return '''
fileResponse: ${fileResponse},
fileReference: ${fileReference},
files: ${files},
state: ${state}
    ''';
  }
}
