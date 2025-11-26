import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controlers/payment_controler/walet_controler.dart';
import '../generated/l10n.dart';
import '../utils/color_helper.dart'; // علشان نستخدم لون التطبيق الأساسي

class PaymentTypeRadioButton extends StatefulWidget {
  const PaymentTypeRadioButton({super.key});

  @override
  _PaymentTypeRadioButtonState createState() => _PaymentTypeRadioButtonState();
}

class _PaymentTypeRadioButtonState extends State<PaymentTypeRadioButton> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    final PaymentControler controler = Get.find();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RadioListTile<String>(
          title: Text(
            S.of(context).bank_transfare,

            style: TextStyle(
              color: selectedOption == "14"
                  ? ColorHelper.primaryColor
                  : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          value: "14",
          groupValue: selectedOption,
          activeColor: ColorHelper.primaryColor, // لون دائرة الراديو
          onChanged: (value) {
            setState(() {
              selectedOption = value;
              controler.paymenthMethod.value = 14;
              controler.shareLable.value = "Bank Transfer";
            });
          },
        ),
        RadioListTile<String>(
          title: Text(
            S.of(context).credit_card,
            style: TextStyle(
              color: selectedOption == "13"
                  ? ColorHelper.primaryColor
                  : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          value: "13",
          groupValue: selectedOption,
          activeColor: ColorHelper.primaryColor,
          onChanged: (value) {
            setState(() {
              selectedOption = value;
              controler.paymenthMethod.value = 13;
              controler.shareLable.value = "Stripe";
            });
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
