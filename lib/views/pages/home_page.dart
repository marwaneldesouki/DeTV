import 'dart:convert';
import 'dart:developer';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/controllers/controllers.dart';
import 'package:flutter_application_1/services/user_services.dart';
import 'package:flutter_application_1/services/movies_services.dart';
import 'package:flutter_application_1/views/pages/moviedetails_page.dart';
import 'package:flutter_application_1/views/pages/seriesdetails_page.dart';
import 'package:flutter_application_1/widgets/movieCard_widget.dart';
import 'package:flutter_application_1/widgets/seriesCard_widget.dart';

import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../widgets/MySearchDelegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  createState() => _HomePageState();
}

Movies_Services movies_services = Movies_Services();

class _HomePageState extends State<HomePage> {
  late Controller _moviesController;
  late Controller _seriesController;

  Widgets my_widgets = Widgets();
  MySearchDelegate mySearchDelegate = MySearchDelegate();
  @override
  void initState() {
    _moviesController = Controller(this);
    _moviesController.getMoviesHandler();
    _seriesController = Controller(this);
    _seriesController.getSeriesHandler();

    super.initState();
  }

  @override
  void dispose() {
    _moviesController.dispose();
    _seriesController.dispose();
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
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  showSearch(context: context, delegate: mySearchDelegate);
                },
                color: Colors.amber,
              ),
            ]),
        bottomNavigationBar: BottomNavigationBar(
          items: my_widgets.my_appnavigator_items(),
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.orange,
          currentIndex: my_widgets.index_,
          onTap: (index) {
            setState(() {
              my_widgets.index_ = index;
              Navigator.popAndPushNamed(context, index.toString());
            });
          },
        ),
        drawer: my_widgets.app_drawer(context),
        // ignore: unnecessary_null_comparison
        body: (_moviesController.moviesList == null &&
                _seriesController.seriesList == null)
            ? const Center(
                child: SpinKitFadingCircle(
                  size: 100,
                  color: Colors.amber,
                ),
              )
            : _moviesController.moviesList?.isEmpty ?? false
                ? const Center(
                    child: Text('No Data'),
                  )
                : Container(
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Movies:",
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 330,
                          child: ListView.builder(
                              itemCount:
                                  _moviesController.moviesList?.length ?? 0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 250,
                                  margin: EdgeInsets.all(10),
                                  child: MovieCard(
                                    movieCard:
                                        _moviesController.moviesList![index],
                                    onMovieClicked: () { 
                                      Navigator.push(
            context, MaterialPageRoute(builder: (_) =>movieDetailsPage(id: _moviesController
                                          .moviesList![index].movie_id.toString())));
                                     
                                    },
                                  ),
                                );
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Series:",
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 330,
                          child: ListView.builder(
                              itemCount:
                                  _seriesController.seriesList?.length ?? 0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 250,
                                  margin: EdgeInsets.all(10),
                                  child: SeriesCard(
                                    seriesCard:
                                        _seriesController.seriesList![index],
                                    onSeriesClicked: () {
                                      Navigator.push(
            context, MaterialPageRoute(builder: (_) =>seriesDetailsPage(id: _seriesController
                                          .seriesList![index].series_id.toString())));
                                    },
                                  ),
                                );
                              }),
                        )
                      ],
                    )),
                  ));
  }
}
