import '../../contract/login/login_contract.dart';
import '../../model/base_user.dart';
import '../../services/firebase/firebase_login_service.dart';

class LoginPresenter extends LoginContractPresenter {
  LoginContractService service;

  LoginPresenter(LoginContractView view) : super(view) {
    this.service = FirebaseLoginService(this);
  }

  @override
  signIn(String email, String password) {
    view.showProgress();
    service.signIn(email, password);
  }

  @override
  signInWithGoogle() {
    view.showProgress();
    service.signInWithGoogle();
  }

  @override
  onFailure(String error) {
    view.hideProgress();
    view.onFailure(error);
  }

  @override
  onSuccess(BaseUser user) {
    view.hideProgress();
    view.onSuccess(user);
  }

}