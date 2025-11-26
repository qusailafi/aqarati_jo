import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../data/remote/request_manger.dart';
import '../../domain/bacnk_account.dart';
import '../../domain/invesments_response.dart';
import '../../domain/walet/walet_response.dart' hide BankTransferInfo;
import '../../generated/l10n.dart';
import '../../presentation/dialogs/error_dialog.dart';
import '../../presentation/home/main_page.dart';
import '../../utils/utils.dart';
import '../../widgets/alert_dialog.dart';
import '../base_controler.dart';
import '../payment/payment_response.dart';

class InvensmentsControler extends BaseControler {
  NetWorkCalls netWorkCalls = NetWorkCalls();
  RxList<InvesmentsData> invesments = <InvesmentsData>[].obs;
RxList<BankTransferInfo>account=<BankTransferInfo>[].obs;
  @override
  void onInit() {
    super.onInit();
    getAllInvesments("");
  }
  Future<void> verifyPayment(BuildContext context,String properityId, String bankReferenceId) async {
    try {
      isLoading.value = true;
      if (bankReferenceId.isNotEmpty) {
        final request = {
          "investmentId": properityId,
          "bankReferenceId": bankReferenceId
        };
        final response = await netWorkCalls.postApi(
            "Investments/upload-bank-reference",
            await Utils.getCommonHeaderWithAuth(),


            request);
        PaymentReponse paymentReponse =
        PaymentReponse.fromJson(jsonDecode(response.data));

        if (!paymentReponse.success)
          showMyBottomSheet(context, paymentReponse.message ?? "");
        else {
          showonfirmDialog(
            context,
            paymentReponse.message ?? "",
            onConfirm: () => Get.to(MainView(
             )),
          );
        }


      }else{
        showMyBottomSheet(context, S.of(context).fill_all_filed);

       }
    } catch (e) {
      message.value=e.toString();
    } finally {
      isLoading.value=false;

    }
  }

  Future<void> getBankAccountsInfo(String invensmentId) async {
    try {
      isLoading.value = true;
      final response = await netWorkCalls.getApi(
          "Lookup/bank-accounts-for-investment/$invensmentId",
          await Utils.getCommonHeaderWithAuth(),
          null);

      if (response.data.isEmpty) {
        message.value = response.message;
      } else {
        final List<dynamic> decoded = jsonDecode(response.data);
        account.value =
        decoded.map((e) => BankTransferInfo.fromJson(e)).toList();
print('');

      }
    } catch (e) {
      message.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllInvesments(String condition) async {
    try {
      invesments.clear();
      isLoading.value = true;
      final response = await netWorkCalls.getApi(
          "Investments", await Utils.getCommonHeaderWithAuth(), null);

      if (response.data.isNotEmpty) {
        InvesmentResponse allPropertiesResponse =
            InvesmentResponse.fromJson(jsonDecode(response.data));
        invesments
            .addAll(allPropertiesResponse.data as Iterable<InvesmentsData>);
      } else {
        message.value = response.message ?? "";
      }
    } catch (e) {
      message.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
