import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/pages/favorites_page.dart';
import 'package:flutter_application_1/views/pages/home_page.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Widgets extends StatefulWidget {
  @override
  Widgets createState() => Widgets();
}

class Widgets extends State<_Widgets> {
  Widget app_bar(BuildContext context) {
    return AppBar();
  }

  Widget app_drawer(BuildContext context) {
    return Drawer(
        backgroundColor: HexColor("#23243D"),
        child: SingleChildScrollView(
            child: Container(
                child: Column(children: [
          DrawerHeader(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 70,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/profile.png'),
                    ),
                  ),
                ),
              ])),
          ListTile(
            title: Text("Home"),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => HomePage()));
            },
          ),
          ListTile(
            title: Text("Favorite List"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => favoritesPage()));
            },
          ),
          ListTile(
            title: Text("Logout"),
            onTap: () async {
              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.remove("email");
              Navigator.popAndPushNamed(context, '/');
            },
          ),
        ]))));
  }

  int index_=0;
  List<BottomNavigationBarItem> my_appnavigator_items() {
    return [
      BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
          backgroundColor: HexColor("#1D1C3B")),
      BottomNavigationBarItem(
          icon: Icon(Icons.local_movies_outlined),
          label: "Movies",
                    backgroundColor: HexColor("#1D1C3B")),

      BottomNavigationBarItem(
          icon: Icon(Icons.live_tv_rounded),
          label: "Series",
                    backgroundColor: HexColor("#1D1C3B")),

    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
