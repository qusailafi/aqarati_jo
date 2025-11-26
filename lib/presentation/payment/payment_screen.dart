import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../controlers/payment_controler/walet_controler.dart';
import '../../domain/preoperites/properites_response.dart';
import '../../generated/l10n.dart';
import '../../utils/color_helper.dart';
import '../../widgets/card_widget.dart';
import '../../widgets/drop_down_search.dart';
import '../../widgets/empty_list.dart';
import '../../widgets/radio_button.dart';

class PaymentScreen extends StatelessWidget {
  final ProperitesData data;

  PaymentScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    PaymentControler waletControler = Get.put(PaymentControler());
    waletControler.getBriks(data.id.toString());

    return Scaffold(
      backgroundColor: ColorHelper.backround,
      appBar: AppBar(
        backgroundColor: ColorHelper.backround,
        title: Text(S.of(context).payment),
      ),
      body: Obx(() {
        if (waletControler.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (waletControler.message.value.isNotEmpty) {
          return errorText(waletControler.message.value);
        } else {
          return Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: cardWidget(
                context,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        S.of(context).how_much_invest,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorHelper.primaryColor,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 70,
                        child: SearchableBottomSheet(waletControler.data),
                      ),
                      const SizedBox(height: 10),
                      PaymentTypeRadioButton(),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorHelper.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () async {
                            if(waletControler.paymenthMethod.value==13)
await waletControler.payStripe(context, data.id ?? 0,
    int.parse(waletControler.bricks.value), data);
                            else
                              waletControler.pay(context, data.id ?? 0,
                                  int.parse(waletControler.bricks.value));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                S.of(context).book_invensment,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Icon(Icons.arrow_forward, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                null,
              ),
            ),
          );
        }
      }),
    );
  }
  //
}

// =================== Payment Functions ===================


