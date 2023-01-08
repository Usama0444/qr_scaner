import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_scaner/Controllers/add_assets.dart';
import 'package:qr_scaner/View/show_all_assets.dart';

import '../utils/reusabale.dart';

class AddAssets extends StatefulWidget {
  AddAssets({super.key});

  @override
  State<AddAssets> createState() => _AddAssetsState();
}

class _AddAssetsState extends State<AddAssets> {
  AddAssetsController controller = Get.find<AddAssetsController>();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fillDropDownList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: GetBuilder<AddAssetsController>(
            builder: (controller) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        iconTheme: IconThemeData(
                          color: Colors.grey[600],
                        ),
                        elevation: 0.0,
                      ),
                      Center(child: MyDropDown(controller: controller, validateTxt: 'City')),
                      MyDropDown(controller: controller, validateTxt: 'Branch'),
                      SizedBox(
                        width: 350.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyTextField(
                              controller: controller.floor,
                              form_Height: 80.h,
                              form_width: 150.w,
                              font_size: 16.sp,
                              label_color: Colors.grey[600],
                              lable_Txt: 'Floor',
                              validator_txt: 'Please enter floor',
                            ),
                            MyTextField(
                              controller: controller.room,
                              form_Height: 80.h,
                              form_width: 150.w,
                              font_size: 16.sp,
                              label_color: Colors.grey[600],
                              lable_Txt: 'Room',
                              validator_txt: 'Please enter room',
                            ),
                          ],
                        ),
                      ),
                      MyDropDown(controller: controller, validateTxt: 'Category'),
                      MyOptionalTextField(
                        controller: controller.subCategory,
                        form_Height: 80.h,
                        form_width: 350.w,
                        font_size: 16.sp,
                        label_color: Colors.grey[600],
                        lable_Txt: 'Sub Category',
                        validator_txt: 'Please enter sub category',
                      ),
                      MyOptionalTextField(
                        controller: controller.ref,
                        form_Height: 80.h,
                        form_width: 350.w,
                        font_size: 16.sp,
                        label_color: Colors.grey[600],
                        lable_Txt: 'Ref',
                        validator_txt: 'Please enter ref',
                      ),
                      MyOptionalTextField(
                        controller: controller.repRef,
                        form_Height: 80.h,
                        form_width: 350.w,
                        font_size: 16.sp,
                        label_color: Colors.grey[600],
                        lable_Txt: 'ERP Ref',
                        validator_txt: 'Please enter ERP Ref',
                      ),
                      MyOptionalTextField(
                        controller: controller.holderName,
                        form_Height: 80.h,
                        form_width: 350.w,
                        font_size: 16.sp,
                        label_color: Colors.grey[600],
                        lable_Txt: 'Holder Name',
                        validator_txt: 'Please enter holder name',
                      ),
                      MyOptionalTextField(
                        controller: controller.serNo,
                        form_Height: 80.h,
                        form_width: 350.w,
                        font_size: 16.sp,
                        label_color: Colors.grey[600],
                        lable_Txt: 'Ser No',
                        validator_txt: 'Please enter serial No.',
                      ),
                      MyOptionalTextField(
                        controller: controller.assetDes,
                        form_Height: 80.h,
                        form_width: 350.w,
                        font_size: 16.sp,
                        label_color: Colors.grey[600],
                        lable_Txt: 'Assets Description',
                        validator_txt: 'Please enter assets description',
                      ),
                      GetBuilder<AddAssetsController>(builder: (controller) {
                        return GestureDetector(
                          onTap: () {
                            controller.takeAssetImage();
                          },
                          child: SizedBox(
                            width: 350.w,
                            height: 70.h,
                            child: Card(
                              elevation: 20,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Row(
                                    children: [
                                      Text(
                                        controller.assetsImage == null ? 'Asset Image' : 'Image Picked',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: controller.assetsImage == null ? Colors.grey[600] : Colors.blue,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        );
                      }),
                      MyTextField(
                        controller: controller.assetBarcode,
                        form_Height: 80.h,
                        form_width: 350.w,
                        font_size: 16.sp,
                        label_color: Colors.grey[600],
                        lable_Txt: 'Asset Barcode',
                        validator_txt: 'Please enter asset barcode',
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 350.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GetBuilder<AddAssetsController>(builder: (controller) {
                              return GestureDetector(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    controller.isUpdate ? controller.edit() : controller.create();
                                  }
                                },
                                child: MyButton(
                                  btnWidth: 100.w,
                                  btnHeight: 60.h,
                                  btnColor: Colors.grey[500],
                                  btnTxt: controller.isUpdate ? 'Update' : 'Save',
                                ),
                              );
                            }),
                            GestureDetector(
                              onTap: () {
                                Get.to(ShowAllAssets());
                              },
                              child: MyButton(
                                btnWidth: 100.w,
                                btnHeight: 60.h,
                                btnColor: Colors.grey[500],
                                btnTxt: 'Show All',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: MyButton(
                                btnWidth: 100.w,
                                btnHeight: 60.h,
                                btnColor: Colors.grey[500],
                                btnTxt: 'Excel Import',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
