import '../../model/version_app.dart';
import '../../presenter/version_app_presenter.dart';
import '../../strings.dart';
import '../../view/widgets/background_card.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutAppPage> {
  final _formKey = GlobalKey<FormState>();

  String statusVersionApp = "Procurando atualização...", currentVersion = "...";
  bool loading = true;

  VersionApp versionApp;
  var icon = Icons.check_circle;
  var colorIcon = Colors.green;

  @override
  void initState() {
    super.initState();
    getCurrentVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        title: Text(ABOUT, style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                BackgroundCard(height: 200,),
                _showForm(),
              ],
            ),
            versionAppWidget(),
            txtAboutApp(),
          ],
        ),
      ),
    );
  }

  void getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    int buildNumber = int.parse(packageInfo.buildNumber);

    versionApp = await VersionAppPresenter().checkCurrentVersion(packageName);

    if (versionApp == null) {
      setState(() {
        statusVersionApp = "Tente novamente mais tarde";
        icon = Icons.info;
        colorIcon = Colors.grey;
      });
    } else {
      if (buildNumber == versionApp.currentCode) {
        setState(() {
          statusVersionApp = "Última versão";
        });
      } else if (buildNumber >= versionApp.minimumCode) {
        setState(() {
          statusVersionApp = "Click e baixe a nova versão!";
          icon = Icons.system_update;
          colorIcon = Colors.blue;
        });
      }
    }
    setState(() {
      currentVersion = "Versão atual: $version";
      loading = false;
    });
  }

  Widget versionAppWidget() {
    return Card(
      child: MaterialButton(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
          child: Row(
            children: <Widget>[
              loading ?
              Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
                child: CircularProgressIndicator(),
              )
                :
              Icon(
                icon,
                color: colorIcon,
                size: 50,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      statusVersionApp,
                      style: Theme.of(context).textTheme.body1,
                    ),
                    Text(
                      currentVersion,
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onPressed: () async {
          if (await canLaunch(versionApp.url)) {
            launch(versionApp.url);
          }
        },
      ),
    );
  }

  Widget _showForm() {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            imgApp(),
            txtAppName(),
          ],
        ),
      ),
    );
  }

  Widget imgApp() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: Center(
        child: Hero(
          tag: "about",
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 80.0,
              child: Image.asset("assets/logo_app.png"),
            ),
          ),
        ),
      ),
    );
  }

  Widget txtAppName() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: Center(
        child: Text(
          APP_NAME,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.body1,
        ),
      ),
    );
  }

  Widget txtAboutApp() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      width: double.maxFinite,
      child: Text(
        "About App",
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }

}