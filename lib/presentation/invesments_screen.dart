
import 'package:aqarati/presentation/payment/continue_payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../controlers/invensments_controler/invensments_controler.dart';
import '../controlers/language/language_controler.dart';
import '../controlers/payment_controler/walet_controler.dart';
import '../generated/l10n.dart';
import '../utils/color_helper.dart';
import '../utils/utils.dart';
import '../widgets/login.dart';

class InvestmentsPage extends StatefulWidget {
  const InvestmentsPage({super.key});

  @override
  State<InvestmentsPage> createState() => _InvestmentsPageState();
}

class _InvestmentsPageState extends State<InvestmentsPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    CacheControler cacheControler=Get.find();

    if(!cacheControler.isLogin.value) {
      return   Container(color: Colors.white,child: loginMessage(context));

    }else{
      InvensmentsControler homeController = Get.put(InvensmentsControler());

      return Obx(() {
        if (homeController.isLoading.value) {
          return Container(color: ColorHelper.backround,child: const Center(child: CircularProgressIndicator()));
        } else {
          return Scaffold(
            backgroundColor: ColorHelper.backround,

            appBar: AppBar(backgroundColor: ColorHelper.backround,
              title: Text(S.of(context).my_invensments),
            ),
             body: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: homeController.invesments.length,
              itemBuilder: (context, i) {
                final property = homeController.invesments.value[i];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      if(property.paymentIntentClientSecret!=null)
                      Get.to(ContinuePaymentScreen(data: property));
                      else{
                        PaymentControler waletControler = Get.put(PaymentControler());
waletControler.continuePayment(context,property.totalAmount??0,property.paymentIntentClientSecret??"");
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: screenHeight / 4,
                          width: double.infinity,
                          child: PropertyImagePager(
                              property: property, screenHeight: screenHeight),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            property.propertyTitle ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                property.propertyAddress ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "SharePurchased" +
                                    property.sharesPurchased.toString() ??
                                    "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      });
    }

  }
}

class PropertyImagePager extends StatefulWidget {
  final dynamic property;
  final double screenHeight;

  const PropertyImagePager({
    super.key,
    required this.property,
    required this.screenHeight,
  });

  @override
  State<PropertyImagePager> createState() => _PropertyImagePagerState();
}

class _PropertyImagePagerState extends State<PropertyImagePager> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.property.propertyImages ?? [];

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: images.isNotEmpty
              ? SizedBox(
                  height: widget.screenHeight / 4,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, imgIndex) {
                      final imageUrl =
                          Utils.IMAGE_PATH + (images[imgIndex].imageUrl ?? "");
                      return InkWell(
                        onTap: () {
                          if(widget.property.paymentIntentClientSecret!=null)
                            Get.to(ContinuePaymentScreen(data:widget. property));
                          else{
                            PaymentControler waletControler = Get.put(PaymentControler());
                            waletControler.continuePayment(context,widget.property.totalAmount??0,widget.property.paymentIntentClientSecret??"");
                          }
                        },
                        child: Image.network(
                          imageUrl,
                          height: widget.screenHeight / 4,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(
                  height: widget.screenHeight / 4,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported),
                ),
        ),
        if (images.isNotEmpty)
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                "${_currentPage + 1} / ${images.length}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }
}
