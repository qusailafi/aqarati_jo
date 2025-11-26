import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../controlers/create_account/create_account_controler.dart';
import '../../../utils/utils.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/card_widget.dart';
import '../../../widgets/picker_sheet.dart';
import '../../../utils/color_helper.dart';

class CreateAccountScreen extends StatelessWidget {
  TextEditingController firstControler = TextEditingController();
  TextEditingController lastControler = TextEditingController();
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController phoneControler = TextEditingController();
  TextEditingController confirmPasswordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CreateAccountControler controller = Get.put(CreateAccountControler());

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(S.of(context).create_account),
        ),
        body: Obx(() {
          if (controller.isLoading.value)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: Image.asset(Utils.getImgePath("logo.jpeg"),width: 250,height: 250,)),

                    TextField(
                      controller: firstControler,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(

                                    color: ColorHelper.pr),
                              ),
                        hintText: S.of(context).first_name,
                        prefixText: ' ',
                        counterText: '',
                        filled: true,
                                  fillColor: ColorHelper.pr,
                      ),
                    ),
                    const SizedBox(height: 12),

                    TextField(
                      controller: lastControler,
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(

                                    color: ColorHelper.pr),
                              ),
                         hintText: S.of(context).last_name,
                        prefixText: ' ',
                        counterText: '',
                        filled: true,
                                  fillColor: ColorHelper.pr,
                      ),
                    ),
                    const SizedBox(height: 12),

                    TextField(
                      controller: emailControler,
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(

                              color: ColorHelper.pr),
                        ),
                        hintText: S.of(context).email,
                        prefixText: ' ',
                        counterText: '',
                        filled: true,
                                  fillColor: ColorHelper.pr,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: passwordControler,
                      // controller: passwordControler,
                      obscureText: true,
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(

                              color: ColorHelper.pr),
                        ),
                        hintText: S.of(context).password,
                        prefixText: ' ',
                        suffixStyle: TextStyle(color: ColorHelper.tertiryColor),
                        filled: true,
                                  fillColor: ColorHelper.pr,
                      ),
                    ),
                    const SizedBox(height: 12),

                    TextField(
                      controller: confirmPasswordControler,
                      // controller: passwordControler,
                      obscureText: true,
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(

                              color: ColorHelper.pr),
                        ),
                        hintText: S.of(context).confirm_password,
                        prefixText: ' ',
                        suffixStyle: TextStyle(color: ColorHelper.tertiryColor),
                        filled: true,
                                  fillColor: ColorHelper.pr,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        /// 👇 لايبل لاختيار الدولة
                        Obx(() => InkWell(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              onSelect: (Country country) {
                                controller.selectedCountryCode.value = "+${country.phoneCode}";
                                controller.selectedFlag.value = country.flagEmoji;
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "${controller.selectedFlag.value}  ${controller.selectedCountryCode.value}",
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                const Icon(Icons.arrow_drop_down, color: Colors.black54),
                              ],
                            ),
                          ),
                        )),

                        const SizedBox(width: 12),

                         Expanded(
                          child: TextField(
                            controller: phoneControler,
                             keyboardType: TextInputType.number,
                            maxLength: 9,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                              border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(

                                    color: ColorHelper.pr),
                              ),
                              hintText: S.of(context).phone,
                              counterText: '',
                              filled: true,
                                        fillColor: ColorHelper.pr,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    if (controller.imgPath.value.isEmpty)
                      InkWell(
                        onTap: () {
                          Get.bottomSheet(
                            ImageChooserSheet(),
                            isDismissible: true,
                            enableDrag: true,
                            backgroundColor: Colors.transparent,
                          );
                        },
                        child: Container(
                          color: Colors.white,
                          width: double.infinity,
                          child: cardWidget(
                              context,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context).upload_passport,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                       fontWeight: FontWeight.normal,
                                      backgroundColor: Colors.white.withOpacity(
                                          0.8), // نفس الـ fillColor
                                    ),
                                  ),
                                ],
                              ),
                              50),
                        ),
                      ),
                    const SizedBox(height: 12),
                    if (controller.imgPath.value.isNotEmpty)
                      Column(
                        children: [
                          Text(S.of(context).your_passport),
                          SizedBox(
                            height: 6,
                          ),
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                 child: Image.file(
                                  File(controller.imgPath.value),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0, // 👈 هيك الأيقونة بتكون فوق على اليسار
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      controller.imgPath.value = "";
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    SizedBox(
                      height: 12,
                    ),
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
                        onPressed: () {
                          controller.validate(
                              firstControler.text,
                              lastControler.text,
                           controller.selectedCountryCode.value+   phoneControler.text,
                              passwordControler.text,
                              "",
                              emailControler.text,
                              confirmPasswordControler.text,
                              context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).send_email,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // List of countries
                  ],
                ),
              ),
            );
          }
        }));
  }
}
