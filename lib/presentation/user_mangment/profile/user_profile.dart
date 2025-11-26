
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controlers/language/language_controler.dart';
import '../../../controlers/user_profile/user_profile_controler.dart';
import '../../../generated/l10n.dart';
import '../../../utils/color_helper.dart';
import '../../../widgets/card_widget.dart';
import '../../../widgets/login.dart';
import 'change_pass.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CacheControler cacheControler=Get.find();
    if(!cacheControler.isLogin.value) {
      return   loginMessage(context);

    }
 else{
      UserProfileControler controler = Get.put(UserProfileControler());
      return Scaffold(backgroundColor: ColorHelper.backround,
        body: Obx(() {
          if (controler.isLoading.value) {
            return  Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              width: double.infinity,
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(width: double.infinity,
                        child: cardWidget(
                          context,
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(S.of(context).first_name+": "),
                                    SizedBox(width: 4,),
                                    Text(controler.profile.value.firstName ?? ""),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [

                                    Text(S.of(context).last_name +": "),
                                    SizedBox(width: 4,),
                                    Text(controler.profile.value.lastName ?? ""),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(S.of(context).email+": "),
                                    SizedBox(width: 4,),
                                    Text(controler.profile.value.email ?? ""),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(S.of(context).phone+": "),
                                    SizedBox(width: 4,),
                                    Text(controler.profile.value.phone ?? ""),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                child: Opacity(
                                  opacity: 1,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorHelper.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      onPressed: () async{

                                        Get.to(ChangePasswordScreen());

                                      },
                                      child: Text(
                                        S.of(context).change_pass,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                child: Opacity(
                                  opacity: 1,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorHelper.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      onPressed: () async{

                                       controler.deleteAccount();

                                      },
                                      child: Text(
                                        S.of(context).change_pass,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),


                            ],
                          ),
                          null,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        }),
      );
    }
  }
}
