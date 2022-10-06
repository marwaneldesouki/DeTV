import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/services/Series_services.dart';
import 'package:flutter_application_1/services/movies_services.dart';
import 'package:flutter_application_1/views/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorite {
  num? favorite_id;
  String? favorite_name;
  num? favorite_vote;
  String? favorite_poster;
  bool? liked_;

  // ignore: non_constant_identifier_names

  Favorite.fromJson(Map<String, dynamic> data) {
    favorite_id = data['id'];
    favorite_name = data['original_title'] == null
        ? data['original_name'] + "_Series"
        : data['original_title'];
    favorite_vote = data['vote_average'];
    favorite_poster =
        "https://www.themoviedb.org/t/p/w220_and_h330_face/${data['poster_path']}";

    if (favorite_name!.contains("_Series")) {
      Series_Services().getLiked_Series().then((value) async {
        for (int i = 0; i < value.length; i++) {
          if (value[i].toString() == favorite_id.toString()) {
            liked_ = true;
            break;
          } else {
            liked_ = false;
          }
        }
      });
    } else {
      Movies_Services().getLiked_Movies().then((value) async {
        for (int i = 0; i < value.length; i++) {
          if (value[i].toString() == favorite_id.toString()) {
            liked_ = true;
            break;
          } else {
            liked_ = false;
          }
        }
      });
    }
  }
}
