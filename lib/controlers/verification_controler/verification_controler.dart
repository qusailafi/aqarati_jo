import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/remote/request_manger.dart';
import '../../domain/verification_reponse.dart';
import '../../presentation/dialogs/error_dialog.dart';
import '../../presentation/user_mangment/login/login_page.dart';
import '../../utils/utils.dart';
import '../../widgets/alert_dialog.dart';
import '../../generated/l10n.dart';
import '../base_controler.dart';

class VerificationControler extends BaseControler {
  NetWorkCalls netWorkCalls = NetWorkCalls();


  Future<void>resend(BuildContext context,String email)async{
    Map<String, String> body = {"email": email };
    try {
      isLoading.value=true;
      final response = await netWorkCalls.postApi(
          "Auth/verify-otp", await Utils.getCommonHeaderWithoUTAuth(), body);
    // VerificationResponse verificationResponse =
    // VerificationResponse.fromJson(jsonDecode(response.data));
showMyBottomSheet(context, "Please check your email "+email);
    } catch (e) {
    message.value = e.toString();
    } finally {
    isLoading.value = false;
    }

  }
  Future<void> verificationCode(BuildContext context,String email, String code) async {
    Map<String, String> body = {"email": email, "otpCode": code};
    if(code.isEmpty) {
      showMyBottomSheet(context, S
          .of(context)
          .fill_all_filed);
      return;
    }
    try {
      isLoading.value=true;
      final response = await netWorkCalls.postApi(
          "Auth/verify-otp", await Utils.getCommonHeaderWithoUTAuth(), body);
      VerificationResponse verificationResponse =
          VerificationResponse.fromJson(jsonDecode(response.data));
      if (verificationResponse.message != "") {
        Get.to(LoginPage());
      }else{
        showBeautifulDialog(
          context,
          message.value,
          onConfirm: () => null,
        );
      }
    } catch (e) {
      message.value = e.toString();
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
