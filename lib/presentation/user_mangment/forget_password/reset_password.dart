
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controlers/for_get_password/forget_password_controler.dart';
import '../../../generated/l10n.dart';
import '../../../utils/color_helper.dart';

class ResetPasswordScreen extends StatelessWidget{
  TextEditingController emailControler=TextEditingController();
  TextEditingController otpCodeControler=TextEditingController();
  // TextEditingController newPasswordControler=TextEditingController();

    @override
  Widget build(BuildContext context) {
      ForgetPasswordControler forgetPasswordControler=Get.put(ForgetPasswordControler());

      return Scaffold(backgroundColor: Colors.white,
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
     if(forgetPasswordControler.isLoading.value)
       return Center(child: CircularProgressIndicator(),);
     else {
       return
         Column(children: [

           TextField(
             controller: emailControler,
             // controller: passwordControler,
             decoration: InputDecoration(
               border:OutlineInputBorder(
                 borderRadius: BorderRadius.circular(15),
                 borderSide: BorderSide(

                     color: ColorHelper.pr),
               ),
               hintText: S.of(context).enter_email,
               prefixText: ' ',
               suffixStyle: TextStyle(color: ColorHelper.tertiryColor),
                            fillColor: ColorHelper.pr,
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
             controller: otpCodeControler,
             // controller: passwordControler,
             decoration: InputDecoration(
               border:OutlineInputBorder(
                 borderRadius: BorderRadius.circular(15),
                 borderSide: BorderSide(

                     color: ColorHelper.pr),
               ),
               hintText: S.of(context).verification_code,
               prefixText: ' ',
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
                 forgetPasswordControler.validateReset(context, emailControler.text,otpCodeControler.text);
               },
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Text(
                     S.of(context).send_verification_code,
                     style: const TextStyle(color: Colors.white, fontSize: 15),
                   ),

                   const Icon(
                     Icons.arrow_forward,
                     color: Colors.white,
                   ),
                 ],
               ),
             ),
           ),
         ],);
     }

   })

      );
  }

}