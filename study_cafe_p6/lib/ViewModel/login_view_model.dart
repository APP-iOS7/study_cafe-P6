import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_cafe_p6/model/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  String? _errorMessage;
  bool _isSignUpSuccess = false;
  User? _currentUser;

  // 게터
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSignUpSuccess => _isSignUpSuccess;
  User? get currentUser => _currentUser;

  // 로딩 상태 설정
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // 에러 메시지 설정
  void setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void setSignUpSuccess(bool success) {
    _isSignUpSuccess = success;
    notifyListeners();
  }

  // 회원가입 함수
  Future<bool> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    setLoading(true);
    setErrorMessage(null);
    try {
      // Firebase Auth 회원가입
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // 사용자 이름 업데이트
      await userCredential.user?.updateDisplayName(username.trim());
      await userCredential.user?.reload();

      // 현재 사용자 정보 업데이트
      _currentUser = FirebaseAuth.instance.currentUser;

      // UserModel 생성
      UserModel user = UserModel(
        username: username,
        useremail: email,
        uid: userCredential.user!.uid,
        profileImage: '',
      );

      // Firestore에 사용자 정보 저장
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': user.username,
        'email': user.useremail,
        'uid': user.uid,
        'profileImage': user.profileImage,
        'createdAt': FieldValue.serverTimestamp(),
      });

      setSignUpSuccess(true);
      setLoading(false);
      return true;
    } catch (e) {
      debugPrint('회원가입 오류: $e');
      setErrorMessage('회원가입 실패: ${e.toString()}');
      setLoading(false);
      return false;
    }
  }

  // 로그인 처리
  Future<bool> signIn(String email, String password) async {
    setLoading(true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = '사용자를 찾을수 없습니다.';
          break;
        case 'wrong-password':
          message = '잘못된 비밀번호 입니다.';
          break;
        default:
          message = '로그인 실패: ${e.message.toString()}';
      }
      setErrorMessage(message);
      setLoading(false);
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _currentUser = null;
    notifyListeners();
  }
}
