import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controlers/payment_controler/walet_controler.dart';
import '../domain/block_response.dart';
import '../generated/l10n.dart';
import '../utils/color_helper.dart';
import '../utils/utils.dart';

class SearchableBottomSheet extends StatelessWidget {
  final List<Data> data;
  SearchableBottomSheet(this.data, {super.key});

  final PaymentControler waletControler = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 70,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    ),
                  ),
                  onPressed: () => _showSearchableBottomSheet(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        return Text(
                          waletControler.briksSelectedTitle.value,
                          style: const TextStyle(fontSize: 16),
                        );
                      }),
                      Row(
                        children: [
                          Image.asset(
                            Utils.getImgePath("briks.png"),
                            width: 15,
                            height: 15,
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                            size: 24,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchableBottomSheet(BuildContext context) {
    String searchQuery = '';
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: S.of(context).search,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                        BorderSide(color: ColorHelper.tertiryColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final filteredData = searchQuery.isEmpty
                            ? data
                            : data.where((item) {
                          final query = searchQuery.toLowerCase();
                          return item.totalPrice
                              .toString()
                              .toLowerCase()
                              .contains(query) ||
                              item.bricks
                                  .toString()
                                  .toLowerCase()
                                  .contains(query);
                        }).toList();

                        if (filteredData.isEmpty) {
                          return Center(
                              child: Text(S.of(context).no_properites));
                        }

                        return ListView(
                          children: filteredData.map((item) {
                            final isSelected = waletControler.price.value ==
                                item.totalPrice.toString();

                            return Container(
                              color: isSelected
                                  ? Colors.blue.withOpacity(0.3)
                                  : Colors.transparent,
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${item.totalPrice} ${S.of(context).aed}"),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text("${item.bricks} "),
                                          ],
                                        ),
                                        Container(
                                          width: 20,
                                          height: 20,
                                          child: Image.asset(
                                              Utils.getImgePath("briks.png")),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  waletControler.shareNum.value =
                                      item.shares.toString();
                                  waletControler.price.value =
                                      item.totalPrice.toString();
                                  waletControler.bricks.value =
                                      item.bricks.toString();
                                  waletControler.briksSelectedTitle.value =
                                      item.totalPrice.toString() +
                                          " " +
                                          S.of(Get.context!).aed;

                                  Navigator.pop(context);
                                },
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
