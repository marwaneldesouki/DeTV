// ignore_for_file: avoid_print

import 'dart:async';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/models/movie_model.dart';
import 'package:flutter_application_1/models/upcomingmovie_model.dart';
import 'package:flutter_application_1/services/Upcomingmovies_services.dart';
import 'package:flutter_application_1/services/movies_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controllers/controllers.dart';

class UpcomingMovieCard extends StatelessWidget {
  final Upcomingmovies movieCard;
  final void Function()? onMovieClicked;

  UpcomingMovies_Services movies_services =UpcomingMovies_Services();
  UpcomingMovieCard({required this.movieCard, required this.onMovieClicked, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: HexColor("#FF9800"),
            // ignore: sort_child_properties_last
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 280,
                  width: 600,
                  child: Ink.image(
                    image:NetworkImage(movieCard.movie_poster!),
                    fit: BoxFit.fill,
                    width: 600,
                    child: InkWell(onTap: onMovieClicked),
                  ),
                ),
                Expanded(
                    child: ListTile(
                        title: Text(
                          movieCard.movie_name ?? "No Movie name",
                          style: TextStyle(fontSize: 18),
                          maxLines: 1,
                        ),
                        subtitle: Text("Rating:${movieCard.movie_vote??"NR"}",
                            style: TextStyle(fontSize: 18), maxLines: 1),
                        trailing: FavoriteButton(
                            isFavorite: movieCard.liked_,
                            valueChanged: (_isFavorite) {
                              if (_isFavorite) {
                                movies_services.setAddLiked_Movies(
                                    movieCard.movie_id.toString());
                               return Fluttertoast.showToast(
        msg: "Movie added to your list",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
                              } else {
                                movies_services.setRemoveLiked_Movies(
                                    movieCard.movie_id.toString());
                                      return Fluttertoast.showToast(
        msg: "Movie removed from your list",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
                              }
                            }))),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
          ),
        ],
          
      ),
    );
    
  }
}
