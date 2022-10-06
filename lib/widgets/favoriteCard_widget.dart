// ignore_for_file: avoid_print

import 'dart:async';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/models/favorite_model.dart';
import 'package:flutter_application_1/services/favorite_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controllers/controllers.dart';

class FavoriteCard extends StatelessWidget {
  final Favorite favoriteCard;
  final void Function()? onfavoriteClicked;
  Favorite_Services favorite_services = Favorite_Services();

  FavoriteCard({required this.favoriteCard, required this.onfavoriteClicked, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 335,
      height: 250,
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
                  width: 340,
                  height: 240,
                  child: Ink.image(
                    image: NetworkImage(favoriteCard.favorite_poster!),
                    fit: BoxFit.fill,
                    child: InkWell(onTap: onfavoriteClicked),
                  ),
                ),
                Expanded(
                    child: ListTile(
                        title: Text(
                          favoriteCard.favorite_name ?? "No favorite name",
                          style: TextStyle(fontSize: 18),
                          maxLines: 1,
                        ),
                        subtitle: Text("Rating:${favoriteCard.favorite_vote}",
                            style: TextStyle(fontSize: 18), maxLines: 1),
                        trailing: FavoriteButton(
                            isFavorite: favoriteCard.liked_,
                            valueChanged: (_isFavorite) {
                              if (_isFavorite) {
                                favorite_services.setAdd(
                                    favoriteCard.favorite_id.toString());
                               return Fluttertoast.showToast(
        msg: "show added to your list",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
                              } else {
                                favorite_services.setRemove(
                                    favoriteCard.favorite_id.toString());
                                      return Fluttertoast.showToast(
        msg: "show removed from your list",
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
