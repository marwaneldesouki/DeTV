import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/pages/home_page.dart';
import 'package:flutter_application_1/views/pages/introSlider_page.dart';
import 'package:flutter_application_1/views/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? finalEmail;
bool? introSlider_Flag;

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getValidationData().whenComplete(() async {
      Timer(const Duration(seconds: 2), () {
        if (introSlider_Flag == null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => SliderPage()));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      finalEmail == null ? LoginPage() : HomePage()));
        }
      });
    });
      super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    var obtained_SliderPage_Flag = sharedPreferences.getBool('intro_slider');
    setState(() {
      finalEmail = obtainedEmail;
      introSlider_Flag = obtained_SliderPage_Flag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Image(
              image: AssetImage(
                'assets/images/logo.png',
              ),
              height: 150,
              width: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
