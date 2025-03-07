import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel {
  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
