import '../../contract/login/create_account_contract.dart';
import '../../model/base_user.dart';
import '../../services/firebase/firebase_create_account_service.dart';

class CreateAccountPresenter extends CreateAccountContractPresenter {
  CreateAccountContractService service;

  CreateAccountPresenter(CreateAccountContractView view) : super(view) {
    this.service = FirebaseCreateAccountService(this);
  }

  @override
  dispose() {
    service.dispose();
    return super.dispose();
  }

  @override
  createAccount(BaseUser user) {
    view.showProgress();
    service.createAccount(user);
  }

  @override
  onFailure(String error) {
    view.hideProgress();
    view.onFailure(error.toString());
  }

  @override
  onSuccess(BaseUser user) {
    view.hideProgress();
    view.onSuccess(user);
  }

}