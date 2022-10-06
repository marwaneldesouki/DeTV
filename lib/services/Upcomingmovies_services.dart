import 'dart:convert';
import 'dart:developer';
import 'package:flutter_application_1/models/movie_model.dart';
import 'package:flutter_application_1/models/upcomingmovie_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

List<String>? savedLikedMovies;
SharedPreferences? sharedPreferences;

class UpcomingMovies_Services {
  Future<List<String>> getLiked_Movies() async {
    sharedPreferences = await SharedPreferences.getInstance();
    savedLikedMovies = sharedPreferences!.getStringList('Liked_Movies') ?? [];
    return savedLikedMovies!;
  }

  void setAddLiked_Movies(String movie_id) {
    savedLikedMovies?.add(movie_id);
    sharedPreferences!.setStringList('Liked_Movies', savedLikedMovies!);
  }

  void setRemoveLiked_Movies(String movie_id) {
    savedLikedMovies!.remove(movie_id);
    sharedPreferences!.setStringList('Liked_Movies', savedLikedMovies!);
  }

  static Future<List<Upcomingmovies>?> getUpcoming_Movies() async {
    List<Upcomingmovies>? movieList;
    try {
      var response = await http
          .get(Uri.parse(
              'https://api.themoviedb.org/3/movie/upcoming?api_key=79c8617496205fe981f479323db06d15&language=en&page=1&region=US'))
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        var mapList = jsonDecode(response.body)["results"] as List;
        movieList = mapList.map((e) => Upcomingmovies.fromJson(e)).toList();
        return movieList;
      } else {
        return [];
      }
    } catch (e) {
      print("error in getUpcoming_Movies{$e}");
      return [];
    }
  }
   
 
}
