import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/local/cache_data.dart';
import '../../data/remote/request_manger.dart';
import '../../domain/login/login_response.dart';
import '../../generated/l10n.dart';
import '../../presentation/dialogs/error_dialog.dart';
import '../../presentation/home/main_page.dart';
import '../../utils/utils.dart';
import '../base_controler.dart';
import '../language/language_controler.dart';

class LoginControler extends BaseControler {
  NetWorkCalls netWorkCalls = NetWorkCalls();
  CacheControler cacheControler=Get.find();

  validate(String userName, String password,BuildContext context) {
    if (userName.isNotEmpty && password.isNotEmpty) {
      login(context,userName, password);
    } else {
      showMyBottomSheet(context, S.of(context).fill_all_filed);
    }
  }

  Future<void> login(BuildContext context,String userName, String pasword) async {
    try {
      isLoading.value = true;
      Map<String, String> body = {"identifier": userName, "password": pasword};
      final response = await netWorkCalls.postApi(
          "Auth/login", await Utils.getCommonHeaderWithoUTAuth(), body);

      if (response.data.isNotEmpty) {
        LoginResponse loginResponse =
        LoginResponse.fromJson(jsonDecode(response.data));
        await CacheDataManager.putBooleanData(Utils.IS_LOGIN, true);
        await CacheDataManager.putStringData(Utils.TOKEN, loginResponse.token!??"");
        cacheControler.isLogin.value=true;
        Get.to(MainView());
      } else {
        message.value = response.message ?? "";
        // showMyBottomSheet(context,message.value);

      }
    } catch (e) {
      message.value = e.toString();
      showMyBottomSheet(context,message.value);

    } finally {
      isLoading.value = false;
    }
  }
}
