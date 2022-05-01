import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:fire_drive/view/store/file_store.dart';
import 'package:fire_drive/widgets/folder_card.dart';
import 'package:fire_drive/widgets/lottie/lottie_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../locator.dart';

class Folder extends StatefulWidget {
  const Folder({Key? key, required this.path, required this.level})
      : super(key: key);

  final Reference path;
  final String level;

  @override
  _FolderState createState() {
    return _FolderState();
  }
}

class _FolderState extends State<Folder> {
  ListResult? _files;
  final _fileStore = locator.get<FileStore>();
  final TextEditingController _folderName = TextEditingController();
  ReceivePort receivePort = ReceivePort();

  @override
  void initState() {
    IsolateNameServer.registerPortWithName(receivePort.sendPort, "downloading");
    receivePort.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      // print("Id: ${id}, Status: ${status}, Progress: ${progress},");
    });
    FlutterDownloader.registerCallback(downloadCallback);
    _fileStore.getFiles(widget.path);
    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping("downloading");
    super.dispose();
  }

  static downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort sendPort =
        IsolateNameServer.lookupPortByName("downloading")!;
    sendPort.send([id, status, progress]);
  }

  void _download(String url, String title) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final externalDir = (Platform.isAndroid)
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();
      final id = await FlutterDownloader.enqueue(
        url: url,
        savedDir: externalDir!.path,
        fileName: title,
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: true,
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Need file Permission to download')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Fire Drive"),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Observer(
              builder: (BuildContext context) {
                switch (_fileStore.state) {
                  case StoreState.init:
                    return const Center(
                      child: LottieWidget(
                        lottieType: 'fetching',
                      ),
                    );
                  case StoreState.loading:
                    return const Center(
                      child: LottieWidget(
                        lottieType: 'fetching',
                      ),
                    );
                  case StoreState.loaded:
                    _files = _fileStore.files;
                    return _buildFilesColumn(context);
                }
              },
            )),
      ),
    );
  }

  Column _buildFilesColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: folderHeader(context),
        ),
        const Divider(
          color: Colors.orange,
        ),
        if (_files != null && _files!.prefixes.isNotEmpty)
          Expanded(
            flex: 2,
            child: folderList(),
          ),
        if (_files != null && _files!.prefixes.isNotEmpty)
          const Divider(
            color: Colors.grey,
          ),
        if (_files != null && _files!.items.isNotEmpty)
          Expanded(
            flex: 10,
            child: itemsContainer(),
          ),
        if (_files != null && _files!.items.isNotEmpty)
          const Divider(
            color: Colors.orange,
          ),
        if (_files == null || (_files != null && _files!.items.isEmpty))
          const Expanded(
            flex: 10,
            child: SizedBox(),
          ),
      ],
    );
  }

  Container itemsContainer() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
      child: ListView.builder(
          itemCount: _files!.items.length,
          itemBuilder: (BuildContext context, int index) {
            if (_files!.items[index].name != '.ghost') {
              return Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) {
                        deleteFile(_files!.items[index]);
                      },
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Card(
                  child: ListTile(
                      leading: const Icon(Icons.file_present_rounded),
                      trailing: GestureDetector(
                        onTap: () async{
                          String url = await _files!.items[index].getDownloadURL();
                          _download(url, _files!.items[index].name);
                        },
                          child: const Icon(Icons.file_download)),
                      title: Text(
                        _files!.items[index].name,
                        style: const TextStyle(fontSize: 12),
                      )),
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
    );
  }

  ListView folderList() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _files!.prefixes.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => Folder(
                      path: _files!.prefixes[index],
                      level: widget.level + widget.path.name + ' / ',
                    ),
                  )).then((value) => _fileStore.getFiles(widget.path));
            },
            child: FolderCard(
              fileName: _files!.prefixes[index].name,
            ),
          );
        });
  }

  Row folderHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 60.w,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              'My Files ' + widget.level + widget.path.name,
              maxLines: 1,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.create_new_folder),
              onPressed: () async {
                await _showFolderPopup(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.upload_file),
              onPressed: () async {
                await _uploadFile();
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      String? resp = await _fileStore.uploadFile(file, widget.path);
      if (resp != null) {
        _fileStore.getFiles(widget.path);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('File upload failed')));
      }
    }
  }

  Future<void> _showFolderPopup(BuildContext ctxt) async {
    showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        builder: (_) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 2.w,
                  right: 2.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 5.h),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: 'Folder Name', label: Text('Folder name')),
                    controller: _folderName,
                  ),
                  SizedBox(height: 5.h),
                  ElevatedButton(
                    child: const Text('Create Folder'),
                    onPressed: () async {
                      if (_folderName.text.isNotEmpty) {
                        Reference? resp = await _fileStore.createFolder(
                            widget.path, _folderName.text);
                        if (resp != null) {
                          _fileStore.getFiles(widget.path);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Folder creation failed')));
                        }
                        _folderName.clear();
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Enter Folder name')));
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void deleteFile(Reference item) {
    _fileStore.deleteFile(item);
    _fileStore.getFiles(widget.path);
  }
}
