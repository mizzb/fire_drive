import 'package:fire_drive/view/home.dart';
import 'package:fire_drive/view/login.dart';
import 'package:fire_drive/widgets/lottie/lottie_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:sizer/sizer.dart';

import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
  );
  setupServices();
  runApp(const FireDriveApp());
}

class FireDriveApp extends StatefulWidget {
  const FireDriveApp({Key? key}) : super(key: key);

  @override
  _FireDriveAppState createState() {
    return _FireDriveAppState();
  }
}

class _FireDriveAppState extends State<FireDriveApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return const MaterialApp(title: 'Fire Drive', home: Initialize());
      }
    );
  }
}

class Initialize extends StatefulWidget {
  const Initialize({Key? key}) : super(key: key);

  @override
  _InitializeState createState() {
    return _InitializeState();
  }
}

class _InitializeState extends State<Initialize> {

  checkUserAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const Login(),
            ),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const Home(),
            ),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkUserAuth(),
        builder: (context, snapshot) {
          return const Scaffold(body: SafeArea(child: Center(child: LottieWidget())));
        });
  }
}
