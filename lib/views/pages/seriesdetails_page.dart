import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/controllers/controllers.dart';
import 'package:flutter_application_1/widgets/MovieDetailed_widget.dart';
import 'package:flutter_application_1/widgets/SeriesDetailed_widget.dart';
import 'package:flutter_application_1/widgets/seriesCard_widget.dart';
import 'package:flutter_application_1/widgets/upcomingseriesCard_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/widgets.dart';

Widgets my_widgets = Widgets();
var idx;

class seriesDetailsPage extends StatefulWidget {
  final String id;
  const seriesDetailsPage({required this.id, Key? key}) : super(key: key);
  @override
  State<seriesDetailsPage> createState() => _seriesDetailsPageState();
}

class _seriesDetailsPageState extends State<seriesDetailsPage> {
  late Controller _seriesController;

  @override
  void initState() {
    _seriesController = Controller(this);
    _seriesController.getSeriesByIdHandler(widget.id);
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
        body: (_seriesController.seriesByIdList == null)
            ? const Center(
                child: SpinKitFadingCircle(
                  size: 100,
                  color: Colors.amber,
                ),
              )
            : (_seriesController.seriesByIdList?.isEmpty ?? false)
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
                          SizedBox(
                            height: 560,
                            child: GridView.builder(
                                itemCount: _seriesController
                                        .seriesByIdList?.length ??
                                    0,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 10.5 / 20.0,
                                  crossAxisCount: 1,
                                ),
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    child: SeriesDetailed_Card(
                                      seriesCard: _seriesController
                                          .seriesByIdList![index],
                                      onSeriesClicked: () {
                                   Navigator.push(
            context, MaterialPageRoute(builder: (_) =>seriesDetailsPage(id: _seriesController
                                          .seriesList![index].series_id.toString())));
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
