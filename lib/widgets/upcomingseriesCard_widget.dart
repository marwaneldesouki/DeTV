// ignore_for_file: avoid_print

import 'dart:async';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/models/series_model.dart';
import 'package:flutter_application_1/models/upcomingseries_model.dart';
import 'package:flutter_application_1/services/Upcomingseries_services.dart';
import 'package:flutter_application_1/services/series_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controllers/controllers.dart';

class UpcomingSeriesCard extends StatelessWidget {
  final UpcomingSeries seriesCard;
  final void Function()? onSeriesClicked;

  UpcomingSeries_Services series_services =UpcomingSeries_Services();
  UpcomingSeriesCard({required this.seriesCard, required this.onSeriesClicked, Key? key})
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
                    image:NetworkImage(seriesCard.series_poster!),
                    fit: BoxFit.fill,
                    width: 600,
                    child: InkWell(onTap: onSeriesClicked),
                  ),
                ),
                Expanded(
                    child: ListTile(
                        title: Text(
                          seriesCard.series_name ?? "No series name",
                          style: TextStyle(fontSize: 18),
                          maxLines: 1,
                        ),
                        subtitle: Text("Rating:${seriesCard.series_vote??"NR"}",
                            style: TextStyle(fontSize: 18), maxLines: 1),
                        trailing: FavoriteButton(
                            isFavorite: seriesCard.liked_,
                            valueChanged: (_isFavorite) {
                              if (_isFavorite) {
                                series_services.setAddLiked_Series(
                                    seriesCard.series_id.toString());
                               return Fluttertoast.showToast(
        msg: "series added to your list",
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
        msg: "series removed from your list",
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
