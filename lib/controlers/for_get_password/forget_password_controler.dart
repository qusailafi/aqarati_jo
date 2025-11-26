import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/remote/request_manger.dart';
import '../../domain/verification_reponse.dart';
import '../../generated/l10n.dart';
import '../../presentation/dialogs/error_dialog.dart';
import '../../presentation/user_mangment/forget_password/reset_password.dart';
import '../../presentation/user_mangment/login/login_page.dart';
import '../../utils/utils.dart';
import '../../widgets/alert_dialog.dart';
import '../base_controler.dart';

class ForgetPasswordControler extends BaseControler {
  NetWorkCalls netWorkCalls = NetWorkCalls();

  validate(BuildContext context, String email) {
    if (email.isEmpty) {
      showMyBottomSheet(context, S.of(context).email_required);
    } else {
      foegetPassword(context, email);
    }
  }
  validateReset(BuildContext context, String email,String otp) {
    if (email.isEmpty) {
      showMyBottomSheet(context, S.of(context).fill_all_filed);
    } else {
      rersetPassword(context, email,  otp);
    }
  }
  Future<void> foegetPassword(BuildContext context, String email) async {
    try {
      isLoading.value = true;
      final body = {"email": email};
      final response = await netWorkCalls.postApi("Auth/forgot-password",
          await Utils.getCommonHeaderWithoUTAuth(), body);
      VerificationResponse verificationResponse =
          VerificationResponse.fromJson(jsonDecode(response.data));

      Get.to(ResetPasswordScreen());
     } catch (e) {
      message.value=e.toString();
      showBeautifulDialog(
        context,
        message.value,
        onConfirm: () => null,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> rersetPassword(BuildContext context, String email,
      String OtpCode) async {
    try {
      isLoading.value = true;
      final body = {"email": email, "OtpCode": OtpCode};
      final response = await netWorkCalls.postApi("Auth/reset-password",
          await Utils.getCommonHeaderWithoUTAuth(), body);
      VerificationResponse verificationResponse =
          VerificationResponse.fromJson(jsonDecode(response.data));
       showBeautifulDialog(
        context,
        verificationResponse.message ?? "",
        onConfirm: () => Get.to(() => LoginPage()),
      );
    } catch (e) {
      message.value=e.toString();
      showBeautifulDialog(
        context,
   message.value,
        onConfirm: () => null,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
