import '../../contract/user/user_contract.dart';
import '../../model/base_user.dart';
import '../../model/singleton/singleton_user.dart';
import '../../presenter/user/user_presenter.dart';
import '../../strings.dart';
import 'package:flutter/material.dart';

class NotificationsSettingsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _NotificationsSettingsState();
}

class _NotificationsSettingsState extends State<NotificationsSettingsPage> implements UserContractView {
  final _formKey = new GlobalKey<FormState>();

  bool notifications = SingletonUser.instance.notificationToken.active;

  UserContractPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = UserPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        title: Text(NOTIFICATIONS, style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  notificacoesButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  onFailure(String error) {

  }

  @override
  onSuccess(BaseUser user) {

  }

  Widget notificacoesButton() {
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
              Expanded(
                child: Text(
                  RECEBER_NOTIFICACOES,
                  style: Theme.of(context).textTheme.body2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                child: Switch(
                  value: notifications,
                  activeColor: Theme.of(context).accentColor,
                  onChanged: (value) {
                    setState(() {
                      notifications = value;
                    });
                  },
                ),
              ),
            ],
          ),
          onPressed: () {
            setState(() {
              notifications = !notifications;
              SingletonUser.instance.notificationToken.active = notifications;
              presenter.update(SingletonUser.instance);
            });
          },
        ),
      ),
    );
  }

}