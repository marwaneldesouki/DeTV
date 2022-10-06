import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/controllers/controllers.dart';
import 'package:flutter_application_1/views/pages/moviedetails_page.dart';
import 'package:flutter_application_1/views/pages/seriesdetails_page.dart';
import 'package:flutter_application_1/widgets/upcomingmovieCard_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/movieCard_widget.dart';
import '../../widgets/upcomingseriesCard_widget.dart';
import '../../widgets/widgets.dart';

Widgets my_widgets = Widgets();

class upcomingseriesPage extends StatefulWidget {
  const upcomingseriesPage({Key? key}) : super(key: key);

  @override
  State<upcomingseriesPage> createState() => _upcomingseriesPageState();
}

class _upcomingseriesPageState extends State<upcomingseriesPage> {
  late Controller _seriesController;
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    _seriesController = Controller(this);
    _seriesController.getUpcomingSeriesHandler();

    super.initState();
  }

  @override
  void dispose() {
    _seriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Center(
              child: Image.asset(
            'assets/images/logo.png',
            height: 90,
            width: 90,
          )),
          backgroundColor: HexColor("#23243D"),
        ),
        drawer: my_widgets.app_drawer(context),
          bottomNavigationBar: BottomNavigationBar(
          items: my_widgets.my_appnavigator_items(),
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.orange,
          currentIndex: 2,
          onTap: (index) {
            setState(() {
              my_widgets.index_ = index;
              Navigator.popAndPushNamed(context, index.toString());
            });
          },
        ),
        body: (_seriesController.upcomingSeriesList == null)
            ? const Center(
                child: SpinKitFadingCircle(
                  size: 100,
                  color: Colors.amber,
                ),
              )
            : (_seriesController.upcomingSeriesList?.isEmpty ?? false)
                ? const Center(
                    child: Text('No Data'),
                  )
                : Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Upcoming series:",
                                style: TextStyle(fontSize: 30),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 560,
                            child: GridView.builder(
                                itemCount: _seriesController
                                        .upcomingSeriesList?.length ??
                                    0,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 10.5 / 20.0,
                                  crossAxisCount: 2,
                                ),
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    child: UpcomingSeriesCard(
                                      seriesCard: _seriesController
                                          .upcomingSeriesList![index],
                                      onSeriesClicked: () {
                                       Navigator.push(
            context, MaterialPageRoute(builder: (_) =>seriesDetailsPage(id:_seriesController
                                            .upcomingSeriesList![index]
                                            .series_id.toString())));
                                      },
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 250,
                          ),
                        ],
                      ),
                    ),
                  ));
  }
}
