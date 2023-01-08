import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_scaner/View/add_assets.dart';
import 'package:qr_scaner/View/home_page.dart';
import 'package:qr_scaner/utils/toast.dart';

class LoginController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  var userCollectionRef = FirebaseFirestore.instance.collection('users');
  userLogin() async {
    try {
      var isMatch = await userCollectionRef
          .where(
            'username',
            isEqualTo: username.text,
          )
          .where(
            'password',
            isEqualTo: password.text,
          )
          .get();
      if (isMatch.docs.isNotEmpty) {
        toast('Login Successfully!');
        if (username.text == 'admin') {
          Get.offAll(HomePage());
        } else {
          Get.offAll(AddAssets());
        }
        clearAllFields();
      } else {
        toast('User Not Found!');
      }
    } catch (e) {
      toast('something went wrong!');
    }
  }

  clearAllFields() {
    username.text = '';
    password.text = '';
    update();
  }
}
