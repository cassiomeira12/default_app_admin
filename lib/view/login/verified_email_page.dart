import '../../contract/user/user_contract.dart';
import '../../model/base_user.dart';
import '../../model/singleton/singleton_user.dart';
import '../../presenter/user/user_presenter.dart';
import '../../view/widgets/background_card.dart';
import '../../view/widgets/primary_button.dart';
import '../../view/widgets/secondary_button.dart';
import '../../view/widgets/shape_round.dart';
import 'package:flutter/material.dart';

import '../../strings.dart';

class VerifiedEmailPage extends StatefulWidget {
  VerifiedEmailPage({this.logoutCallback});

  final VoidCallback logoutCallback;

  @override
  State<StatefulWidget> createState() => _VerifiedEmailPageState();
}

class _VerifiedEmailPageState extends State<VerifiedEmailPage> implements UserContractView {
  String email = "";
  String imgEmail = "assets/error.png";
  bool sendingEmail = true;
  String textMessage = "";

  UserContractPresenter presenter;

  @override
  void initState() {
    super.initState();
    email = SingletonUser.instance.email;
    presenter = UserPresenter(this);
    presenter.sendEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            BackgroundCard(),
            SingleChildScrollView(
              child: ShapeRound(
                  _showForm()
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showForm() {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Form(
        //key: _formKey,
        child: Column(
          children: <Widget>[
            textTitle(),
            showLogo(),
            textObservacao(),
            textMensagem(),
            sendEmailButton(),
            loginButton(),
          ],
        ),
      ),
    );
  }

  Widget textTitle() {
    return Center(
      child: Text(
        EMAIL_VERIFICACAO,
        style: Theme.of(context).textTheme.subtitle,
      ),
    );
  }

  Widget showLogo() {
    return sendingEmail ?
    Padding(
      padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 25.0),
      child: CircularProgressIndicator(),
    ) :
    Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset(imgEmail),
        ),
      ),
    );
  }

  Widget textObservacao() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 16, 0, 0),
      child: Text(
        OBSERVACAO_ENVIAR_EMAIL,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.display1,
      ),
    );
  }

  Widget textMensagem() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              textMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.body2,
            ),
            Text(
              email,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sendEmailButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
      child: SecondaryButton(
        text: REENVIAR_EMAIL,
        onPressed: () {
          setState(() {
            sendingEmail = true;
          });
          presenter.sendEmailVerification();
        },
      ),
    );
  }

  Widget loginButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
      child: PrimaryButton(
        text: FAZER_LOGIN,
        onPressed: () {
          widget.logoutCallback();
        },
      ),
    );
  }

  @override
  onFailure(String error) {
    setState(() {
      sendingEmail = false;
      this.textMessage = error;
      this.imgEmail = "assets/error.png";
    });
  }

  @override
  onSuccess(BaseUser user) {
    setState(() {
      sendingEmail = false;
      this.textMessage = EMAIL_VERIFICACAO_ENVIADO;
      this.imgEmail = "assets/email.png";
    });
  }

}