import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../controlers/invensments_controler/invensments_controler.dart';
import '../../controlers/payment_controler/walet_controler.dart';
import '../../domain/invesments_response.dart';
import '../../generated/l10n.dart';
import '../../utils/color_helper.dart';
import '../../widgets/card_widget.dart';

class ContinuePaymentScreen extends StatefulWidget {
  final InvesmentsData data;

  ContinuePaymentScreen({required this.data, Key? key}) : super(key: key);

  @override
  State<ContinuePaymentScreen> createState() => _ContinuePaymentScreenState();
}

class _ContinuePaymentScreenState extends State<ContinuePaymentScreen> {
  final TextEditingController textEditingController = TextEditingController();
  late final InvensmentsControler invensmentsControler;
  late final PaymentControler waletControler;
  RxInt selectedIndex = (-1).obs;
  @override
  void initState() {
    super.initState();
    invensmentsControler = Get.find();
    waletControler = Get.put(PaymentControler(), permanent: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      invensmentsControler.getBankAccountsInfo(widget.data.id.toString());
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  ColorHelper.backround,
      appBar: AppBar(
        title: Text(S.of(context).payment),
        backgroundColor:  ColorHelper.backround,
      ),
      body: Obx(() {
        if (invensmentsControler.isLoading.value) {
          return   Container(color: ColorHelper.backround,child: Center(child: CircularProgressIndicator()));
        }

        if (invensmentsControler.account.isEmpty) {
          return Center(
            child: Text(
              S.of(context).no_account,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          );
        }

        return Column(
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: invensmentsControler.account.length,
                itemBuilder: (context, index) {
                  final account = invensmentsControler.account[index];
                  return Obx(() => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            selectedIndex.value = index;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedIndex.value == index
                                  ? Colors.black.withOpacity(.5)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: cardWidget(
                              cardColor: selectedIndex.value == index
                                  ? Colors.black.withOpacity(.5)
                                  : Colors.white,
                              context,
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      account.accountName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: selectedIndex.value == index
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      account.bankName,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: selectedIndex.value == index
                                            ? Colors.white
                                            : Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "${account.amount} ${S.of(context).aed}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: selectedIndex.value == index
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      account.swiftCode ?? "",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: selectedIndex.value == index
                                            ? Colors.white
                                            : Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              null,
                            ),
                          ),
                        ),
                      ));
                },
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  // prefixIcon: const Icon(Icons.phone_rounded),
                  hintText: S.of(context).bank_ref_id,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: ColorHelper.tertiryColor),
                  ),
                  filled: true,
                  fillColor: ColorHelper.pr,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(margin: EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorHelper.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () {
                    invensmentsControler.verifyPayment(
                      context,
                      widget.data.id.toString(),
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
            ),
          ],
        );
      }),
    );
  }
}

