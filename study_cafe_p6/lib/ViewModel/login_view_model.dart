import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:study_cafe_p6/Screen/login/login_screen.dart';

class LoginViewModel {
  void signOut() {
    FirebaseAuth.instance.signOut();
    Get.offAll(() => LoginScreen());
  }
}
