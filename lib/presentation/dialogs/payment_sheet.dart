 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controlers/payment_controler/walet_controler.dart';
import '../../generated/l10n.dart';
import '../../utils/color_helper.dart';

void paymentBottomSheet(BuildContext context){
PaymentControler controler=Get.find();
  Get.bottomSheet(Column(        mainAxisSize: MainAxisSize.min
    ,children: [

  Container(
  padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Choose Paynent Method",style: TextStyle(fontSize: 16),),


    SizedBox(height: 10,),
         ElevatedButton(
          onPressed: () {
            controler.paymenthMethod.value=14;
            controler.shareLable.value="Bnank Transfare";

            Get.back();

            // Get.offAll(WelcomeScreen());
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: ColorHelper.tertiryColor,
          ),
          child: Text(
            "Bnank Transfare",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10,),
        ElevatedButton(
          onPressed: () {
            controler.paymenthMethod.value=13;
            controler.shareLable.value="Stripe";
Get.back();
            // Get.offAll(WelcomeScreen());
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: ColorHelper.tertiryColor,
          ),
          child: Text(
            "Stripe",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )

      ],
    ),
  ),



  ],) ,isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,);
}