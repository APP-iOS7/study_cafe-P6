import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:study_cafe_p6/Screen/login/login_screen.dart';
import 'package:study_cafe_p6/Screen/tabbar_screen.dart';
import 'package:study_cafe_p6/ViewModel/auth_view_model.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao_sdk;

void kakaoLogin() async {
  final authViewModel = Get.put(AuthViewModel());

  if (await isKakaoTalkInstalled()) {
    try {
      kakao_sdk.OAuthToken _ = await UserApi.instance.loginWithKakaoTalk();
      kakao_sdk.User kakaoUser = await UserApi.instance.me();
      print('카카오톡으로 로그인 성공');

      await authViewModel.saveKakaoUserToFirestore(kakaoUser);
      Get.offAll(() => BottomTabBar());
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
      Get.offAll(() => LoginScreen());

      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
    }
  } else {
    try {
      var provider = firebase_auth.OAuthProvider('oidc.studycafe-p6');
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      var credential = provider.credential(
        idToken: token.idToken,
        accessToken: token.accessToken,
      );
      await firebase_auth.FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      User kakaoUser = await UserApi.instance.me();
      print('파이어베이스 카카오계정으로 로그인 성공');

      await authViewModel.saveKakaoUserToFirestore(kakaoUser);
      Get.offAll(() => BottomTabBar());
    } catch (error) {
      print('파이어베이스 카카오계정으로 로그인 실패 $error');
    }
  }
}
