import '../../model/base_user.dart';
import '../../strings.dart';
import '../../view/login/create_account_page.dart';
import '../../view/widgets/background_card.dart';
import '../../view/widgets/primary_button.dart';
import '../../view/widgets/shape_round.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../page_router.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({this.loginCallback});

  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{
  final _formKey = new GlobalKey<FormState>();

  String _name;
  String _email;
  String _password;

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
            nameInput(),
            emailInput(),
            passwordInput(),
            confirmPasswordInput(),
            textData(),
            createAccountButton(),
          ],
        ),
      ),
    );
  }

  Widget textTitle() {
    return Center(
      child: Text(
        CRIAR_CONTA,
        style: Theme.of(context).textTheme.subtitle,
      ),
    );
  }

  Widget nameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
      child: TextFormField(
        textAlign: TextAlign.left,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        style: Theme.of(context).textTheme.body2,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: NOME,
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
        validator: (value) => value.isEmpty ? DIGITE_SEU_NOME : null,
        onSaved: (value) => _name = value.trim(),
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

  Widget passwordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
      child: TextFormField(
        textAlign: TextAlign.left,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        style: Theme.of(context).textTheme.body2,
        //textCapitalization: TextCapitalization.words,
        obscureText: true,
        decoration: InputDecoration(
          labelText: SENHA,
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
        validator: (value) {
          if (value.isEmpty || value.length < 6) {
            return SENHA_MUITO_CURTA;
          }
          _password = value;
          return null;
        },
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget confirmPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
      child: TextFormField(
        textAlign: TextAlign.left,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        style: Theme.of(context).textTheme.body2,
        //textCapitalization: TextCapitalization.words,
        obscureText: true,
        decoration: InputDecoration(
          labelText: REPITA_SENHA,
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
        validator: (value) {
          if (value.isEmpty || value.length < 6) {
            return SENHA_MUITO_CURTA;
          }
          if (_password != value) {
            return SENHA_NAO_SAO_IGUAIS;
          }
          return null;
        },
      ),
    );
  }

  Widget textData() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
      child: Center(
        child: Text(
          TEXT_DADOS,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.body2,
        ),
      ),
    );
  }

  Widget createAccountButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: PrimaryButton(
        text: CRIAR_CONTA,
        onPressed: createAccount,
      ),
    );
  }

  bool validateData() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  BaseUser createBaseUser() {
    BaseUser user = BaseUser();
    user.name = _name;
    user.email = _email;
    user.password = _password;
    user.createAt = DateTime.now();
    return user;
  }

  void createAccount() {
    if (validateData()) {
      var user = createBaseUser();
      PageRouter.pop(context);
      PageRouter.push(context, CreateAccountPage(loginCallback: widget.loginCallback, user: user,));
    }
  }

}
