import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
 import '../../../../data/local/cache_data.dart';
import '../../../../utils/utils.dart';
 import '../../presentation/home/main_page.dart';
import '../../presentation/user_mangment/welcome/welcome_page.dart';
import '../base_controler.dart';

class CacheControler extends BaseControler {
  RxString local = "en".obs;

  RxBool isLogin = false.obs;
  RxString countryCode = "".obs;

  isLogined() async {
    isLogin.value = await CacheDataManager.getBoolean(Utils.IS_LOGIN);
    Timer(Duration(seconds: 8), () async {
         // Get.offAll(HomePage());

        // Get.off(HomePage());
      Get.offAll(MainView());


    });
  }

  Future<Locale> loadLang() async {
    local.value = await CacheDataManager.getStringData(Utils.LANGUAGE);
    Utils.language = local.value;
    if (local.value.isNull || local.value.isEmpty) {
      local.value = "en";
      Utils.language = "en";
    }
    return Locale(local.value);
  }

  Future<void> setLang(BuildContext context) async {
    if (local.value == "en")
      await CacheDataManager.putStringData(Utils.LANGUAGE, "ar");
    else
      await CacheDataManager.putStringData(Utils.LANGUAGE, "en");

    local.value = await CacheDataManager.getStringData(Utils.LANGUAGE);

    Utils.changeLanguage(context, Locale(local.value));
  }
}
