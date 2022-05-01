import 'package:fire_drive/view/store/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../locator.dart';
import 'home.dart';

class Signup extends StatefulWidget {
  static String route = "sign-up";

  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() {
    return _SignupState();
  }
}

class _SignupState extends State<Signup> {
  final _authStore = locator.get<AuthStore>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 1.h),
                    const Text(
                      "Fire Drive",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arial'),
                    ),
                    const Divider(),
                    SizedBox(height: 1.h),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: 'your-email@something.com',
                          label: Text('Email')),
                      controller: _emailController,
                    ),
                    SizedBox(height: 1.h),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                          hintText: 'your-password', label: Text('Password')),
                      controller: _passwordController,
                    ),
                    SizedBox(height: 1.h),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                          hintText: 'confirm-password',
                          label: Text('Confirm Password')),
                      controller: _confirmPassword,
                    ),
                    SizedBox(height: 2.h),
                    ElevatedButton(
                      child: const Text(
                        "REGISTER",
                      ),
                      onPressed: () async {
                        if (_passwordController.text.isNotEmpty &&
                            _emailController.text.isNotEmpty &&
                            _confirmPassword.text.isNotEmpty) {
                          if (_passwordController.text ==
                              _confirmPassword.text) {
                            try {
                              bool resp = await _authStore.signup(
                                  _emailController.text,
                                  _passwordController.text);

                              if (resp) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          const Home(),
                                    ),
                                    (route) => false);
                              } else {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Register failed!')));
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Register failed!')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Password doesn\'t match')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please enter all details')));
                        }
                      },
                    ),
                    SizedBox(height: 2.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(' BACK '),
                    ),
                    SizedBox(height: 2.h),
                    //ExternalSignInButtons()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
