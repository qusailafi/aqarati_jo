
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controlers/payment/payment_response.dart';
import '../../controlers/payment_controler/walet_controler.dart';
import '../../generated/l10n.dart';
import '../../utils/color_helper.dart';
import '../../widgets/card_widget.dart';

class BankInfoScreen extends StatelessWidget {
  final PaymentReponse paymentInfo;
  final TextEditingController textEditingController = TextEditingController();
  final PaymentControler paymentControler = Get.put(PaymentControler());

  BankInfoScreen({super.key, required this.paymentInfo});

  @override
  Widget build(BuildContext context) {
    final bank = paymentInfo.data.bankTransferInfoList[0];

    return Scaffold(
      backgroundColor: ColorHelper.backround,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:  ColorHelper.backround,
        centerTitle: true,
        title:   Text(
         S.of(context).bank_info ,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Obx((){
        return paymentControler.isLoading.value ?  Center(child: CircularProgressIndicator(),):
          SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: cardWidget(
            context,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoTile(S.of(context).bank_name, bank.bankName ?? ""),
                  const SizedBox(height: 10),
                  _infoTile(S.of(context).account_name, bank.accountName ?? ""),
                  const SizedBox(height: 10),
                  _infoTile(S.of(context).price, "${bank.amount ?? "0"} ${S.of(context).aed}"),
                  const SizedBox(height: 25),

                  Text(
                    S.of(context).bank_ref_id,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: S.of(context).bank_ref_id,
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(

                            color: ColorHelper.pr),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorHelper.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: .5,
                      ),
                      onPressed: () {
                        paymentControler.verifyPayment(context,
                          paymentInfo.data.id.toString(),
                          textEditingController.text.trim(),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).pay,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            null,
          ),
        );
      })
     ,
    );
  }

  Widget _infoTile(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
