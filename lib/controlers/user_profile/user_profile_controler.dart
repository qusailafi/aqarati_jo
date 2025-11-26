import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/local/cache_data.dart';
import '../../data/remote/request_manger.dart';
import '../../domain/user_profile/user_response.dart';
import '../../presentation/splash/splash_screen.dart';
import '../../widgets/alert_dialog.dart';
import '../../domain/verification_reponse.dart';
import '../../generated/l10n.dart';
import '../../presentation/dialogs/error_dialog.dart';
import '../../utils/utils.dart';
import '../base_controler.dart';

class UserProfileControler extends BaseControler {
  NetWorkCalls netWorkCalls = NetWorkCalls();

  Rx<UserProfileResponse> profile = UserProfileResponse().obs;

  @override
  void onInit() {
    super.onInit();
    getUserProfile();
  }

  Future<void> getUserProfile() async {
    isLoading.value = true;
    try {
      final response = await netWorkCalls.getApi(
          "Auth/profile", await Utils.getCommonHeaderWithAuth(), null);

      if (response.data.isNotEmpty)
        profile.value = UserProfileResponse.fromJson(jsonDecode(response.data));
      else
        message.value = response.message;
    } catch (e) {
      message.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changePass(
    BuildContext context,
    String oldPass,
    String newPass,
  ) async {
    try {
      isLoading.value = true;
      Map<String, String> body = {
        "CurrentPassword": oldPass,
        "NewPassword": newPass
      };
      final response = await netWorkCalls.postApi(
          "Auth/change-password", await Utils.getCommonHeaderWithAuth(), body);
      VerificationResponse verificationResponse =
          VerificationResponse.fromJson(jsonDecode(response.data));
      showBeautifulDialog(
        context,
        verificationResponse.message ?? "",
        onConfirm: () => null,
      );
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

  Future<void> deleteAccount() async {
    try {
      isLoading.value = true;
      final response = await netWorkCalls.postApi("Auth/deactivate-account",
          await Utils.getCommonHeaderWithAuth(), null);
      if (response.data.isNotEmpty) {

        await Utils.clearSharedPrefs();
        await CacheDataManager.putBooleanData(Utils.IS_LOGIN, false);
        Get.offAll(() => SplashPage());

      }
    } catch (e) {
      await Utils.clearSharedPrefs();
      await CacheDataManager.putBooleanData(Utils.IS_LOGIN, false);
      Get.offAll(() => SplashPage());
    } finally {
      isLoading.value=false;
    }
  }

  validateChange(BuildContext context, String currentPass, String newPass) {
    if (currentPass.isEmpty || newPass.isEmpty) {
      showMyBottomSheet(context, S.of(context).fill_all_filed);
    } else {
      changePass(context, currentPass, newPass);
    }
  }
}
