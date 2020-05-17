import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import '../strings.dart';

class IntroPage extends StatefulWidget {
  IntroPage({this.introDoneCallback});

  final VoidCallback introDoneCallback;

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  List<Slide> slides = List();

  @override
  void initState() {
    super.initState();
    slides.add(slideStart());
    //slides.add(slide1());
    //slides.add(slide2());
    //slides.add(slide3());
    slides.add(slideFinish());
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: slides,
      colorSkipBtn: Color(0x33000000),
      highlightColorSkipBtn: Color(0xff000000),
      nameSkipBtn: "Pular",
      renderNextBtn: Icon(
        Icons.navigate_next,
        color: Colors.white,
        size: 35.0,
      ),
      colorDoneBtn: Color(0x33000000),
      highlightColorDoneBtn: Color(0xff000000),
      renderDoneBtn: Icon(
        Icons.done,
        color: Colors.white,
        size: 35.0,
      ),
      colorDot: Color(0x33D02090),
      colorActiveDot: Theme.of(context).errorColor,
      onDonePress: widget.introDoneCallback,
    );
  }

  Slide slideStart() {
    return Slide(
      title: APP_NAME,
      styleTitle: styleTitle(),
      description:"Bem-vindo ao ${APP_NAME}",
      styleDescription: styleDescription(),
      pathImage: "assets/logo_app.png",
      colorBegin: Color(0xffFFDAB9),
      colorEnd: Color(0xff40E0D0),
      directionColorBegin: Alignment.topLeft,
      directionColorEnd: Alignment.bottomRight,
    );
  }

  Slide slideFinish() {
    return Slide(
      //title: "Login",
      //styleTitle: styleTitle(),
      description:"Crie uma conta e aproveite todos os recurso do ${APP_NAME}",
      styleDescription: styleDescription(),
      pathImage: "assets/logo_app.png",
      colorBegin: Color(0xffFFDAB9),
      colorEnd: Color(0xff40E0D0),
      directionColorBegin: Alignment.topLeft,
      directionColorEnd: Alignment.bottomRight,
    );
  }

  TextStyle styleTitle() {
    return TextStyle(
      fontSize: 30,
      color: Colors.black45,
      fontWeight: FontWeight.bold,
      fontFamily: 'RobotoMono',
    );
  }

  TextStyle styleDescription() {
    return TextStyle(
      fontSize: 20,
      color: Colors.black45,
      fontWeight: FontWeight.bold,
      fontFamily: 'Raleway',
    );
  }

  Slide slide1() {
    return Slide(
      title: "Gerenciar",
      styleTitle: styleTitle(),
      description:"Controle todos os gastos com seu veículo",
      styleDescription: styleDescription(),
      pathImage: "assets/produto.png",
      colorBegin: Color(0xffFFDAB9),
      colorEnd: Color(0xff40E0D0),
      directionColorBegin: Alignment.topRight,
      directionColorEnd: Alignment.bottomLeft,
    );
  }

  Slide slide2() {
    return Slide(
      title: "Combustível",
      styleTitle: styleTitle(),
      description:"Anote todos os gastos com combustível",
      styleDescription: styleDescription(),
      pathImage: "assets/combustivel.png",
      colorBegin: Color(0xffFFDAB9),
      colorEnd: Color(0xff40E0D0),
      directionColorBegin: Alignment.topLeft,
      directionColorEnd: Alignment.bottomRight,
    );
  }

  Slide slide3() {
    return Slide(
      title: "Manutenção",
      styleTitle: styleTitle(),
      description:"Gerencie as manutenções e revisões do seu veículo",
      styleDescription: styleDescription(),
      pathImage: "assets/manutencao.png",
      colorBegin: Color(0xffFFDAB9),
      colorEnd: Color(0xff40E0D0),
      directionColorBegin: Alignment.topRight,
      directionColorEnd: Alignment.bottomLeft,
    );
  }

}
