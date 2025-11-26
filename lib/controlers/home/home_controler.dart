import 'dart:convert';


import 'package:get/get.dart';

import '../../data/remote/request_manger.dart';
import '../../domain/categories.dart';
import '../../domain/preoperites/properites_response.dart';
import '../../generated/l10n.dart';
import '../../utils/utils.dart';
import '../base_controler.dart';
import '../profolio/profolio_controler.dart';

class HomeController extends BaseControler {
  var currentIndex = 0.obs;
  NetWorkCalls netWorkCalls = NetWorkCalls();
  RxList<ProperitesData> data = <ProperitesData>[].obs;
  RxList<ProperitesData> funded = <ProperitesData>[].obs;
  RxString title =  ''.obs;
  RxList<DataCategories> categories = <DataCategories>[].obs;
  RxString selectedCategory =  "".obs;

  @override
  void onInit() {
    super.onInit();
    title.value = S.of(Get.context!).properites;

    getAllProperites("");
    getFundedProperites("");
    getCategories();
    // getAllInvesments("");
  }

  Future<void> getCategories() async {
    try {
      // data.clear();

      isLoading.value = true;
      final response = await netWorkCalls.getApi("Lookup/property-type",
          await Utils.getCommonHeaderWithoUTAuth(), null);

      if (response.data.isNotEmpty) {
        CategoriesResponse allPropertiesResponse =
            CategoriesResponse.fromJson(jsonDecode(response.data));
        categories
            .addAll(allPropertiesResponse.data as Iterable<DataCategories>);
      } else {
        message.value = response.message ?? "";
      }
    } catch (e) {
      message.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllProperites(String condition) async {
    try {
      // data.clear();
      var param = null;
      if (condition.isNotEmpty) {
        param = {"conditionId": condition};
      }
      isLoading.value = true;
      final response = await netWorkCalls.getApi("Properties/AllProperties",
          await Utils.getCommonHeaderWithoUTAuth(), param);

      if (response.data.isNotEmpty) {
        AllPropertiesResponse allPropertiesResponse =
            AllPropertiesResponse.fromJson(jsonDecode(response.data));
        data.addAll(allPropertiesResponse.data as Iterable<ProperitesData>);
      } else {
        message.value = response.message ?? "";
      }
    } catch (e) {
      message.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getFundedProperites(String condition) async {
    try {
      // data.clear();
      var param = null;
      if (condition.isNotEmpty) {
        param = {"conditionId": condition};
      }
      isLoading.value = true;
      final response = await netWorkCalls.getApi("Properties/ClosedFullySold",
          await Utils.getCommonHeaderWithoUTAuth(), param);

      if (response.data.isNotEmpty) {
        AllPropertiesResponse allPropertiesResponse =
            AllPropertiesResponse.fromJson(jsonDecode(response.data));
        funded.addAll(allPropertiesResponse.data as Iterable<ProperitesData>);
      } else {
        message.value = response.message ?? "";
      }
    } catch (e) {
      message.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        title.value = S.of(Get.context!).properites;

        break;
      case 1:
        title.value = S.of(Get.context!).dashboard;

        break;
      case 2:
        title.value = S.of(Get.context!).walet;

        break;
      case 3:
        title.value = S.of(Get.context!).properites;

        break;
    }
  }
}
