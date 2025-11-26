import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
 import '../../../controlers/for_get_password/forget_password_controler.dart';
import '../../../generated/l10n.dart';
import '../../../utils/color_helper.dart';
import '../../../utils/utils.dart';

class ForgetPasswordScreen extends StatelessWidget {


  TextEditingController mobileOrEmailControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ForgetPasswordControler forgetPasswordControler=Get.put(ForgetPasswordControler());

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
        title: Text(S.of(context).for_get_pass),
      ),
      body: Obx((){

        if(forgetPasswordControler.isLoading.value){
          return Center(child: CircularProgressIndicator(),);
        }else{
      return    Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                            Center(child: Image.asset(Utils.getImgePath("logo.jpeg"),width: 250,height: 250,)),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          TextField(
                            controller: mobileOrEmailControler,


                            decoration: InputDecoration(
                              border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(

                                    color: ColorHelper.pr),
                              ),
                              hintText: S.of(context).email,
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
                                forgetPasswordControler.validate(context, mobileOrEmailControler.text);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).send_verification_code,
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
