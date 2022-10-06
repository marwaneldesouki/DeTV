// ignore_for_file: avoid_print

import 'dart:async';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/models/series_model.dart';
import 'package:flutter_application_1/services/Series_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controllers/controllers.dart';

class SeriesCard extends StatelessWidget {
  final Series seriesCard;
  final void Function()? onSeriesClicked;
  Series_Services series_services = Series_Services();

  SeriesCard({required this.seriesCard, required this.onSeriesClicked, Key? key})
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
                    image: NetworkImage(seriesCard.series_poster!),
                    fit: BoxFit.fill,
                    child: InkWell(onTap: onSeriesClicked),
                  ),
                ),
                Expanded(
                    child: ListTile(
                        title: Text(
                          seriesCard.series_name ?? "No Series name",
                          style: TextStyle(fontSize: 18),
                          maxLines: 1,
                        ),
                        subtitle: Text("Rating:${seriesCard.series_vote}",
                            style: TextStyle(fontSize: 18), maxLines: 1),
                        trailing: FavoriteButton(
                            isFavorite: seriesCard.liked_,
                            valueChanged: (_isFavorite) {
                              if (_isFavorite) {
                                series_services.setAddLiked_Series(
                                    seriesCard.series_id.toString());
                               return Fluttertoast.showToast(
        msg: "Series added to your list",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
                              } else {
                                series_services.setRemoveLiked_Series(
                                    seriesCard.series_id.toString());
                                      return Fluttertoast.showToast(
        msg: "Series removed from your list",
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
