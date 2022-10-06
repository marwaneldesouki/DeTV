import 'dart:convert';
import 'dart:developer';
import 'package:flutter_application_1/models/series_model.dart';
import 'package:flutter_application_1/models/upcomingseries_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

List<String>? savedLikedSeries;
SharedPreferences? sharedPreferences;

class UpcomingSeries_Services {
  Future<List<String>> getLiked_Series() async {
    sharedPreferences = await SharedPreferences.getInstance();
    savedLikedSeries = sharedPreferences!.getStringList('Liked_Series') ?? [];
    return savedLikedSeries!;
  }

  void setAddLiked_Series(String series_id) {
    savedLikedSeries?.add(series_id);
    sharedPreferences!.setStringList('Liked_Series', savedLikedSeries!);
  }

  void setRemoveLiked_Series(String series_id) {
    savedLikedSeries!.remove(series_id);
    sharedPreferences!.setStringList('Liked_Series', savedLikedSeries!);
  }

  static Future<List<UpcomingSeries>?> getUpcoming_Series() async {
    List<UpcomingSeries>? seriesList;
    try {
      var response = await http
          .get(Uri.parse(
              'https://api.themoviedb.org/3/tv/top_rated?api_key=79c8617496205fe981f479323db06d15&language=en-US&page=1'))
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        var mapList = jsonDecode(response.body)["results"] as List;
        seriesList = mapList.map((e) => UpcomingSeries.fromJson(e)).toList();
        return seriesList;
      } else {
        return [];
      }
    } catch (e) {
      print("error in getUpcoming_Series{$e}");
      return [];
    }
  }
}
