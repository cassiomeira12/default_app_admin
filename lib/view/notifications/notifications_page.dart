import '../../contract/user/notification_contract.dart';
import '../../model/user_notification.dart';
import '../../presenter/user/notification_presenter.dart';
import '../../strings.dart';
import '../../view/notifications/notification_widget.dart';
import '../../view/notifications/notifications_settings_page.dart';
import '../../view/page_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'notification_page.dart';

class NotificationsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> implements NotificationContractView {
  final _formKey = GlobalKey<FormState>();
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  NotificationContractPresenter presenter;

  List<UserNotification> notificationsList;

  @override
  void initState() {
    super.initState();
    presenter = NotificationPresenter(this);
    presenter.list();
  }

  @override
  void dispose() {
    super.dispose();
    presenter.dispose();
  }

  @override
  listNotifications(List<UserNotification> list) {
    setState(() {
      notificationsList = list;
    });
  }

  @override
  onFailure(String error) {
    return null;
  }

  @override
  onSuccess(UserNotification result) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        title: Text(NOTIFICATIONS, style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          MaterialButton(
            child: Text(
              CONFIGURAR,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => PageRouter.push(context, NotificationsSettingsPage()),
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
          return presenter.list();
        },
        child: Center(
          child: notificationsList == null ?
          showCircularProgress()
              :
          notificationsList.isEmpty ?
          semNotificacoes()
              :
          CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  notificationsList.map<Widget>((item) {
                    return listItem(item);
                  }).toList()
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem(UserNotification item) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: NotificationWidget(
        notification: item,
        onPressed: () {
          PageRouter.push(context,
            NotificationPage(
              presenter: presenter,
              notification: item,
            ),
          );
        },
      ),
//      actions: <Widget>[
//        IconSlideAction(
//          caption: "Lido",
//          color: Colors.blue,
//          icon: Icons.archive,
//          onTap: () {
//            setState(() {
//              item.read = true;
//              presenter.update(item);
//            });
//          },
//        ),
//      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: DELETAR,
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            setState(() {
              presenter.delete(item);
              notificationsList.remove(item);
            });
          },
        ),
      ],
    );
  }

  Widget showCircularProgress() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  Widget semNotificacoes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 80,
          height: 80,
          child: Image.asset("assets/notification.png"),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
          child: Center(
            child: Text(
              SEM_NOTIFICACOES,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.body2,
            ),
          ),
        )
      ],
    );
  }

}