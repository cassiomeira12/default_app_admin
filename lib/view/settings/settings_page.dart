import '../../contract/user/user_contract.dart';
import '../../model/base_user.dart';
import '../../model/singleton/singleton_user.dart';
import '../../presenter/user/user_presenter.dart';
import '../../strings.dart';
import '../../themes/my_themes.dart';
import '../../themes/custom_theme.dart';
import '../../view/notifications/notifications_settings_page.dart';
import '../../view/page_router.dart';
import '../../view/settings/about_app_page.dart';
import '../../view/settings/disable_account_page.dart';
import '../../view/settings/termos_app_page.dart';
import '../../view/settings/user_page.dart';
import '../../view/widgets/background_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({this.logoutCallback});

  final VoidCallback logoutCallback;

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> implements UserContractView {
  final _formKey = new GlobalKey<FormState>();

  UserContractPresenter presenter;

  bool darkMode;
  String userName, userPhoto;

  @override
  void initState() {
    super.initState();
    presenter = UserPresenter(this);
    userName = SingletonUser.instance.name;
    userPhoto = SingletonUser.instance.avatarURL;
  }

  @override
  Widget build(BuildContext context) {
    darkMode = CustomTheme.instanceOf(context).isDarkTheme();
    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        title: Text(SETTINGS, style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                BackgroundCard(height: 150,),
                imgUser(),
              ],
            ),
            textNameWidget(),
            listConfigWidget(),
          ],
        ),
      ),
    );
  }

  Widget imgUser() {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.bottomRight,
            width: 120,
            child: Hero(
              tag: 'imgUser',
              child: GestureDetector(
                child: Stack(
                  children: <Widget>[
                    defaultImageUser(),
                    userPhoto == null ? Container() : imageUserURL()
                  ],
                ),
                onTap: () {
                  PageRouter.push(context, UserPage());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget defaultImageUser() {
    return Container(
      width: 120,
      height: 120,
      child: Image.asset("assets/user_default_img_white.png"),
    );
  }

  Widget imageUserURL() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(userPhoto),
        ),
      ),
    );
  }

  Widget listConfigWidget() {
    return Column(
      children: <Widget>[
        perfilButton(),
        notificationsSettingsButton(),
        darkModeButton(),
        aboutAppButton(),
        termosButton(),
        disableAccountButton(),
        signOutButton(),
        Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40),),
      ],
    );
  }

  Widget textNameWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
      child: Center(
        child: Text(
          userName,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.body1,
        ),
      ),
    );
  }

  Widget perfilButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: RaisedButton(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            //side: BorderSide(color: Colors.black26),
          ),
          color: Theme.of(context).backgroundColor,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                child: FaIcon(FontAwesomeIcons.userAlt, color: Theme.of(context).iconTheme.color,),
              ),
              Expanded(
                child: Text(
                  PERFIL,
                  style: Theme.of(context).textTheme.body2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                child: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color,),
              ),
            ],
          ),
          onPressed: () {
            PageRouter.push(context, UserPage());
          },
        ),
      ),
    );
  }

  Widget notificationsSettingsButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: RaisedButton(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            //side: BorderSide(color: Colors.black26),
          ),
          color: Theme.of(context).backgroundColor,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                child: FaIcon(FontAwesomeIcons.solidBell, color: Theme.of(context).iconTheme.color,),
              ),
              Expanded(
                child: Text(
                  NOTIFICATIONS,
                  style: Theme.of(context).textTheme.body2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                child: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color,),
              ),
            ],
          ),
          onPressed: () {
            PageRouter.push(context, NotificationsSettingsPage());
          },
        ),
      ),
    );
  }

  Widget darkModeButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: RaisedButton(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            //side: BorderSide(color: Colors.black26),
          ),
          color: Theme.of(context).backgroundColor,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                child: FaIcon(FontAwesomeIcons.palette, color: Theme.of(context).iconTheme.color,),
              ),
              Expanded(
                child: Text(
                  DARK_MODE,
                  style: Theme.of(context).textTheme.body2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                child: Switch(
                  value: darkMode,
                  activeColor: Theme.of(context).accentColor,
                  onChanged: (value) {
                    setState(() {
                      darkMode = !darkMode;
                      if (darkMode) {
                        CustomTheme.instanceOf(context).changeTheme(MyThemeKeys.DARK);
                      } else {
                        CustomTheme.instanceOf(context).changeTheme(MyThemeKeys.LIGHT);
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          onPressed: () {
            setState(() {
              darkMode = !darkMode;
              if (darkMode) {
                CustomTheme.instanceOf(context).changeTheme(MyThemeKeys.DARK);
              } else {
                CustomTheme.instanceOf(context).changeTheme(MyThemeKeys.LIGHT);
              }
            });
          },
        ),
      ),
    );
  }

  Widget aboutAppButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: RaisedButton(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            //side: BorderSide(color: Colors.black26),
          ),
          color: Theme.of(context).backgroundColor,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                child: FaIcon(FontAwesomeIcons.infoCircle, color: Theme.of(context).iconTheme.color,),
              ),
              Expanded(
                child: Text(
                  ABOUT,
                  style: Theme.of(context).textTheme.body2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                child: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color,),
              ),
            ],
          ),
          onPressed: () {
            PageRouter.push(context, AboutAppPage());
          },
        ),
      ),
    );
  }

  Widget termosButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: RaisedButton(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            //side: BorderSide(color: Colors.black26),
          ),
          color: Theme.of(context).backgroundColor,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                child: FaIcon(FontAwesomeIcons.solidQuestionCircle, color: Theme.of(context).iconTheme.color,),
              ),
              Expanded(
                child: Text(
                  TERMOS,
                  style: Theme.of(context).textTheme.body2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                child: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color,),
              ),
            ],
          ),
          onPressed: () {
            PageRouter.push(context, TermosAppPage());
          },
        ),
      ),
    );
  }

  Widget disableAccountButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: RaisedButton(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            //side: BorderSide(color: Colors.black26),
          ),
          color: Theme.of(context).backgroundColor,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                child: FaIcon(FontAwesomeIcons.userTimes, color: Theme.of(context).iconTheme.color,),
              ),
              Expanded(
                child: Text(
                  DISABLE_ACCOUNT,
                  style: Theme.of(context).textTheme.body2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                child: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color,),
              ),
            ],
          ),
          onPressed: () {
            PageRouter.push(context, DisableAccountPage());
          },
        ),
      ),
    );
  }

  Widget signOutButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: RaisedButton(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            //side: BorderSide(color: Colors.black26),
          ),
          color: Theme.of(context).backgroundColor,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                child: FaIcon(FontAwesomeIcons.signOutAlt, color: Theme.of(context).iconTheme.color,),
              ),
              Expanded(
                child: Text(
                  SIGNOUT,
                  style: TextStyle(fontSize: 18.0, color: Theme.of(context).errorColor),
                ),
              ),
              Container(
                child: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color,),
              ),
            ],
          ),
          onPressed: () {
            showDialogLogOut();
          },
        ),
      ),
    );
  }

  void showDialogLogOut() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(SIGNOUT),
          content: Text("Deseja sair do ${APP_NAME} ?"),
          actions: <Widget>[
            FlatButton(
              child: Text(CANCELAR),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(SIGNOUT),
              onPressed: () {
                PageRouter.pop(context);
                presenter.signOut().whenComplete(() {
                  widget.logoutCallback();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  onFailure(String error) {
    return null;
  }

  @override
  onSuccess(BaseUser user) {
    return null;
  }

}