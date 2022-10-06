import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/services/movies_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Movies {
  num? movie_id;
  String? movie_name;
  num? movie_vote;
  String? movie_poster;
  bool? liked_;
  List movie_genres=[];
  String? movie_overview;
  Movies();
  // ignore: non_constant_identifier_names

  Movies.fromJson(Map<String, dynamic> data) {
    try{
    movie_id = data['id'];
    movie_name = data['original_title'];
    movie_vote = data['vote_average'];
    movie_overview = data['overview'];
    movie_poster =
        "https://www.themoviedb.org/t/p/w220_and_h330_face/${data['poster_path']}";
        
    var x =  [
      for (var e in data["genres"]) movie_genres.add(e["name"])
    ];
    }catch (e){}
    Movies_Services().getLiked_Movies().then((value) async {
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
