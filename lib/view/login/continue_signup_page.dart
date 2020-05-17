import 'package:flutter/material.dart';

class ContinueSignUpPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ContinueSignUpPageState();
}

class _ContinueSignUpPageState extends State<ContinueSignUpPage>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            backgroudCard(),
            bodyAppScrollView(),
          ],
        ),
      ),
    );
  }

  Widget backgroudCard() {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.greenAccent,
    );
  }

  Widget bodyAppScrollView() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          //_shapeRound(),
          //textOU(),
          //googleButton(),
          //googleButton2(),
          //showSecondaryButton(),
        ],
      ),
    );
  }

}