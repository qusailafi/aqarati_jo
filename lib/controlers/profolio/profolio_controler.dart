import 'dart:convert';

import 'package:get/get.dart';

import '../../data/remote/request_manger.dart';
import '../../domain/portfolio_response.dart';
import '../../utils/utils.dart';
import '../base_controler.dart';

class ProfolioControler extends BaseControler {
  NetWorkCalls netWorkCalls = NetWorkCalls();
  Rx<PortfolioResponse> porfolio = PortfolioResponse().obs;

  @override
  void onInit() {
    super.onInit();
    getProfolio();
  }

  Future<void> getProfolio() async {
    isLoading.value = true;
    try {
       var response;
         response = await netWorkCalls.getApi("Payouts/my-portfolio",
            await Utils.getCommonHeaderWithAuth(), null);
        if (response.data != null) {
          PortfolioResponse porfolioResponse =
              PortfolioResponse.fromJson(jsonDecode(response.data));
          porfolioResponse.data = porfolioResponse.data;
          porfolio.value = porfolioResponse;
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
