import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/views/pages/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/controllers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Controller _userController;

  @override
  void initState() {
    _userController = Controller(this);
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  final login_textbox = TextEditingController();
  bool loginfail = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png",height: 150,width:150,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Login',
                style: TextStyle(fontSize: 18),
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                            controller: login_textbox,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == '' ||
                                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(login_textbox.text)) {
                                loginfail = false;
                                return 'Please Enter your Email';
                              } else {
                                loginfail = false;
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Email',
                              errorText: loginfail ? 'email not match' : null,
                            )),
                      ),
                    ],
                  )),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          onClickAction(login_textbox.text);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Login'),
                        )),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void onClickAction(var email) async {
    if (formKey.currentState!.validate()) {
      _userController.getUsersHandler().whenComplete(() async {
        if (_userController.usersList!.contains(login_textbox.text)) {
          
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('email', email);
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> SplashPage()));

        } else {
          setState(() {
            loginfail = true; //loginfail is bool
            print("incorrect");
          });
        }
      });
    }
  }
}
