import 'dart:convert';


import 'package:get/get.dart';

import '../../data/remote/request_manger.dart';
import '../../domain/walet/walet_response.dart';
import '../../utils/utils.dart';
import '../base_controler.dart';

class WaletControler extends BaseControler {
  NetWorkCalls netWorkCalls = NetWorkCalls();
  RxList<WaletData>data=<WaletData>[].obs;
  @override
  void onInit() {
     super.onInit();
     isLoading.value=false;
     data.value=[];
     getMyWalet();
  }
  Future<void> getMyWalet() async {
    isLoading.value = true;
    data.clear();
    try {
      final response = await netWorkCalls.getApi(
          "Investments", await Utils.getCommonHeaderWithAuth(), null);
      if (response.data.isNotEmpty) {
        WaletResponse waletResponse=WaletResponse.fromJson(jsonDecode(response.data));
        data.value.addAll(waletResponse.data);

      } else {
        message.value = response.message;
      }
    } catch (e) {
      message.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
