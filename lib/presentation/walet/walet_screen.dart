
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controlers/language/language_controler.dart';
import '../../controlers/profolio/profolio_controler.dart';
import '../../controlers/walet/walet_controler.dart';
import '../../generated/l10n.dart';
import '../../utils/color_helper.dart';
import '../../widgets/card_widget.dart';
import '../../widgets/empty_list.dart';
import '../../widgets/login.dart';

class WaletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CacheControler cacheControler = Get.find();

    if (!cacheControler.isLogin.value) {
      return loginMessage(context);
    } else {
      WaletControler waletControler = Get.put(WaletControler());
      ProfolioControler controler = Get.put(ProfolioControler());
      waletControler.getMyWalet();
      controler.getProfolio();
      return Obx(() {
        if (waletControler.isLoading.value) {
          return Container(
            color: ColorHelper.backround,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (waletControler.message.value.isEmpty) {
          return Container(
            color: ColorHelper.backround,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Expanded(
                        child: cardWidget(
                          context,
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Text(S.of(context).total_profolio,style: TextStyle(fontSize: 17)),
                                  const SizedBox(height: 15),
                                  Text(
                                    (controler.porfolio.value.data
                                                    ?.totalPortfolioValue ??
                                                0.0)
                                            .toString() +
                                        S.of(context).aed,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          null,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: cardWidget(
                          context,
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(S.of(context).totalInvested,style: TextStyle(fontSize: 17),),
                                  const SizedBox(height: 15),
                                  Text(
                                    (controler.porfolio.value.data
                                                    ?.totalInvested ??
                                                0.0)
                                            .toString() +
                                        S.of(context).aed,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  waletControler.data.length > 0
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: waletControler.data.length,
                            itemBuilder: (context, index) {
                              final item = waletControler.data[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: cardWidget(
                                  context,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.propertyTitle ?? "",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${item.totalAmount} AED"),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.blue
                                                    .withOpacity(0.7),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Text(
                                              item.transactions[0]
                                                      .paymentStatus ??
                                                  "",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        item.propertyAddress ?? "",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        item.paymentMethod ?? "",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  null,
                                ),
                              );
                            },
                          ),
                        )
                      : errorText(S.of(context).nodatad_fount)
                ],
              ),
            ),
          );
        } else {
          return errorText(waletControler.message.value);
        }
      });
    }
  }
}
