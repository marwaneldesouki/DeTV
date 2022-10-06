import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/controllers/controllers.dart';
import 'package:flutter_application_1/views/pages/moviedetails_page.dart';
import 'package:flutter_application_1/views/pages/seriesdetails_page.dart';
import 'package:flutter_application_1/widgets/favoriteCard_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/movieCard_widget.dart';
import '../../widgets/widgets.dart';

Widgets my_widgets = Widgets();

class favoritesPage extends StatefulWidget {
  const favoritesPage({Key? key}) : super(key: key);

  @override
  State<favoritesPage> createState() => _favoritesPageState();
}

class _favoritesPageState extends State<favoritesPage> {
  late Controller _moviesController;
  late Controller _seriesController;
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    _moviesController = Controller(this);
    _moviesController.getFavoritesMoviesHandler();
    _seriesController = Controller(this);
    _seriesController.getFavoritesSeriesHandler();
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
        ),
        drawer: my_widgets.app_drawer(context),
        body: (_moviesController.favoritesMoviesList == null ||
                _seriesController.favoritesSeriesList == null)
            ? const Center(
                child: SpinKitFadingCircle(
                  size: 100,
                  color: Colors.amber,
                ),
              )
            : (_moviesController.favoritesMoviesList?.isEmpty ?? false) &&
                    (_seriesController.favoritesSeriesList?.isEmpty ?? false)
                ? const Center(
                    child: Text('No Data'),
                  )
                : ((_moviesController.favoritesMoviesList?.isNotEmpty) ??
                            false) &&
                        (_seriesController.favoritesSeriesList?.isNotEmpty ??
                            false)
                    ? Container(
                        child: SingleChildScrollView(
                            child: Column(children: [
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
                              itemCount: _moviesController
                                      .favoritesMoviesList?.length ??
                                  0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 250,
                                  margin: EdgeInsets.all(10),
                                  child: FavoriteCard(
                                    favoriteCard: _moviesController
                                        .favoritesMoviesList![index],
                                    onfavoriteClicked: () {
                                    Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => movieDetailsPage(
                                                      id: _moviesController
                                                          .favoritesMoviesList![
                                                              index]
                                                          .favorite_id
                                                          .toString())));
                                    },
                                  ),
                                );
                              }),
                        ),
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
                              "Series:",
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 330,
                          child: ListView.builder(
                              itemCount: _seriesController
                                      .favoritesSeriesList?.length ??
                                  0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 250,
                                  margin: EdgeInsets.all(10),
                                  child: FavoriteCard(
                                    favoriteCard: _seriesController
                                        .favoritesSeriesList![index],
                                    onfavoriteClicked: () {
                                      Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => seriesDetailsPage(
                                                      id: _seriesController
                                                          .favoritesSeriesList![
                                                              index]
                                                          .favorite_id
                                                          .toString())));
                                    },
                                  ),
                                );
                              }),
                        ),
                      ])))
                    : ((_moviesController.favoritesMoviesList?.isNotEmpty) ??
                            false)
                        ? Container(
                            child: SingleChildScrollView(
                                child: Column(children: [
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
                                  itemCount: _moviesController
                                          .favoritesMoviesList?.length ??
                                      0,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: 250,
                                      margin: EdgeInsets.all(10),
                                      child: FavoriteCard(
                                        favoriteCard: _moviesController
                                            .favoritesMoviesList![index],
                                        onfavoriteClicked: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => movieDetailsPage(
                                                      id: _moviesController
                                                          .favoritesMoviesList![
                                                              index]
                                                          .favorite_id
                                                          .toString())));
                                        },
                                      ),
                                    );
                                  }),
                            ),
                          ])))
                        : Container(
                            child: SingleChildScrollView(
                                child: Column(children: [
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
                                  "Series:",
                                  style: TextStyle(fontSize: 30),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 330,
                              child: ListView.builder(
                                  itemCount: _seriesController
                                          .favoritesSeriesList?.length ??
                                      0,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: 250,
                                      margin: EdgeInsets.all(10),
                                      child: FavoriteCard(
                                        favoriteCard: _seriesController
                                            .favoritesSeriesList![index],
                                        onfavoriteClicked: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => seriesDetailsPage(
                                                      id: _seriesController
                                                          .favoritesSeriesList![
                                                              index]
                                                          .favorite_id
                                                          .toString())));
                                        },
                                      ),
                                    );
                                  }),
                            )
                          ]))));
  }
}
