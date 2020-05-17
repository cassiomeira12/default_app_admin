import '../../contract/base_result_contract.dart';
import '../base_progress_contract.dart';

abstract class ForgotPasswordContractView implements BaseProgressContract, BaseResultContract<String> {

}

abstract class ForgotPasswordContractPresenter {
  ForgotPasswordContractView view;
  ForgotPasswordContractPresenter(this.view);

  dispose() {
    this.view = null;
  }

  sendEmail(String email);
}

abstract class ForgotPasswordContractService {
  Future<void> sendEmail(String email);
}