import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/Upcomingmovies_services.dart';
import '../views/pages/upcomingmovies_page.dart';

class Upcomingmovies {
  num? movie_id;
  String? movie_name;
  num? movie_vote;
  String? movie_poster;
  bool? liked_;
  Upcomingmovies();
  // ignore: non_constant_identifier_names

  Upcomingmovies.fromJson(Map<String, dynamic> data) {
    movie_id = data['id'];
    movie_name = data['original_title'];
    movie_vote = data['vote_average'];
    movie_poster =
        "https://www.themoviedb.org/t/p/w220_and_h330_face/${data['poster_path']}";

    UpcomingMovies_Services().getLiked_Movies().then((value) async {
      for (int i = 0; i < value.length; i++) {
        if (value[i].toString() == movie_id.toString()) {
          liked_ = true;
          break;
        } else {
          liked_ = false;
        }
      }
    });
  }
}
