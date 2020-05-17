
abstract class VerifiedSMSContractView {

  verificationCompleted();
  verificationFailed(String error);
  codeAutoRetrievalTimeout(String verificationId);
  codeSent(String verificationId);

}

abstract class VerifiedSMSContractPresenter extends VerifiedSMSContractView {
  VerifiedSMSContractView view;
  VerifiedSMSContractPresenter(this.view);

  dispose() {
    this.view = null;
  }

  Future<void> verifyPhoneNumber(String phoneNumber);
  Future<void> confirmSMSCode(String verificationId, String smsCode);

}

abstract class VerifiedSMSContractService {
  VerifiedSMSContractPresenter presenter;
  VerifiedSMSContractService(this.presenter);

  dispose() {
    this.presenter = null;
  }

  Future<void> verifyPhoneNumber(String phoneNumber);
  Future<void> confirmSMSCode(String verificationId, String smsCode);
}