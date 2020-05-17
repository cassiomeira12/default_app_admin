import '../../model/base_user.dart';
import '../base_progress_contract.dart';
import '../base_result_contract.dart';

abstract class CreateAccountContractView implements BaseProgressContract, BaseResultContract<BaseUser> {

}

abstract class CreateAccountContractPresenter {
  CreateAccountContractView view;
  CreateAccountContractPresenter(this.view);

  dispose() {
    this.view = null;
  }

  Future<BaseUser> createAccount(BaseUser user);

  onFailure(String error);
  onSuccess(BaseUser user);
}

abstract class CreateAccountContractService {
  CreateAccountContractPresenter presenter;
  CreateAccountContractService(this.presenter);

  dispose() {
    this.presenter = null;
  }

  Future<BaseUser> createAccount(BaseUser user);
}