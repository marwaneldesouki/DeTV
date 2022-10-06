import 'dart:convert';
import 'dart:developer';
import 'package:flutter_application_1/models/favorite_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

List<String>? savedLikedMovies;
List<String>? savedLikedSeries;
SharedPreferences? sharedPreferences;

// ignore: camel_case_types
class Favorite_Services {
  static Future<List<Favorite>?> getLiked_Movies() async {
    sharedPreferences = await SharedPreferences.getInstance();
    savedLikedMovies = sharedPreferences!.getStringList('Liked_Movies') ?? [];

    return getMovie_Id(savedLikedMovies);
  }

  static Future<List<Favorite>?> getLiked_Series() async {
    sharedPreferences = await SharedPreferences.getInstance();
    savedLikedSeries = sharedPreferences!.getStringList('Liked_Series') ?? [];

    return getSeries_Id(savedLikedSeries);
  }

  static Future<List<Favorite>?> getSeries_Id(var series_ids) async {
    List<Favorite>? seriesList;
    List mapList = [];
    try {
      for (var element in series_ids) {
        var response = await http
            .get(Uri.parse(
                'https://api.themoviedb.org/3/tv/${element}?api_key=79c8617496205fe981f479323db06d15&language=en-US'))
            .timeout(Duration(seconds: 5));
        if (response.statusCode == 200) {
          var body_list = response.body;
          var mapList_decoded = jsonDecode(body_list.toString());
          mapList.add(mapList_decoded);
        } else {
          return [];
        }
      }
      seriesList = mapList.map((e) => Favorite.fromJson(e)).toList();
      return seriesList;
    } catch (e) {
      print("error in geteries_Id{$e}");
      return [];
    }
  }

  static Future<List<Favorite>?> getMovie_Id(var movie_ids) async {
    List<Favorite>? movieList;
    List mapList = [];
    try {
      for (var element in movie_ids) {
        var response = await http
            .get(Uri.parse(
                'https://api.themoviedb.org/3/movie/${element}?api_key=79c8617496205fe981f479323db06d15&language=en-US'))
            .timeout(Duration(seconds: 5));
        if (response.statusCode == 200) {
          var body_list = response.body;
          var mapList_decoded = jsonDecode(body_list.toString());
          mapList.add(mapList_decoded);
        } else {
          return [];
        }
      }
      movieList = mapList.map((e) => Favorite.fromJson(e)).toList();
      return movieList;
    } catch (e) {
      print("error in getMovie_Id{$e}");
      return [];
    }
  }

  void setAdd(String mose_Id) {
    for (var element in savedLikedMovies!) {
      if (element == mose_Id) {
        //in movie list
        setAddLiked_Movies(mose_Id);
        break;
      }
    }
    setAddLiked_Series(mose_Id);
  }

  void setRemove(String mose_Id) {
    for (var element in savedLikedMovies!) {
      if (element == mose_Id) {
        //in movie list
        setRemoveLiked_Movies(mose_Id);
        break;
      }
    }
    setRemoveLiked_Series(mose_Id);
  }

  void setAddLiked_Movies(String movie_id) {
    savedLikedMovies?.add(movie_id);
    sharedPreferences!.setStringList('Liked_Movies', savedLikedMovies!);
  }

  void setRemoveLiked_Movies(String movie_id) {
    savedLikedMovies!.remove(movie_id);
    sharedPreferences!.setStringList('Liked_Movies', savedLikedMovies!);
  }

  void setAddLiked_Series(String series_id) {
    savedLikedSeries?.add(series_id);
    sharedPreferences!.setStringList('Liked_Series', savedLikedSeries!);
  }

  void setRemoveLiked_Series(String series_id) {
    savedLikedSeries!.remove(series_id);
    sharedPreferences!.setStringList('Liked_Series', savedLikedSeries!);
  }
}
