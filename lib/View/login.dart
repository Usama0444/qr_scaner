import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_scaner/Controllers/login_controller.dart';
import 'package:qr_scaner/View/home_page.dart';
import 'package:qr_scaner/utils/reusabale.dart';

import '../Controllers/add_user.dart';

class Login extends StatelessWidget {
  Login({super.key});
  LoginController controller = Get.find<LoginController>();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            children: [
              Container(
                width: 400.w,
                height: 400.h,
                margin: EdgeInsets.only(top: 10.h, bottom: 30.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/hala.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Center(
                child: MyTextField(
                  controller: controller.username,
                  form_Height: 80.h,
                  form_width: 350.w,
                  font_size: 16.sp,
                  label_color: Colors.grey[600],
                  lable_Txt: 'Enter username',
                  validator_txt: 'Please enter username',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: MyTextField(
                  controller: controller.password,
                  form_Height: 80.h,
                  form_width: 350.w,
                  font_size: 16.sp,
                  label_color: Colors.grey[600],
                  lable_Txt: 'Password',
                  validator_txt: 'Please enter password',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      controller.userLogin();
                    }
                  },
                  child: MyButton(
                    btnWidth: 350.w,
                    btnHeight: 70.h,
                    btnColor: Colors.grey[500],
                    btnTxt: 'Sign in',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
