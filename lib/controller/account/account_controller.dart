import 'dart:io';

import 'package:fhcs_mobile_application/data/model/account/account.dart';
import 'package:fhcs_mobile_application/data/model/requests/auth_request/auth_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/update_profile_request/update_profile_request.dart';
import 'package:fhcs_mobile_application/data/repository/account_repository.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AccountController extends GetxController {
  final AccountRepository accountRepository;
  AccountController({@required this.accountRepository});
  var accountInfo = Account().obs;
  var isLoading = false.obs;
  var newpass = "".obs;
  var avatarPathFile = "".obs;
  File image;
  final picker = ImagePicker();
  TextEditingController textName = TextEditingController();
  TextEditingController textDes = TextEditingController();
  TextEditingController textPhoneNumber = TextEditingController();
  TextEditingController textEmail = TextEditingController();
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var accountId;
  @override
  void onInit() {
    avatarPathFile.value = null;
    getAccountInfo();

    super.onInit();
  }

  @override
  void onClose() {
    avatarPathFile.value = null;
    super.onClose();
  }

  void getAccountInfo() async {
    try {
      var result = await accountRepository.getProfileInfo();
      if (result.statusCode == 200) {
        accountInfo.value = result.data;
        accountId = accountInfo.value.id;
        getTextField();
        print(accountInfo.value.displayName);
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  clearText() {
    oldPassController.clear();
    newPassController.clear();
    confirmPassController.clear();
  }

  void changePassword() async {
    if (formKey.currentState.validate()) {
      try {
        var result = await accountRepository.changeNewPassword(AuthRequest(
            oldPassword: oldPassController.text,
            newPassword: newPassController.text,
            confirmNewPassword: confirmPassController.text));
        if (result.statusCode == 201) {
          clearText();
          Get.back();
          GeneralHelper.showMessage(msg: "Đổi mật khẩu thành công.");
        } else {
          GeneralHelper.showMessage(msg: result.message);
        }
      } on Exception catch (e) {
        print(e);
      }
    }
  }

  Future<bool> backScreen() {
    print(accountInfo.value.phoneNumber);
    var phoneNumber = accountInfo.value.phoneNumber == null
        ? ""
        : accountInfo.value.phoneNumber;
    var displayName = accountInfo.value.displayName == null
        ? ""
        : accountInfo.value.displayName;
    var description = accountInfo.value.description == null
        ? ""
        : accountInfo.value.description;
    debugPrint("_pop");
    if (avatarPathFile.value != null ||
        textName.text != displayName ||
        textDes.text != description ||
        textPhoneNumber.text != phoneNumber) {
      GeneralHelper.showConfirm(
        title: "Bạn có chắc chắn rời khỏi trang này?",
        msg: "Thông tin bạn vừa nhập sẽ không được lưu lại.",
        pressCancel: () {},
        textCancel: "Ở Lại",
        textOk: "Rời khỏi",
        pressOk: () {
          avatarPathFile.value = null;
          image = null;
          textName.text = accountInfo.value.displayName;
          textDes.text = accountInfo.value.description;
          textPhoneNumber.text = accountInfo.value.phoneNumber;
          Get.back();
        },
      );
    } else {
      Get.back();
    }
    return Future.value(false);
  }

  void getTextField() {
    textName.text = accountInfo.value.displayName;
    textDes.text = accountInfo.value.description;
    textPhoneNumber.text = accountInfo.value.phoneNumber;
  }

  void updateProfile() async {
    isLoading.value = true;
    try {
      var result = await accountRepository.updateProfileUser(
          UpdateProfileRequest(
              displayName: textName.text,
              description: textDes.text,
              phoneNumber: textPhoneNumber.text,
              avatarFile: image ?? null));
      if (result.statusCode == 200) {
        isLoading.value = false;
        image = null;
        avatarPathFile.value = null;
        getAccountInfo();
        Get.back();
        GeneralHelper.showMessage(msg: "Sửa thông tin thành công");
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void navigatorAccountInfo() async {
    //   getAccountInfo();
    Get.toNamed("/accountInfo");
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      avatarPathFile.value = image.path;
    } else {
      print('No image selected.');
    }
  }
}
