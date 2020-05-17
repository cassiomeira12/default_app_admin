import '../../contract/login/create_account_contract.dart';
import '../../model/base_user.dart';
import '../../services/firebase/firebase_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../strings.dart';
import '../../contract/crud.dart';

class FirebaseCreateAccountService extends CreateAccountContractService {
  FirebaseCreateAccountService(CreateAccountContractPresenter presenter) : super(presenter);

  @override
  Future<BaseUser> createAccount(BaseUser user) async {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: user.password).then((AuthResult authResult) async {
      user.emailVerified = authResult.user.isEmailVerified;
      Crud<BaseUser> crud = FirebaseUserService("users");
      BaseUser result = await crud.create(user);
      if (result == null) {
        presenter.onFailure(ERROR_CRIAR_USUARIO);
      } else {
        presenter.onSuccess(result);
      }
    }).catchError((error) {
      presenter.onFailure(error.toString());
    });
  }

}