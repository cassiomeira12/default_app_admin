import '../../contract/user/user_contract.dart';
import '../../model/base_user.dart';
import '../../model/singleton/singleton_user.dart';
import '../../presenter/user/user_presenter.dart';
import '../../strings.dart';
import '../../view/widgets/background_card.dart';
import '../../view/widgets/primary_button.dart';
import '../../view/widgets/scaffold_snackbar.dart';
import '../../view/widgets/shape_round.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../image_view_page.dart';
import '../page_router.dart';
import 'change_password_page.dart';
import 'phone_number_page.dart';
import 'user_name_page.dart';

class UserPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _UserState();
}

class _UserState extends State<UserPage> implements UserContractView {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String userName, userEmail, userPhoneNumber , userPhoto;

  bool loading = false;
  UserContractPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = UserPresenter(this);
    if (SingletonUser.instance != null) {
      userName = SingletonUser.instance.name;
      userEmail = SingletonUser.instance.email;
      userPhoneNumber = SingletonUser.instance.phoneNumber == null ? NUMERO_CELULAR : SingletonUser.instance.phoneNumber.toString();
      userPhoto = SingletonUser.instance.avatarURL;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(PERFIL, style: TextStyle(color: Colors.white),),
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
      loading = false;
    });
    ScaffoldSnackBar.failure(context, _scaffoldKey, error);
  }

  @override
  onSuccess(BaseUser user) async {
    setState(() {
      userPhoto = SingletonUser.instance.avatarURL;
      loading = false;
    });
    ScaffoldSnackBar.success(context, _scaffoldKey, FOTO_ALTERADA);
  }

  Widget _showForm() {
    return  Container(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 16),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            user(),
            txtChangePhoto(),
            nameUser(),
            emailUser(),
            phoneNumberUser(),
            changePasswordButton(),
          ],
        ),
      ),
    );
  }

  Widget user() {
    return Container(
      width: 180,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          imgUser(),
          Align(
            alignment: Alignment.bottomRight,
            child: RawMaterialButton(
              child: Icon(Icons.camera_alt, color: Colors.white,),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: Theme.of(context).primaryColorDark,
              padding: const EdgeInsets.all(10),
              onPressed: () {
                changeImgUser();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget imgUser() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Center(
        child: Hero(
          tag: 'imgUser',
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ClipOval(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  defaultImageUser(),
                  userPhoto == null ? Container() : imageUserURL(),
                  loading ? showLoadingProgress() : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showLoadingProgress() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: CircularProgressIndicator(),
    );
  }

  Widget defaultImageUser() {
    return Container(
      width: 160,
      height: 160,
      child: Image.asset("assets/user_default_img_white.png"),
    );
  }

  Widget imageUserURL() {
    return Container(
      width: 160,
      height: 160,
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(userPhoto),
            ),
          ),
        ),
        onTap: () {
          PageRouter.push(context, ImageViewPage(imgURL: userPhoto,));
        },
      ),
    );
  }

//  Widget imageUserFile() {
//    return Container(
//      height: 160,
//      width: 160,
//      decoration: BoxDecoration(
//        image: DecorationImage(
//          image: FileImage(pickedImage),
//          fit: BoxFit.cover,
//        ),
//      ),
//    );
//  }
//
//  Widget loadImage2() {
//    return (userPhoto == null || userPhoto.isEmpty) ?
//      pickedImage == null ?
//        defaultImageUser()
//          :
//        imageUserFile()
//        :
//      imageUserURL();
//  }

//  Widget loadImage() {
//    return (userPhoto == null || userPhoto.isEmpty) ?
//    CircleAvatar(
//      backgroundColor: Colors.transparent,
//      radius: 80,
//      child:
//      pickedImage == null ? Image.asset("assets/user_default_img_white.png")
//          :
//      Container(
//        //height: 160.0,
//        //width: 160.0,
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            image: FileImage(pickedImage),
//            fit: BoxFit.cover,
//          ),
//        ),
//      ),
//
//    )
//        :
//    Image.network(userPhoto,fit: BoxFit.cover, width: 150,
//      loadingBuilder:(BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
//        if (loadingProgress == null) return child;
//        return Center(
//          child: CircularProgressIndicator(
//            value: loadingProgress.expectedTotalBytes != null ?
//            loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
//                : null,
//          ),
//        );
//      },
//    );
//  }

  Widget txtChangePhoto() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Center(
        child: Text(
          TROCAR_FOTO,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.body2,
        ),
      ),
    );
  }

  Widget nameUser() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.5, 0.0, 0.0),
      child: SizedBox(
        //width: double.infinity,
        height: 55,
        child: RaisedButton(
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            //side: BorderSide(color: Colors.black12),
          ),
          color: Theme.of(context).backgroundColor,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  userName,
                  style: Theme.of(context).textTheme.body2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                child: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color,),
              ),
            ],
          ),
          onPressed: () {
            PageRouter.push(context, UserNamePage());
          },
        ),
      ),
    );
  }

  Widget emailUser() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.5, 0.0, 0.0),
      child: SizedBox(
        //width: double.infinity,
        height: 55,
        child: RaisedButton(
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            //side: BorderSide(color: Colors.black12),
          ),
          color: Theme.of(context).backgroundColor,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  userEmail,
                  style: Theme.of(context).textTheme.body2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                child: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color,),
              ),
            ],
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget phoneNumberUser() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.5, 0.0, 0.0),
      child: SizedBox(
        //width: double.infinity,
        height: 55,
        child: RaisedButton(
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            //side: BorderSide(color: Colors.black12),
          ),
          color: Theme.of(context).backgroundColor,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  userPhoneNumber,
                  style: Theme.of(context).textTheme.body2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                child: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color,),
              ),
            ],
          ),
          onPressed: () {
            PageRouter.push(context, PhoneNumberPage());
          },
        ),
      ),
    );
  }

  Widget changePasswordButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 16.0, 12, 0.0),
      child: PrimaryButton(
        text: ALTERAR_SENHA,
        onPressed: () {
          PageRouter.push(context, ChangePasswordPage());
        },
      ),
    );
  }

  void changeImgUser() async {
    final imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (context) =>
        AlertDialog(
          title: Text(SELECIONE_IMAGEM),
          actions: <Widget>[
            MaterialButton(
              child: Text(CAMERA),
              onPressed: () => Navigator.pop(context, ImageSource.camera),
            ),
            MaterialButton(
              child: Text(GALERIA),
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
            )
          ],
        )
    );

    if(imageSource != null) {
      final file = await ImagePicker.pickImage(source: imageSource);
      if (file != null) {
        presenter.changeUserPhoto(file);
        setState(() {
          loading = true;
        });
      }
    }
  }

}