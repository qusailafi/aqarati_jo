import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../controlers/language/language_controler.dart';
import '../../controlers/profolio/profolio_controler.dart';
import '../../generated/l10n.dart';
import '../../utils/color_helper.dart';
import '../../widgets/card_widget.dart';
import '../../widgets/login.dart';

class PortFolioScreen extends StatelessWidget {
  final Random _rnd = Random();

  PortFolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CacheControler cacheControler = Get.find();

    if (!cacheControler.isLogin.value) {
      return loginMessage(context);
    } else {
      final itemCount = 6;
      ProfolioControler controler = Get.put(ProfolioControler());
      controler.getProfolio();
      return Obx(() {
        if (controler.isLoading.value) {
          return Container(
              color: ColorHelper.backround,
              child: const Center(child: CircularProgressIndicator()));
        } else if (controler.message.value.isNotEmpty) {
          return Center(child: Text(controler.message.value));
        } else {
          return Scaffold(
            backgroundColor: ColorHelper.backround,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10                     ),
                  //   child: Text(
                  //     S.of(context).invenstment_summary,
                  //     style: TextStyle(fontSize: 20),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      children: List.generate(itemCount, (index) {
                        String value = "";
                        if (index == 0) {
                          value = controler
                                  .porfolio.value.data?.totalPortfolioValue
                                  .toString() ??
                              "";
                          value += S.of(context).aed;
                          return StaggeredGridTile.count(
                            crossAxisCellCount: 2,
                            mainAxisCellCount: .8,
                            child: _buildTile(
                              context,
                              index,
                              S.of(context).total_profolio,
                              value,
                            ),
                          );
                        } else {
                          String label = "";
                          String? value = "";
                          if (index == 1) {
                            label = S.of(context).totalInvested;
                            value = controler.porfolio.value.data?.totalInvested
                                    .toString() ??
                                "";
                            value += S.of(context).aed;
                          } else if (index == 2) {
                            label = S.of(context).unrealisedAppreciation;
                            value = controler
                                    .porfolio.value.data?.unrealisedAppreciation
                                    ?.toString() ??
                                "";
                            value += S.of(context).aed;
                          } else if (index == 3) {
                            label = S.of(context).totalRentalIncome;
                            value = controler
                                    .porfolio.value.data?.totalRentalIncome
                                    .toString() ??
                                "";
                            value += S.of(context).aed;
                          } else if (index == 4) {
                            label = S.of(context).roi;
                            value = controler.porfolio.value.data?.roi
                                    ?.toString() ??
                                "";
                            value += "%";
                          } else if (index == 5) {
                            label = S.of(context).annualisedRentalReturn;
                            value = controler
                                    .porfolio.value.data?.annualisedRentalReturn
                                    .toString() ??
                                "";
                            value += "%";
                          }
                          return StaggeredGridTile.count(
                            crossAxisCellCount: 2,
                            mainAxisCellCount: .8,
                            child:
                                _buildTile(context, index, label, value ?? ""),
                          );
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      });
    }
  }

  Widget _buildTile(
      BuildContext context, int index, String label, String value) {
    return cardWidget(
      context,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: ColorHelper.tertiryColor,
              ),
            ),
            // Spacer(),
            SizedBox(height: 10,),
            Text(
              value,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                color: ColorHelper.tertiryColor,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      null,
      elevation: .1,cardColor: ColorHelper.pr
    );
  }
}
