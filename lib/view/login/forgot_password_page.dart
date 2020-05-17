import '../../contract/login/forgot_password_contract.dart';
import '../../presenter/login/forgot_password_presenter.dart';
import '../../view/widgets/background_card.dart';
import '../../view/widgets/primary_button.dart';
import '../../view/widgets/scaffold_snackbar.dart';
import '../../view/widgets/shape_round.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../strings.dart';

class ForgotPasswordPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordPage> implements ForgotPasswordContractView {
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ForgotPasswordContractPresenter presenter;

  String _email;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    presenter = ForgotPasswordPresenter(this);
  }

  @override
  void dispose() {
    super.dispose();
    presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( iconTheme: IconThemeData(color: Colors.white), elevation: 0,),
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
        key: _formKey,
        child: Column(
          children: <Widget>[
            textTitle(),
            emailInput(),
            textMensagem(),
            _isLoading ? showCircularProgress() : sendButton()
          ],
        ),
      ),
    );
  }

  Widget textTitle() {
    return Center(
      child: Text(
        RECUPERAR_SENHA,
        style: Theme.of(context).textTheme.subtitle,
      ),
    );
  }

  Widget emailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
      child: TextFormField(
        textAlign: TextAlign.left,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        style: Theme.of(context).textTheme.body2,
        //textCapitalization: TextCapitalization.words,
        obscureText: false,
        decoration: InputDecoration(
          labelText: EMAIL,
          labelStyle: Theme.of(context).textTheme.body2,
          //hintText: "",
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
        validator: (value) => value.isEmpty ? EMAIL_INVALIDO : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget textMensagem() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
      child: Center(
        child: Text(
          FORGOT_PASSWORD_TEXT,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.body2,
        ),
      ),
    );
  }

  Widget showCircularProgress() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
      child: CircularProgressIndicator(),
    );
  }

  Widget sendButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: PrimaryButton(
        text: ENVIAR,
        onPressed: () {
          if (validateAndSave()) {
            setState(() {
              _isLoading = true;
            });
            presenter.sendEmail(_email);
          }
        },
      ),
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

  @override
  hideProgress() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  showProgress() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  onFailure(String error) {
    ScaffoldSnackBar.failure(context, _scaffoldKey, error);
  }

  @override
  onSuccess(String result) {
    ScaffoldSnackBar.success(context, _scaffoldKey, result);
  }

}
