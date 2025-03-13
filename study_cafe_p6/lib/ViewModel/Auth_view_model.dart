import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get/get.dart';
import 'package:study_cafe_p6/model/user_model.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao_sdk;
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthViewModel extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;

  Future<void> saveKakaoUserToFirestore(kakao_sdk.User kakaoUser) async {
    try {
      final uid = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        throw Exception('FirebaseAuth UID를 가져올 수 없습니다.');
      }
      print('Kakao User ID: $uid');
      print(
        'Kakao User NickName: ${kakaoUser.kakaoAccount?.profile?.nickname}',
      );
      UserModel userModel = UserModel(
        username: kakaoUser.kakaoAccount?.profile?.nickname ?? '카카오 사용자',
        useremail: '',
        uid: uid,
        profileImage: '',
      );
      await _firestore
          .collection('users')
          .doc(userModel.uid)
          .set(userModel.toJson(), SetOptions(merge: true));
    } catch (e) {
      print('Error saving Kakao user to Firestore: $e');
    }
  }

  Future<String> getUserName() async {
    final user = firebase_auth.FirebaseAuth.instance.currentUser;
    if (user == null) return '정보없음';
    
    try {
      // Check if this user exists in Firestore (Kakao login users are stored in Firestore)
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      
      if (userDoc.exists) {
        // User exists in Firestore, likely a Kakao login user
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        return userData['username'] ?? user.displayName ?? '정보없음';
      } else {
        // User doesn't exist in Firestore, likely a Firebase login user
        return user.displayName ?? '정보없음';
      }
    } catch (e) {
      print('Error fetching user data: $e');
      // Fallback to Firebase displayName in case of error
      return user.displayName ?? '정보없음';
    }
  }
}

