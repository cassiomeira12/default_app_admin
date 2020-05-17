import '../../contract/user/verified_sms_contract.dart';
import '../../services/firebase/firebase_verified_sms_service.dart';

class VerifiedSMSPresenter extends VerifiedSMSContractPresenter {
  VerifiedSMSContractService service;

  VerifiedSMSPresenter(VerifiedSMSContractView view) : super(view) {
    service = FirebaseVerifiedSMSService(this);
  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) {
    service.verifyPhoneNumber(phoneNumber);
  }

  @override
  Future<void> confirmSMSCode(String verificationId, String smsCode) {
    service.confirmSMSCode(verificationId, smsCode);
  }

  @override
  codeAutoRetrievalTimeout(String verificationId) {
    view.codeAutoRetrievalTimeout(verificationId);
  }

  @override
  codeSent(String verificationId) {
    view.codeSent(verificationId);
  }

  @override
  verificationCompleted() {
    view.verificationCompleted();
  }

  @override
  verificationFailed(String error) {
    view.verificationFailed(error);
  }

}