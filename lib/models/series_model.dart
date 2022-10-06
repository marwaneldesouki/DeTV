import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/services/Series_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Series {
  num? series_id;
  String? series_name;
  num? series_vote;
  String? series_poster;
  bool? liked_;
  List series_genres=[];
  String? series_overview;
  Series();
  // ignore: non_constant_identifier_names

  Series.fromJson(Map<String, dynamic> data) {
     try{
    series_id = data['id'];
    series_name = data['original_name'];
    series_vote = data['vote_average'];
    series_overview = data['overview'];

    series_poster =
        "https://www.themoviedb.org/t/p/w220_and_h330_face/${data['poster_path']}";
  var x =  [
      for (var e in data["genres"]) series_genres.add(e["name"])
    ];
     }catch (e){}
    Series_Services().getLiked_Series().then((value) async {
      for (int i = 0; i < value.length; i++) {
        if (value[i].toString() == series_id.toString()) {
          liked_ = true;
          break;
        } else {
          liked_ = false;
        }
      }
    });
  }
}
