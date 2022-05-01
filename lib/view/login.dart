import 'package:fire_drive/view/signup.dart';
import 'package:fire_drive/view/store/auth_store.dart';
import 'package:fire_drive/widgets/lottie/lottie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sizer/sizer.dart';

import '../locator.dart';
import 'home.dart';

class Login extends StatefulWidget {
  static String route = "login";

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final _authStore = locator.get<AuthStore>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  padding: EdgeInsets.all(5.w),
                  child: Observer(builder: (_) {
                    switch (_authStore.state) {
                      case AuthStoreState.init:
                        return buildLoginForm(context);
                      case AuthStoreState.loading:
                        return const Center(child: LottieWidget());
                      case AuthStoreState.loaded:
                        return buildLoginForm(context);
                    }
                  }),
                )
              ],
            )),
      ),
    );
  }

  buildLoginForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 1.h),
        const Text(
          "Fire Drive",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Arial'),
        ),
        const Divider(),
        SizedBox(height: 1.h),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
              hintText: 'your-email@something.com', label: Text('Email')),
          controller: _emailController,
        ),
        SizedBox(height: 1.h),
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          decoration: const InputDecoration(
              hintText: 'your-password', label: Text('Password')),
          controller: _passwordController,
        ),
        SizedBox(height: 2.h),
        ElevatedButton(
          child: const Text(
            "LOG IN",
          ),
          onPressed: () async {
            try {
              bool resp = await _authStore.login(
                  _emailController.text, _passwordController.text);
              if (resp) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => const Home(),
                    ),
                    (route) => false);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login failed!')));
              }
            } catch (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Login failed!')));
            }
          },
        ),
        ElevatedButton(
          child: const Text(
            "REGISTER",
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const Signup(),
              ),
            );
          },
        ), //E
        SizedBox(height: 2.h), // xternalSignInButtons()
      ],
    );
  }
}
