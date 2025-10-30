import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_cafe_p6/ViewModel/user_profile_model.dart';

class RoundCircleViewModel extends ChangeNotifier {
  String? _profileImage;
  final UserRepository _userRepo = UserRepository();

  String? get profileImage => _profileImage;
  bool get hasImage => _profileImage != null;

  Future<void> loadProfileImage() async {
    final user = await _userRepo.getUserFromFirestore();
    if (user?.profileImage != null) {
      _profileImage = user!.profileImage;
      notifyListeners();
    }
  }

  Future<void> pickAndSaveImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return;

    final file = File(pickedFile.path);
    final bytes = await file.readAsBytes();
    final base64Image = base64Encode(bytes);

    await _userRepo.updateProfileImage(base64Image);
    _profileImage = base64Image;
    notifyListeners();
  }
}
