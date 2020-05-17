import '../../model/user_notification.dart';
import '../../utils/date_util.dart';
import 'package:flutter/material.dart';

class NotificationWidget extends StatefulWidget {
  final UserNotification notification;
  final VoidCallback onPressed;

  const NotificationWidget({
    this.notification,
    this.onPressed,
  });

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  
  Color _colorButton, _colorTextButton;

  @override
  void initState() {
    super.initState();
    _colorTextButton = Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1,left: 0, right: 0, bottom: 0),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
          elevation: 0.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),),
          color: widget.notification.read ? Theme.of(context).backgroundColor : Theme.of(context).primaryColorLight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  widget.notification.avatarURL == null ? Container() : imageNetworkURL(widget.notification.avatarURL),
                  widget.notification.title == null ? Container() : Expanded(child: titleWidget(),),
                  //buttonAction(),
                ],
              ),
              widget.notification.message == null ? Container() : messageWidget(),
              dataWidget(),
            ],
          ),
          onPressed: widget.onPressed,
        ),
      ),
    );
  }

  Widget titleWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Text(
        widget.notification.title,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.display3,
      ),
    );
  }

  Widget messageWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Text(
        widget.notification.message,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.display4,
      ),
    );
  }

  Widget dataWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Text(
        "${DateUtil.formatDateMouthHour(widget.notification.createAt)}",
        style: Theme.of(context).textTheme.display2,
      ),
    );
  }

  Widget buttonAction() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        height: 28,
        child: RaisedButton(
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: _colorButton == null ? Theme.of(context).buttonColor : _colorButton,
          child: Text(
            "Action",
            style: TextStyle(
              color: _colorTextButton,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            setState(() {
              _colorButton = Colors.white;
              _colorTextButton = Colors.grey;
            });
          },
        ),
      ),
    );
  }

  Widget imageNetworkURL(String url) {
    return Container(
      width: 37,
      height: 37,
      margin: EdgeInsets.only(top: 2, right: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
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

}

