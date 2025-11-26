
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../generated/l10n.dart';
import '../../../utils/color_helper.dart';
import '../../../utils/utils.dart';
import '../../../widgets/card_widget.dart';
import '../create_account/create_account_screen.dart';
import '../forget_password/forget_password_screen.dart';
import '../login/login_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _CircularDotsPagerState();
}

class _CircularDotsPagerState extends State<WelcomeScreen> {
  final PageController _controller = PageController();

  final List<String> images = [
    "first.jpeg",
    "second.jpeg",
    "thirds.jpeg",
    "four.jpeg",
        "five.jpeg"
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heigh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Image.asset(Utils.getImgePath(images[index]));
              //   Image.network(
              //   images[index],
              //   fit: BoxFit.cover,
              //   width: double.infinity,
              //   height: double.infinity,
              // );
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                cardWidget(
                    context,
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: Column(
                            children: [
                              SmoothPageIndicator(
                                controller: _controller,
                                count: images.length,
                                effect: WormEffect(
                                  dotHeight: 12,
                                  dotWidth: 12,
                                  spacing: 8,
                                  activeDotColor: ColorHelper.primaryColor,
                                  dotColor: Colors.grey,
                                ),
                              ),
                            ],
                          )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: () async {
                                  Get.to(LoginPage());
                                },
                                child: Text(
                                  S.of(context).login,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: ColorHelper.primaryColor,
                                      width: 2),
                                   shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 24),
                                ),
                                onPressed: () {
                                  Get.to(CreateAccountScreen());
                                },
                                child: Text(
                                  S.of(context).create_account,
                                  style: TextStyle(
                                    color: ColorHelper.primaryColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: Colors.transparent, width: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 24),
                                ),
                                onPressed: () {
                                  Get.to(ForgetPasswordScreen());
                                },
                                child: Text(
                                  S.of(context).for_get_pass,
                                  style: TextStyle(
                                    color: ColorHelper.tertiryColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    heigh / 3.5)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
