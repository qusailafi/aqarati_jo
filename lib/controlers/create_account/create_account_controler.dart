import 'dart:io';

import 'package:aqarati/controlers/base_controler.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/remote/request_manger.dart';
import '../../generated/l10n.dart';
import '../../presentation/dialogs/error_dialog.dart';
import '../../presentation/user_mangment/verification/email_vierification_screen.dart';
import '../../utils/utils.dart';

class CreateAccountControler extends BaseControler {
  var selectedCountry = 'jo'.obs; // RxString
  var countries = <String>[].obs; // RxList
  var isLoading = false.obs;
  RxString imgPath = ''.obs;
  RxString first = ''.obs;
  RxString last = ''.obs;
  RxString phon = ''.obs;
  RxString password = ''.obs;
  NetWorkCalls netWorkCalls = NetWorkCalls();
  RxString sucessMessage = ''.obs;
  var selectedCountryCode = "+962".obs; // Default Jordan
  var selectedFlag = "🇯🇴".obs;

  validate(String first, String last, String phone, String pass, String img,
      String Email, String confirmpASS, BuildContext context) async {
    if (first.isNotEmpty &&
        last.isNotEmpty &&
        phone.isNotEmpty &&
        pass.isNotEmpty &&
        imgPath.value.isNotEmpty & Email.isNotEmpty &&
        confirmpASS.isNotEmpty) {
      if (pass == confirmpASS)
        createAccount(context, first, last, phone, img, Email, pass);
      else
        showMyBottomSheet(context, S.of(context).pass_confi_deff);
    } else {
      showMyBottomSheet(context, S.of(context).fill_all_filed);
    }
  }

  Future<void> createAccount(
      BuildContext context,
      String firstName,
      String lastName,
      String phone,
      String img,
      String email,
      String pass) async {
    try {
      Map<String, String> body = {
        'FirstName': firstName,
        'LastName': lastName,
        'Email': email,
        'Password': pass,
        "Phone": phone
      };
      List<File> file = [];
      file.add(File(imgPath.value));
      isLoading.value = true;
      final response = await netWorkCalls.postForDataMultiple("Auth/register",
          body, await Utils.getCommonHeaderWithoUTAuth(), file);

      if (response.data == '200') {
        Get.to(Emailverification(
          email: email,
        ));
      } else {
        message.value = response.message ?? "";
        showMyBottomSheet(context, message.value ?? "");
      }
    } catch (e) {
      message.value = e.toString();
      showMyBottomSheet(context, message.value ?? "");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickFromGallery() async {

    final ImagePicker _picker = ImagePicker();

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
       imgPath.value = pickedFile.path;
    }
  }

  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imgPath.value = pickedFile.path;
      return File(pickedFile.path);
    }
    return null;
  }
}
