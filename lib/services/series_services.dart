import 'dart:convert';
import 'package:flutter_application_1/models/series_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

List<String>? savedLikedSeries;
SharedPreferences? sharedPreferences;

class Series_Services {
  Future<List<String>> getLiked_Series() async {
    sharedPreferences = await SharedPreferences.getInstance();
    savedLikedSeries = sharedPreferences!.getStringList('Liked_Series') ?? [];
    return savedLikedSeries!;
  }

  void setAddLiked_Series(String Series_id) {
    savedLikedSeries?.add(Series_id);
    sharedPreferences!.setStringList('Liked_Series', savedLikedSeries!);
  }

  void setRemoveLiked_Series(String Series_id) {
    savedLikedSeries!.remove(Series_id);
    sharedPreferences!.setStringList('Liked_Series', savedLikedSeries!);
  }

  static Future<List<Series>?> getPopular_Series() async {
    List<Series>? seriesList;
    try {
      var response = await http
          .get(Uri.parse(
              'https://api.themoviedb.org/3/tv/popular?api_key=79c8617496205fe981f479323db06d15&language=en-US&page=1'))
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        var mapList = jsonDecode(response.body)["results"] as List;
        seriesList = mapList.map((e) => Series.fromJson(e)).toList();
        return seriesList;
      } else {
        return [];
      }
    } catch (e) {
      print("error in getPopularSeries{$e}");
      return [];
    }
  }

  static Future<List<Series>?> getSeries_Id(String id) async {
    List<Series>? seriesList;
    try {
      var response = await http
          .get(Uri.parse(
              'https://api.themoviedb.org/3/tv/${id}?api_key=79c8617496205fe981f479323db06d15&language=en-US'))
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        var mapList = [jsonDecode(response.body)];
        seriesList = mapList.map((e) => Series.fromJson(e)).toList();
        return seriesList;
      } else {
        return [];
      }
    } catch (e) {
      print("error in getseries_Id{$e}");
      return [];
    }
  }
}
