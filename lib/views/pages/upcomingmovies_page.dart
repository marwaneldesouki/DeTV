import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/controllers/controllers.dart';
import 'package:flutter_application_1/views/pages/moviedetails_page.dart';
import 'package:flutter_application_1/widgets/upcomingmovieCard_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/movieCard_widget.dart';
import '../../widgets/widgets.dart';

Widgets my_widgets = Widgets();

class upcomingmoviesPage extends StatefulWidget {
  const upcomingmoviesPage({Key? key}) : super(key: key);

  @override
  State<upcomingmoviesPage> createState() => _upcomingmoviesPageState();
}

class _upcomingmoviesPageState extends State<upcomingmoviesPage> {
  late Controller _moviesController;
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    _moviesController = Controller(this);
    _moviesController.getUpcomingMoviesHandler();

    super.initState();
  }

  @override
  void dispose() {
    _moviesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Center(
              child: Image.asset(
            'assets/images/logo.png',
            height: 90,
            width: 90,
          )),
          backgroundColor: HexColor("#23243D"),
        ),
        drawer: my_widgets.app_drawer(context),
          bottomNavigationBar: BottomNavigationBar(
          items: my_widgets.my_appnavigator_items(),
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.orange,
          currentIndex: 1,
          onTap: (index) {
            setState(() {
              my_widgets.index_ = index;
              Navigator.popAndPushNamed(context, index.toString());
            });
          },
        ),
        body: (_moviesController.upcomingMoviesList == null)
            ? const Center(
                child: SpinKitFadingCircle(
                  size: 100,
                  color: Colors.amber,
                ),
              )
            : (_moviesController.upcomingMoviesList?.isEmpty ?? false)
                ? const Center(
                    child: Text('No Data'),
                  )
                : Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Upcoming Movies:",
                                style: TextStyle(fontSize: 30),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 580,
                            child: GridView.builder(
                                itemCount: _moviesController
                                        .upcomingMoviesList?.length ??
                                    0,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 10.5 / 20.0,
                                  crossAxisCount: 2,
                                ),
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    child: UpcomingMovieCard(
                                      movieCard: _moviesController
                                          .upcomingMoviesList![index],
                                      onMovieClicked: () {
                                       Navigator.push(
            context, MaterialPageRoute(builder: (_) =>movieDetailsPage(id:_moviesController
                                            .upcomingMoviesList![index]
                                            .movie_id.toString())));
                                      },
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 250,
                          ),
                        ],
                      ),
                    ),
                  ));
  }
}
