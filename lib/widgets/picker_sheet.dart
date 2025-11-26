 import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controlers/create_account/create_account_controler.dart';
import '../generated/l10n.dart';

class ImageChooserSheet extends StatelessWidget {
  const ImageChooserSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateAccountControler createAccountControler = Get.find();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // center evenly
        children: [
          // Gallery
          InkWell(
            onTap: () {
              createAccountControler.pickFromGallery();
              Get.back(); // close bottom sheet
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:   [
                Icon(Icons.photo_library, size: 60, color: Colors.blue),
                SizedBox(height: 8),
                Text(S.of(Get.context!).gallery, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),

          // Camera
          InkWell(
            onTap: () {
              createAccountControler.pickImageFromCamera();
              Get.back(); // close bottom sheet
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:   [
                Icon(Icons.camera_alt, size: 60, color: Colors.green),
                SizedBox(height: 8),
                Text(S.of(Get.context!).camera, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
