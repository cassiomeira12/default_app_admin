import 'package:flutter/material.dart';
import '../../view/widgets/background_card.dart';

class SearchPage extends StatefulWidget {

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            BackgroundCard(height: 100,),
            SingleChildScrollView(
              child: _showForm(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showForm() {
    return Container(
      padding: EdgeInsets.all(12),
      child: Form(
        //key: _formKey,
        child: Column(
          children: <Widget>[
            search(),
            //showEmailInput(),
            //textTitle(),
            //emailInput(),
            //textMensagem(),
            //_isLoading ? showCircularProgress() : sendButton()
          ],
        ),
      ),
    );
  }

  Widget search() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: RaisedButton(
          elevation: 5.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
          disabledColor: Colors.white,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              IconButton(
                padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                icon: Icon(Icons.arrow_back),
                onPressed:() => Navigator.pop(context, false),
                color: Colors.grey,
                hoverColor: Colors.red,
              ),
              //Icon(Icons.arrow_back, color: Colors.grey,),
              showEmailInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: TextFormField(
        textAlign: TextAlign.left,
        maxLines: 1,
        keyboardType: TextInputType.text,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black45,
        ),
        autofocus: true,
        decoration: InputDecoration(
          //labelText: "EMAIL",
          //labelStyle: Theme.of(context).textTheme.body2,
          //hintText: "",
          hintStyle: Theme.of(context).textTheme.body2,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        //validator: (value) => value.isEmpty ? EMAIL_INVALIDO : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }
}
