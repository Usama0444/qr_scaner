import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_scaner/View/add_user.dart';
import 'package:qr_scaner/View/add_assets.dart';
import 'package:qr_scaner/View/create_branch.dart';
import 'package:qr_scaner/View/create_category.dart';
import 'package:qr_scaner/View/create_city.dart';
import 'package:qr_scaner/View/login.dart';
import 'package:qr_scaner/utils/toast.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  var screensList = [
    AddUser(),
    CreateBrach(),
    CreateCategory(),
    CreateCity(),
    AddAssets(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.grey[500]),
        ),
        body: screensList[index],
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                height: 260.h,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 10.h),
                child: Image.asset(
                  'assets/hala.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              customTiles('Create User', 0),
              customTiles('Create Branch', 1),
              customTiles('Create Category', 2),
              customTiles('Create City', 3),
              customTiles('Go to the Asset page', 4),
              customTiles('LogOut', 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTiles(txt, currentIndex) {
    return Column(
      children: [
        ListTile(
          leading: Text(txt),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20.sp,
          ),
          onTap: () {
            if (currentIndex != 5) {
              setState(() {
                index = currentIndex;
              });
            } else {
              Get.offAll(Login());
              toast('LogOut Successfully');
            }
            Get.back();
          },
        ),
        Divider(
          height: 4,
          color: Colors.grey[500],
        )
      ],
    );
  }
}
