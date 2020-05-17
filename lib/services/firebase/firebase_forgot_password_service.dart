import '../../contract/login/forgot_password_contract.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseForgotPasswordService extends ForgotPasswordContractService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> sendEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

}