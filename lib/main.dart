import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_scaner/Bindings/GetxControllerBindings.dart';
import 'package:qr_scaner/Controllers/login_controller.dart';
import 'package:qr_scaner/View/add_user.dart';
import 'package:qr_scaner/View/create_branch.dart';
import 'package:qr_scaner/View/home_page.dart';
import 'package:qr_scaner/View/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ControllerBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: Login(),
          );
        });
  }
}
