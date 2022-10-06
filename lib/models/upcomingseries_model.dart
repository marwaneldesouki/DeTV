import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/services/Upcomingseries_services.dart';
import 'package:shared_preferences/shared_preferences.dart';



class UpcomingSeries {
  num? series_id;
  String? series_name;
  num? series_vote;
  String? series_poster;
  bool? liked_;
  UpcomingSeries();
  // ignore: non_constant_identifier_names

  UpcomingSeries.fromJson(Map<String, dynamic> data) {
    series_id = data['id'];
    series_name = data['original_name'];
    series_vote = data['vote_average'];
    series_poster =
        "https://www.themoviedb.org/t/p/w220_and_h330_face/${data['poster_path']}";

    UpcomingSeries_Services().getLiked_Series().then((value) async {
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
