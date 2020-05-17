import '../../contract/login/forgot_password_contract.dart';
import '../../services/firebase/firebase_forgot_password_service.dart';

class ForgotPasswordPresenter extends ForgotPasswordContractPresenter {
  ForgotPasswordContractService repository = FirebaseForgotPasswordService();

  ForgotPasswordPresenter(ForgotPasswordContractView view) : super(view);

  @override
  sendEmail(String email) {
    view.showProgress();
    repository.sendEmail(email).then((result) {
      view.hideProgress();
      view.onSuccess("Email enviado com sucesso!");
    }).catchError((error) {
      view.hideProgress();
      view.onFailure(error.toString());
    });
  }

}