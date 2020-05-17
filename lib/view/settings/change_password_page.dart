import '../../contract/user/user_contract.dart';
import '../../model/base_user.dart';
import '../../model/singleton/singleton_user.dart';
import '../../presenter/user/user_presenter.dart';
import '../../view/widgets/background_card.dart';
import '../../view/widgets/primary_button.dart';
import '../../view/widgets/shape_round.dart';
import 'package:flutter/material.dart';

import '../../strings.dart';

class ChangePasswordPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordPage> implements UserContractView {
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = false;

  String _currentPassword, _newPassword;
  UserContractPresenter presenter;

  var _controllerCurrentPassword = TextEditingController();
  var _controllerNewPassword = TextEditingController();
  var _controllerConfirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    presenter = UserPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(ALTERAR_SENHA, style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
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

  @override
  onFailure(String error) {
    setState(() {
      _isLoading = false;
    });
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }

  @override
  onSuccess(BaseUser user) {
    _controllerCurrentPassword.clear();
    _controllerNewPassword.clear();
    _controllerConfirmPassword.clear();
    setState(() {
      _isLoading = false;
    });
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(SENHA_ALTERADA_SUCESSO),
      backgroundColor: Colors.green,
    ));
  }

  Widget _showForm() {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            currentPasswordInput(),
            newPasswordInput(),
            confirmePasswordInput(),
            _isLoading ? showCircularProgress() : salvarButton()
          ],
        ),
      ),
    );
  }

  Widget currentPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
      child: TextFormField(
        textAlign: TextAlign.left,
        maxLines: 1,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.body2,
        textCapitalization: TextCapitalization.words,
        obscureText: true,
        decoration: InputDecoration(
          labelText: SENHA_ATUAL,
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
        validator: (value) => value.isEmpty ? EMAIL_INVALIDO : null,
        onSaved: (value) => _currentPassword = value.trim(),
        controller: _controllerCurrentPassword,
      ),
    );
  }

  Widget newPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
      child: TextFormField(
        textAlign: TextAlign.left,
        maxLines: 1,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.body2,
        textCapitalization: TextCapitalization.words,
        obscureText: true,
        decoration: InputDecoration(
          labelText: NOVA_SENHA,
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
        validator: (value) {
          if (value.isEmpty || value.length < 6) {
            return SENHA_MUITO_CURTA;
          }
          _newPassword = value;
          return null;
        },
        onSaved: (value) => _newPassword = value.trim(),
        controller: _controllerNewPassword,
      ),
    );
  }

  Widget confirmePasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
      child: TextFormField(
        textAlign: TextAlign.left,
        maxLines: 1,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.body2,
        textCapitalization: TextCapitalization.words,
        obscureText: true,
        decoration: InputDecoration(
          labelText: REPITA_SENHA,
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
        validator: (value) {
          if (value.isEmpty || value.length < 6) {
            return SENHA_MUITO_CURTA;
          }
          if (_newPassword != value) {
            return SENHA_NAO_SAO_IGUAIS;
          }
          return null;
        },
        controller: _controllerConfirmPassword,
      ),
    );
  }

  Widget showCircularProgress() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
      child: CircularProgressIndicator(),
    );
  }

  Widget salvarButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 16, 0, 12),
      child: PrimaryButton(
        text: SALVAR,
        onPressed: changePassword,
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

  void changePassword() {
    if (validateData()) {
      setState(() {
        _isLoading = true;
      });
      String email = SingletonUser.instance.email;
      presenter.changePassword(email, _currentPassword, _newPassword);
    }
  }

}