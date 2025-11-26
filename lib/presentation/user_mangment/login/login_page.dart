import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controlers/login/login_controler.dart';
import '../../../generated/l10n.dart';
import '../../../utils/color_helper.dart';
import '../../../utils/utils.dart';

class LoginPage extends StatelessWidget {


  TextEditingController mobileOrEmailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    LoginControler loginControler=Get.put(LoginControler());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(S.of(context).login),
      ),
      body:
      Obx( (){
        if(loginControler.isLoading.value){
          return Center(child: CircularProgressIndicator(),);
        }else  {
        return  Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Image.asset(Utils.getImgePath("logo.jpeg"),width: 250,height: 250,)),
                      // Text(S.of(context).welcome_back,style: TextStyle(color: Colors.black,fontSize:20,fontWeight: FontWeight.bold),),
                      // SizedBox(height: 10,),
                      // Text(S.of(context).login_glad,style: TextStyle(color: Colors.black,fontSize:12),),
                      SizedBox(height: 20,),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          TextField(
                            controller: mobileOrEmailControler,


                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(

                                    color: ColorHelper.pr),
                              ),
                              hintText: S.of(context).email_mob,
                              prefixText: ' ',
                              suffixStyle: TextStyle(
                                  color: ColorHelper.tertiryColor),
                              counterText: '',
                              filled: true,
                              fillColor: ColorHelper.pr,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: passwordControler,

                            obscureText: true,
                            decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(

                                    color: ColorHelper.pr),
                              ),
                              hintText: S.of(context).password,
                              prefixText: ' ',
                              suffixStyle: TextStyle(
                                  color: ColorHelper.tertiryColor),
                              counterText: '',
                              filled: true,
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
                             loginControler.validate(mobileOrEmailControler.text, passwordControler.text,context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).continues,
                                    style: TextStyle(color: Colors.white, fontSize: 15),
                                  ),

                                  const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      })
    );
  }
}
