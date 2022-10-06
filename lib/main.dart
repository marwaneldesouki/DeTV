import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/pages/favorites_page.dart';
import 'package:flutter_application_1/views/pages/home_page.dart';
import 'package:flutter_application_1/views/pages/introSlider_page.dart';
import 'package:flutter_application_1/views/pages/login_page.dart';
import 'package:flutter_application_1/views/pages/moviedetails_page.dart';
import 'package:flutter_application_1/views/pages/splash_page.dart';
import 'package:flutter_application_1/views/pages/upcomingmovies_page.dart';
import 'package:flutter_application_1/views/pages/upcomingseries_page.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intro_slider/intro_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeTV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
            platform: TargetPlatform.iOS,
            primaryColor: HexColor("#272DDB"),
            scaffoldBackgroundColor: HexColor("#24263F"),
          ),
    routes: {

      //  "/": (context) => movieDetailsPage(id: "766507"),
      "/": (context) => SplashPage(),
            "0" : (context) => HomePage(),
            "1" : (context) => upcomingmoviesPage(),
            "2" : (context) => upcomingseriesPage(),

            "3" : (context) => favoritesPage(),



    },
    );
  }
}
