import '../../strings.dart';
import 'package:flutter/material.dart';

class TermosAppPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _TermosAppState();
}

class _TermosAppState extends State<TermosAppPage> {
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        title: Text(TERMOS, style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            txtTermosApp(),
          ],
        ),
      ),
    );
  }

  Widget txtTermosApp() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      width: double.maxFinite,
      child: Text(
        "Termos do App",
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }

}