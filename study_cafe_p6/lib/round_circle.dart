import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_cafe_p6/ViewModel/round_circle_view_model.dart';

class RoundCircle extends StatefulWidget {
  final double size;
  const RoundCircle({super.key, required this.size});

  @override
  _RoundCircleState createState() => _RoundCircleState();
}

class _RoundCircleState extends State<RoundCircle> {
  @override
  void initState() {
    super.initState();
    // ViewModel 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RoundCircleViewModel>().loadProfileImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RoundCircleViewModel>(
      builder: (context, viewModel, child) {
        return GestureDetector(
          onTap: viewModel.pickAndSaveImage,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
              border: Border.all(
                color: const Color.fromARGB(255, 217, 216, 216),
                width: 2,
              ),
              image:
                  viewModel.hasImage
                      ? DecorationImage(
                        image: MemoryImage(
                          base64Decode(viewModel.profileImage!),
                        ),
                        fit: BoxFit.cover,
                      )
                      : null,
            ),
            child:
                !viewModel.hasImage
                    ? Icon(Icons.camera_alt, size: 40, color: Colors.black54)
                    : null,
          ),
        );
      },
    );
  }
}
