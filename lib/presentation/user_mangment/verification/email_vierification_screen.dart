
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';

import '../../../controlers/verification_controler/verification_controler.dart';
import '../../../generated/l10n.dart';
import '../../../utils/color_helper.dart';

class Emailverification extends StatelessWidget {
 String email="";
 final TextEditingController pinController = TextEditingController();

 Emailverification({required this.email});
  final VerificationControler controller = Get.put(VerificationControler());

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title:   Text(S.of(context).verification_screen),
        centerTitle: true,
      ),
      body:Obx((){
        if(controller.isLoading.value){
          return Center(child: CircularProgressIndicator(),);

        }else{
          return   SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                    Text(
                    S.of(context).enter_code,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                    Text(
                   S.of(context).we_have_sent_code,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
            
                   Pinput(
                    length: 6,
                    controller: pinController,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: ColorHelper.primaryColor, width: 2),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blue.shade50,
                        border: Border.all(color:  ColorHelper.primaryColor),
                      ),
                    ),
                    // onCompleted: controller.onCompleted,
                  ),
            
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: (){
                      controller.verificationCode(context,email,pinController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child:   Text(S.of(context).verify),
                  ),

                  const SizedBox(height: 40),
                  TextButton(
                    onPressed: () {
                      controller.resend(context, email);
                    },
                    child: Text(
                      S.of(context).resend,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  )

            
                ],
              ),
            ),
          );
        }
      })

    );
  }
}