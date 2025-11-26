
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../generated/l10n.dart';
import '../presentation/user_mangment/welcome/welcome_page.dart';
import '../utils/color_helper.dart';

void showLoginSheet(BuildContext context) {
  Get.bottomSheet(
    Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.info_outline,
            size: 50,
            color: Colors.blue,
          ),
          SizedBox(height: 10),
          Text(
           S.of(context).login_required,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.offAll(WelcomeScreen());
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: ColorHelper.primaryColor,
            ),
            child: Text(
              S.of(context).login,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    ),
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
  );
}
