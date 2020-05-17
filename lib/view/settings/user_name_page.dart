import '../../contract/user/user_contract.dart';
import '../../model/base_user.dart';
import '../../model/singleton/singleton_user.dart';
import '../../presenter/user/user_presenter.dart';
import '../../view/widgets/scaffold_snackbar.dart';
import 'package:flutter/material.dart';
import '../../strings.dart';
import '../../view/widgets/background_card.dart';
import '../../view/widgets/primary_button.dart';
import '../../view/widgets/shape_round.dart';

import '../page_router.dart';

class UserNamePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserNamePageState();
}

class _UserNamePageState extends State<UserNamePage> implements UserContractView {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _userName;
  bool _loading = false;

  UserContractPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = UserPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar( iconTheme: IconThemeData(color: Colors.white), elevation: 0,),
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
    setState(() {
      _loading = false;
    });
    ScaffoldSnackBar.failure(context, _scaffoldKey, error);
  }

  @override
  onSuccess(BaseUser user) async {
    setState(() {
      _loading = false;
    });
    SingletonUser.instance.update(user);
    ScaffoldSnackBar.success(context, _scaffoldKey, CHANGE_NAME_SUCCESS);
    await Future.delayed(const Duration(seconds: 2));
    PageRouter.pop(context);
  }

  Widget bodyAppScrollView() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: ShapeRound(_showForm(context)),
          ),
        ],
      ),
    );
  }

  Widget _showForm(context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            textTitle(),
            //textMessage(),
            nameInput(),
            _loading ? showLoadingProgress() : salvarButton(),
          ],
        ),
      ),
    );
  }

  Widget showLoadingProgress() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
      child: CircularProgressIndicator(),
    );
  }

  Widget textTitle() {
    return Center(
      child: Text(
        CHANGE_NAME,
        style: Theme.of(context).textTheme.subtitle,
      ),
    );
  }

  Widget textMessage() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
      child: Center(
        child: Text(
          DIGITE_NOME,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.body2,
        ),
      ),
    );
  }

  Widget nameInput () {
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
          labelText: NAME,
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
        //controller: controller,
        validator: (value) => value.isEmpty ? DIGITE_NOME : null,
        onSaved: (value) => _userName = value.trim(),
      ),
    );
  }

  Widget salvarButton() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
        child: PrimaryButton(
            text: SALVAR,
            onPressed: validateAndSubmit
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

  void validateAndSubmit() {
    if (validateAndSave()) {
      setState(() {
        _loading = true;
      });
      FocusScope.of(context).requestFocus(FocusNode()); //Fecha teclado
      presenter.changeName(_userName);
    }
  }

}