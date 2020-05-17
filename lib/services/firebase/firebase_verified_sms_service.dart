import 'package:firebase_auth/firebase_auth.dart';
import '../../contract/user/verified_sms_contract.dart';

class FirebaseVerifiedSMSService extends VerifiedSMSContractService {
  FirebaseVerifiedSMSService(VerifiedSMSContractPresenter presenter) : super(presenter);

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    print(phoneNumber);
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 5),

        verificationCompleted: (credential) async {
          FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
          await currentUser.updatePhoneNumberCredential(credential).then((value) {
            presenter.verificationCompleted();
          }).catchError((error) {
            presenter.verificationFailed(error.message);
          });
        },

        verificationFailed: (authException) {
          presenter.verificationFailed(authException.message);
        },

        codeAutoRetrievalTimeout: (verificationId) {
          presenter.codeAutoRetrievalTimeout(verificationId);
        },

        codeSent: (verificationId, [code]) {
          presenter.codeSent(verificationId);
        }
    );
  }

  @override
  Future<void> confirmSMSCode(String verificationId, String smsCode) async {
    var credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: smsCode);
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    print(currentUser.phoneNumber);
    await currentUser.updatePhoneNumberCredential(credential).then((value) {
      print(currentUser.phoneNumber);
      presenter.verificationCompleted();
    }).catchError((error) {
      presenter.verificationFailed(error.message);
    });
  }

}