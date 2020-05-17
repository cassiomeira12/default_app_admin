import '../../contract/user/user_contract.dart';
import '../../contract/user/verified_sms_contract.dart';
import '../../model/base_user.dart';
import '../../model/phone_number.dart';
import '../../model/singleton/singleton_user.dart';
import '../../presenter/user/user_presenter.dart';
import '../../presenter/user/verified_sms_presenter.dart';
import '../../contract/crud.dart';
import 'package:flutter/material.dart';
import '../../strings.dart';
import '../../view/widgets/background_card.dart';
import '../../view/widgets/primary_button.dart';
import '../../view/widgets/shape_round.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../page_router.dart';

class VerifiedPhoneNumberPage extends StatefulWidget {
  VerifiedPhoneNumberPage({this.phoneNumber});

  final PhoneNumber phoneNumber;

  @override
  State<StatefulWidget> createState() => _VerifiedPhoneNumberPageState();
}

class _VerifiedPhoneNumberPageState extends State<VerifiedPhoneNumberPage> implements VerifiedSMSContractView, UserContractView {
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = true;
  bool smsSent = false;
  bool waitingSMS = false;

  String _smsCode;
  String _verificationId;

  VerifiedSMSContractPresenter presenter;
  Crud crud;

  @override
  void initState() {
    super.initState();
    presenter = VerifiedSMSPresenter(this);
    crud = UserPresenter(this);
    presenter.verifyPhoneNumber(widget.phoneNumber.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            BackgroundCard(),
            bodyAppScrollView(),
          ],
        ),
      ),
    );
  }

  @override
  onFailure(String error) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Colors.red,
    ));
  }

  @override
  onSuccess(BaseUser user) async {
    SingletonUser.instance.update(user);
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(TELEFONE_ATUALIZADO),
      backgroundColor: Colors.green,
    ));
    await Future.delayed(const Duration(seconds: 2));
    PageRouter.pop(context);
  }

  @override
  verificationCompleted() {
    print("_verificationComplete");
    setState(() {
      waitingSMS = false;
    });
    widget.phoneNumber.verified = true;
    SingletonUser.instance.phoneNumber = widget.phoneNumber;
    crud.update(SingletonUser.instance);
  }

  @override
  codeSent(String verificationId) {
    print("_smsCodeSent");
    setState(() {
      loading = false;
      waitingSMS = true;
      smsSent = true;
      _verificationId = verificationId;
    });
  }

  @override
  codeAutoRetrievalTimeout(String verificationId) {
    print("_codeAutoRetriavalTimeout");
    setState(() {
      waitingSMS = false;
      _verificationId = verificationId;
    });
  }

  @override
  verificationFailed(String error) {
    print("_verificationFailed");
    print(error);
    setState(() {
      loading = false;
      waitingSMS = false;
      smsSent = true;
    });
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }

  Widget bodyAppScrollView() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ShapeRound(_showForm()),
        ],
      ),
    );
  }

  Widget _showForm() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.all(12.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            textTitle(),
            showSMSMessage(),
            smsSent ? showCodeInput() : Container(),
          ],
        ),
      ),
    );
  }

  Widget textTitle() {
    return Center(
      child: Text(
        NUMERO_CELULAR,
        style: Theme.of(context).textTheme.subtitle,
      ),
    );
  }

  Widget showSMSMessage() {
    return loading ?
    Padding(
      padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 25.0),
      child: CircularProgressIndicator(),
    ) :
    Column(
      children: <Widget>[
        textMessage(),
        textPhoneNumber(),
      ],
    );
  }

  Widget textMessage() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
      child: Center(
        child: Text(
          MENSAGEM_SMS_ENVIADO,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.body2,
        ),
      ),
    );
  }

  Widget textPhoneNumber() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
      child: Center(
        child: Text(
          widget.phoneNumber.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            color: Theme.of(context).textTheme.body2.color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget showCodeInput() {
    return (!loading && waitingSMS) ?
    Padding(
      padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
      child: CircularProgressIndicator(),
    ) : Column(
      children: <Widget>[
        codeInput(),
        resendSMSButton(),
        confirmationButton(),
      ],
    );
  }

  Widget codeInput() {
    var controller = MaskedTextController(mask: '000000');
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
      child: TextFormField(
        textAlign: TextAlign.center,
        maxLines: 1,
        keyboardType: TextInputType.phone,
        style: Theme.of(context).textTheme.body2,
        textCapitalization: TextCapitalization.words,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'XXXXXX',
          hintStyle: Theme.of(context).textTheme.body2,
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
        controller: controller,
        validator: (value) => value.isEmpty ? DIGITE_CODIGO_VALIDACAO : null,
        onSaved: (value) => _smsCode = value.trim(),
      ),
    );
  }

  Widget resendSMSButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
      child: RaisedButton(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          //side: BorderSide(color: Colors.black12),
        ),
        color: Colors.white,
        child: Text(
          REENVIAR_SMS,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black45,
            fontWeight: FontWeight.bold,
          )
        ),
        onPressed: () {
          presenter.verifyPhoneNumber(widget.phoneNumber.toString());
          setState(() {
            waitingSMS = false;
            loading = true;
            smsSent = false;
          });
        },
      ),
    );
  }

  Widget confirmationButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
      child: PrimaryButton(
        text: CONFIRMAR,
        onPressed: sendCode
      )
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void sendCode() {
    if (validateAndSave()) {
      setState(() {
        loading = true;
      });
      presenter.confirmSMSCode(_verificationId ,_smsCode);
    }
  }

}
