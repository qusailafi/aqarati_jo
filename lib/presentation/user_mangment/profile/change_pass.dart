
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../controlers/user_profile/user_profile_controler.dart';
import '../../../generated/l10n.dart';
import '../../../utils/color_helper.dart';
import '../../../utils/utils.dart';

class ChangePasswordScreen  extends StatelessWidget {
  TextEditingController emailControler = TextEditingController();
  TextEditingController otpCodeControler = TextEditingController();


  @override
  Widget build(BuildContext context) {
    UserProfileControler forgetPasswordControler = Get.put(
        UserProfileControler());

    return Scaffold(backgroundColor: ColorHelper.backround,
appBar: AppBar(backgroundColor: Colors.white,title: Text(S.of(context).change_pass),),
        body: Obx(() {
          if (forgetPasswordControler.isLoading.value)
            return Center(child: CircularProgressIndicator(),);
          else {
            return
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(children: [
                            Center(child: Image.asset(Utils.getImgePath("logo.jpeg"),width: 250,height: 250,)),
                SizedBox(height: 10,),
                      TextField(
                        controller: emailControler,
                        obscureText: true,
                        // controller: passwordControler,
                        decoration: InputDecoration(
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                
                                color: ColorHelper.pr),
                          ),
                          hintText: S
                              .of(context)
                              .current_pass,
                          prefixText: ' ',
                          suffixStyle: TextStyle(color: ColorHelper.tertiryColor),
                                      fillColor: ColorHelper.pr,
                          filled: true,
                
                        ),
                      ),
                      const SizedBox(height: 12),
                
                      // TextField(
                      //   controller: newPasswordControler,
                      //   // controller: passwordControler,
                      //   obscureText: true,
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(15),
                      //       borderSide:
                      //       BorderSide(color: ColorHelper.tertiryColor),
                      //     ),
                      //     hintText: S.of(context).new_pass,
                      //     prefixText: ' ',
                      //     suffixStyle: TextStyle(color: ColorHelper.tertiryColor),
                      //                  fillColor: ColorHelper.pr,
                      //   ),
                      // ),
                      // const SizedBox(height: 12),
                
                      TextField(
                        obscureText: true,
                
                        controller: otpCodeControler,
                        // controller: passwordControler,
                        decoration: InputDecoration(
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                
                                color: ColorHelper.pr),
                          ),
                          hintText: S
                              .of(context)
                              .new_pass,
                          prefixText: ' ',
                          filled: true,
                
                          suffixStyle: TextStyle(color: ColorHelper.tertiryColor),
                                      fillColor: ColorHelper.pr,
                        ),
                      ),
                      const SizedBox(height: 12),
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
                            forgetPasswordControler.validateChange(
                                context, emailControler.text, otpCodeControler.text);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                S
                                    .of(context)
                                    .change_pass,
                                style: const TextStyle(color: Colors.white,
                                    fontSize: 15),
                              ),
                
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],),
                  ),
                ),
              );
          }
        })

    );
  }
}
