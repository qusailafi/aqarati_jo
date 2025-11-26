

 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../generated/l10n.dart';
import '../presentation/user_mangment/welcome/welcome_page.dart';

Widget loginMessage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            Text(
        S.of(context).login_required,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
           Get.offAll(WelcomeScreen());
              },
              child:   Text(
                S.of(context).login,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );

}

