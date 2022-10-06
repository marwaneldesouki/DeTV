import 'package:flutter_application_1/models/favorite_model.dart';
import 'package:flutter_application_1/models/movie_model.dart';
import 'package:flutter_application_1/models/series_model.dart';
import 'package:flutter_application_1/models/upcomingmovie_model.dart';
import 'package:flutter_application_1/models/upcomingseries_model.dart';
import 'package:flutter_application_1/services/Upcomingmovies_services.dart';
import 'package:flutter_application_1/services/favorite_services.dart';
import 'package:flutter_application_1/services/movies_services.dart';
import 'package:flutter_application_1/services/series_services.dart';
import 'package:flutter_application_1/services/user_services.dart';
import 'package:flutter_application_1/views/pages/home_page.dart';
import 'package:flutter_application_1/views/pages/upcomingmovies_page.dart';
import 'package:states_controller/states_controller.dart';
import 'package:tuple/tuple.dart';

import '../services/Upcomingseries_services.dart';

class Controller extends StatesController {
  List<String>? usersList;
  List<Movies>? moviesList;
  List<Movies>? movieByIdList;
  List<Series>? seriesByIdList;
  List<Series>? seriesList;
  List<Favorite>? favoritesMoviesList;
  List<Favorite>? favoritesSeriesList;
  List<Upcomingmovies>? upcomingMoviesList;
  List<UpcomingSeries>? upcomingSeriesList;

  Controller(super.state);

  Future getUsersHandler() async {
    usersList = await Services.getusers();
    setState();
  }

  Future getMoviesHandler() async {
    moviesList = await Movies_Services.getPopular_Movies();
    setState();
  }

  Future getMovieByIdHandler(var id) async {
    movieByIdList = await Movies_Services.getMovie_Id(id);
    setState();
  }

  Future getUpcomingMoviesHandler() async {
    upcomingMoviesList = await UpcomingMovies_Services.getUpcoming_Movies();
    setState();
  }

  Future getUpcomingSeriesHandler() async {
    upcomingSeriesList = await UpcomingSeries_Services.getUpcoming_Series();
    setState();
  }

  Future getSeriesHandler() async {
    seriesList = await Series_Services.getPopular_Series();
    setState();
  }

  Future getSeriesByIdHandler(var id) async {
    seriesByIdList = await Series_Services.getSeries_Id(id);
    setState();
  }

  Future getFavoritesMoviesHandler() async {
    favoritesMoviesList = await Favorite_Services.getLiked_Movies();
    setState();
  }

  Future getFavoritesSeriesHandler() async {
    favoritesSeriesList = await Favorite_Services.getLiked_Series();
    setState();
  }
}
