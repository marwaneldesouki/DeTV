import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/views/pages/home_page.dart';
import 'package:flutter_application_1/views/pages/splash_page.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({Key? key}) : super(key: key);

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  List<Slide> slides = [];
  @override
  void initState() {
    slides.add(
      new Slide(
          title: "Welcome To DeTV APP",
          description: "this app coded with 💖 by Marwaneldesouki."),
    );
    slides.add(
      new Slide(
          title: "Movies",
          description: "You can watch all movies and search on it."),
    );
    slides.add(
      new Slide(
          title: "Series",
          description: "and also you can watch all series and search on it."),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (var i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 160, top: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
                child: Image.asset("assets/images/logo.png",matchTextDirection: true,height:120,),
              ),
              Container(
                child: Text(
                  currentSlide.title.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  currentSlide.description.toString(),
                  style:
                      TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(
                  top: 15,
                  left: 20,
                  right: 20,
                ),
              )
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      backgroundColorAllSlides: HexColor("#24263F"),
      renderSkipBtn: Text(
        "Skip",
        style: TextStyle(color: HexColor("#272DDB")),
      ),
      renderNextBtn: Text(
        "Next",
        style: TextStyle(color: Colors.white70),
      ),
      renderDoneBtn: Text("Done", style: TextStyle(color: HexColor("#272DDB"))),
      colorDot: Colors.white,
      sizeDot: 8.0,
      typeDotAnimation: DotSliderAnimation.SIZE_TRANSITION,
      listCustomTabs: this.renderListCustomTabs(),
      scrollPhysics: BouncingScrollPhysics(),
      hideStatusBar: false,
      onDonePress: () async{
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setBool('intro_slider',true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => SplashPage()));
            
      },
    );
  }
}
