// ignore_for_file: avoid_print

import 'dart:async';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/models/movie_model.dart';
import 'package:flutter_application_1/services/movies_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controllers/controllers.dart';

class MovieDetailed_Card extends StatelessWidget {
  final Movies movieCard;
  final void Function()? onMovieClicked;

  Movies_Services movies_services = Movies_Services();
  MovieDetailed_Card(
      {required this.movieCard, required this.onMovieClicked, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 270,
      child:Stack(
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: HexColor("#FF9800"),
            // ignore: sort_child_properties_last
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 400,
                  height: 240,
                  child: Ink.image(
                    image: NetworkImage(movieCard.movie_poster!),
                    fit: BoxFit.fill,
                    child: InkWell(onTap: onMovieClicked),
                  ),
                ),
                ListTile(
                  title: Text(
                    movieCard.movie_name ?? "No Movie name",
                    style: TextStyle(fontSize: 18),
                    maxLines: 1,
                  ),
                  subtitle: Text("Rating:${movieCard.movie_vote}",
                      style: TextStyle(fontSize: 18), maxLines: 1),
                  trailing: FavoriteButton(
                    isFavorite: movieCard.liked_,
                    valueChanged: (_isFavorite) {
                      if (_isFavorite) {
                        movies_services
                            .setAddLiked_Movies(movieCard.movie_id.toString());
                        return Fluttertoast.showToast(
                            msg: "Movie added to your list",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        movies_services.setRemoveLiked_Movies(
                            movieCard.movie_id.toString());
                        return Fluttertoast.showToast(
                            msg: "Movie removed from your list",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1.5,
                ),
                Text("description:\n${movieCard.movie_overview}",maxLines: 10,style: TextStyle(fontSize: 20,),),
                 Divider(
                  color: Colors.black,
                  thickness: 1.5,
                ),
                Text("genres:\n${movieCard.movie_genres.toString()}",style: TextStyle(fontSize: 35,)),

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
