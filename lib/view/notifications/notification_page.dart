import '../../contract/user/notification_contract.dart';
import '../../model/user_notification.dart';
import '../../strings.dart';
import '../../utils/date_util.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  final NotificationContractPresenter presenter;
  final UserNotification notification;

  const NotificationPage({
    this.presenter,
    this.notification,
  });

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String title, message, observacao, imgURL, data;

  @override
  void initState() {
    super.initState();
    title = widget.notification.title;
    message = widget.notification.message;
    observacao = widget.notification.observacao;
    imgURL = widget.notification.avatarURL;
    data = DateUtil.formatDateMonth(widget.notification.createAt);

    if (!widget.notification.read) {
      widget.notification.read = true;
      updateNotification();
    }
  }
  
  void updateNotification() async {
    UserNotification temp = await widget.presenter.update(widget.notification);
    if (temp != null) {
      setState(() {
        widget.notification.update(temp);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(NOTIFICATION, style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                title == null ? Container() : titleWidget(),
                message == null ? Container() : textMessageWidget(),
                imgURL == null ? Container() : imageNetworkURL(imgURL),
                observacao == null ? Container() : observacaoWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget titleWidget() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
          color: Theme.of(context).primaryColor,
          child: textTitleWidget(),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: EdgeInsets.only(right: 10, bottom: 10),
            child: Text(
              data,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.body1,
            ),
          ),
        ),
      ],
    );
  }

  Widget textTitleWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle,
        ),
      ),
    );
  }

  Widget textMessageWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.body1,
        ),
      ),
    );
  }

  Widget imageNetworkURL(String url) {
    return Container(
      width: 200,
      height: 200,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Theme.of(context).hintColor,
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(url),
        ),
      ),
    );
  }

  Widget observacaoWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      color: Colors.black12,
      child: Text(
        observacao,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }

}
