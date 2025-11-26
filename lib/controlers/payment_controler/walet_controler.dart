import 'dart:convert';
import 'dart:ffi';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../data/remote/request_manger.dart';
import '../../domain/block_response.dart';
import '../../domain/invesments_response.dart';
import '../../domain/preoperites/properites_response.dart';
import '../../generated/l10n.dart';
import '../../presentation/dialogs/error_dialog.dart';
import '../../presentation/home/main_page.dart';
import '../../presentation/walet/bank_info.dart';
import '../../utils/utils.dart';
import '../../widgets/alert_dialog.dart';
import '../base_controler.dart';
import '../payment/payment_response.dart';

class PaymentControler extends BaseControler {
  NetWorkCalls netWorkCalls = NetWorkCalls();
  RxList<Data> data = <Data>[].obs;
  RxString shareNum = "".obs;

  RxString bricks = "".obs;
  RxString price = "".obs;
  RxString itemSelected = ''.obs;
  RxString shareLable = "".obs;
RxString briksSelectedTitle="".obs;
  RxInt paymenthMethod = 0.obs;

  Future<void> verifyPayment(
      BuildContext context, String properityId, String bankReferenceId) async {
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
            onConfirm: () => Get.to(MainView()),
          );
        }
      } else {
        showMyBottomSheet(context, S.of(context).fill_all_filed);
      }
    } catch (e) {
      message.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getBriks(String id) async {
    isLoading.value = true;

    final response = await netWorkCalls.getApi(
        "Lookup/PropertyBricksOptions/$id",
        await Utils.getCommonHeaderWithAuth(),
        null);
try{
  if (response.data.isNotEmpty) {
    BlocksResponse blocksResponse =
    BlocksResponse.fromJson(jsonDecode(response.data));
    data.addAll(blocksResponse.data as Iterable<Data>);
    briksSelectedTitle.value=data[0].totalPrice.toString()+S.of(Get.context!).aed;
    shareNum.value = data[0].shares.toString();
    price.value = data[0].totalPrice!.toString();
    bricks.value=data[0].bricks.toString();
    isLoading.value = false;
  } else {
    message.value = response.message;
  }
}catch(e){
  message.value=e.toString();
}finally{
  isLoading.value=false;
}
  }

  bool validate() {
    if (shareNum.value.isNotEmpty &&
        paymenthMethod.value.toString().isNotEmpty &&
        bricks.value.isNotEmpty) {
      return true;
    } else
      return false;
  }

  Future<void> pay(BuildContext context, int propertyId, int briksNum) async {
    try {
      if (validate()) {
        isLoading.value = true;
        final param = {
          "propertyId": propertyId,
          "sharesPurchased": int.parse(shareNum.value),
          "paymentMethodId": paymenthMethod.value,
          "BricksPurchased": briksNum,
          if (paymenthMethod.value == "13")
            "stripePaymentMethodId": 13
        };
        final response = await netWorkCalls.postApi(
            "Investments", await Utils.getCommonHeaderWithAuth(), param);

        PaymentReponse paymentReponse =
            PaymentReponse.fromJson(jsonDecode(response.data));

        if (!paymentReponse.success)
          showMyBottomSheet(context, paymentReponse.message ?? "");
        else {
          showonfirmDialog(
            context,
            S.of(context).payment_sucessfully,
            onConfirm: () => Get.to(BankInfoScreen(
              paymentInfo: paymentReponse,
            )),
          );
        }
      } else {
        showMyBottomSheet(context, S.of(context).fill_all_filed);
      }
    } catch (e) {
      message.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> continuePayStripe(BuildContext context, int propertyId, int briksNum,InvesmentsData data) async {
    try {
      if (validate()) {
        isLoading.value = true;
        final param = {
          "propertyId": propertyId,
          "sharesPurchased": int.parse(shareNum.value),
          "paymentMethodId": paymenthMethod.value,
          "BricksPurchased": briksNum,
          if (paymenthMethod.value == "13")
            "stripePaymentMethodId": 13
        };
        final response = await netWorkCalls.postApi(
            "Investments", await Utils.getCommonHeaderWithAuth(), param);

        PaymentReponse paymentReponse =
        PaymentReponse.fromJson(jsonDecode(response.data));

        if (!paymentReponse.success)
          showMyBottomSheet(context, paymentReponse.message ?? "");
        else {
          // continuePayStripe(context,data.id??0,  data.totalAmount??0,paymentReponse.data.paymentIntentClientSecret);
          // showonfirmDialog(§
          //   context,
          //   S.of(context).payment_sucessfully,
          //   onConfirm: () => Get.to(BankInfoScreen(
          //     paymentInfo: paymentReponse,
          //   )),
          // );
        }
      } else {
        showMyBottomSheet(context, S.of(context).fill_all_filed);
      }
    } catch (e) {
      message.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> payStripe(BuildContext context, int propertyId, int briksNum,ProperitesData data) async {
    try {
      if (validate()) {
        isLoading.value = true;
        final param = {
          "propertyId": propertyId,
          "sharesPurchased": int.parse(shareNum.value),
          "paymentMethodId": paymenthMethod.value,
          "BricksPurchased": briksNum,
          if (paymenthMethod.value == "13")
            "stripePaymentMethodId": 13
        };
        final response = await netWorkCalls.postApi(
            "Investments", await Utils.getCommonHeaderWithAuth(), param);

        PaymentReponse paymentReponse =
        PaymentReponse.fromJson(jsonDecode(response.data));

        if (!paymentReponse.success)
          showMyBottomSheet(context, paymentReponse.message ?? "");
        else {
          makePayment(context,  double.parse(price.value), data,paymentReponse.data.paymentIntentClientSecret);
          // showonfirmDialog(
          //   context,
          //   S.of(context).payment_sucessfully,
          //   onConfirm: () => Get.to(BankInfoScreen(
          //     paymentInfo: paymentReponse,
          //   )),
          // );
        }
      } else {
        showMyBottomSheet(context, S.of(context).fill_all_filed);
      }
    } catch (e) {
      message.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> makePayment(BuildContext context, double price, ProperitesData data, String secret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: secret,
          merchantDisplayName: 'Briks App',
          style: ThemeMode.light,
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      Get.snackbar('Success', 'Payment completed successfully!');
      Get.offAll(MainView());
    } on StripeException catch (e) {
      Get.snackbar('Error', e.error.localizedMessage ?? 'Stripe error!');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> continuePayment(BuildContext context, double price, String secret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: secret,
          merchantDisplayName: 'Briks App',
          style: ThemeMode.light,
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      Get.snackbar('Success', 'Payment completed successfully!');
      Get.offAll(MainView());
    } on StripeException catch (e) {
      Get.snackbar('Error', e.error.localizedMessage ?? 'Stripe error!');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  Future<void> ContinuemakePayment(BuildContext context, double price, InvesmentsData data, String secret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: secret,
          merchantDisplayName: 'Briks App',
          style: ThemeMode.light,
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      Get.snackbar('Success', 'Payment completed successfully!');
      Get.offAll(MainView());
    } on StripeException catch (e) {
      Get.snackbar('Error', e.error.localizedMessage ?? 'Stripe error!');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }



}
