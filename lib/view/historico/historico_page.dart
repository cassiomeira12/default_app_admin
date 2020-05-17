import '../../view/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class HistoricoPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String title, message;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Notification", style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  titleInput(),
                  messageInput(),
                  PrimaryButton(
                    text: "Enviar",
                    onPressed: sendNotigication,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendNotigication() async {
    //var topics = ['all'];
    //bool value = await FirebaseNotifications.subscribeToTopic("all");
    //print(value);

//    String userToken = await PreferencesUtil.getNotificationToken();

//    int code = await FirebaseNotifications.sendNotification(title, message, null, "com.android.defaultappflutter");
//    if (code == 200) {
//      ScaffoldSnackBar.success(context, _scaffoldKey, "Notificação enviada com sucesso!");
//    } else {
//      ScaffoldSnackBar.failure(context, _scaffoldKey, "Erro ao enviar notificação!");
//    }
  }

  Widget titleInput () {
    //var controller = MaskedTextController(mask: '(00) 0 0000-0000');
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
      child: TextFormField(
        textAlign: TextAlign.left,
        maxLines: 1,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.body2,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: "Titulo",
          //hintText: "(XX) X XXXX-XXXX",
          //hintStyle: Theme.of(context).textTheme.body2,
          labelStyle: Theme.of(context).textTheme.body2,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).errorColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).errorColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).hintColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        onChanged: (value) => title = value,
        //controller: controller,
        //validator: (value) => value.isEmpty ? DIGITE_NOME : null,
        //onSaved: (value) => _userName = value.trim(),
      ),
    );
  }

  Widget messageInput () {
    //var controller = MaskedTextController(mask: '(00) 0 0000-0000');
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
      child: TextFormField(
        textAlign: TextAlign.left,
        maxLines: 1,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.body2,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: "Mensagem",
          //hintText: "(XX) X XXXX-XXXX",
          //hintStyle: Theme.of(context).textTheme.body2,
          labelStyle: Theme.of(context).textTheme.body2,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).errorColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).errorColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).hintColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        onChanged: (value) => message = value,
        //controller: controller,
        //validator: (value) => value.isEmpty ? DIGITE_NOME : null,
        //onSaved: (value) => _userName = value.trim(),
      ),
    );
  }

}