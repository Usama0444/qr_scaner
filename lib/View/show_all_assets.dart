import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_scaner/Controllers/add_assets.dart';
import 'package:qr_scaner/Model/assets_model.dart';
import 'package:qr_scaner/Model/assets_model.dart';
import 'package:qr_scaner/View/add_assets.dart';
import 'package:qr_scaner/utils/reusabale.dart';

class ShowAllAssets extends StatelessWidget {
  ShowAllAssets({super.key});
  AddAssetsController assetss = Get.find<AddAssetsController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.grey[600],
          ),
          elevation: 0.0,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: assetss.getAll(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey[600],
                      ),
                    )
                  ],
                );
              } else {
                var docs = snapshot.data?.docs;
                List<AssetsModel> assets = [];
                var ids = [];
                for (int i = 0; i < docs!.length; i++) {
                  assets.add(AssetsModel(
                    city: docs[i]['city'],
                    assetBarcode: docs[i]['assetsBarcode'],
                    assetsDes: docs[i]['assetsDes'],
                    assetsImg: docs[i]['assetsImage'],
                    branch: docs[i]['branch'],
                    category: docs[i]['category'],
                    erpRef: docs[i]['repRef'],
                    floor: docs[i]['floor'],
                    holdername: docs[i]['holderName'],
                    ref: docs[i]['ref'],
                    room: docs[i]['room'],
                    serNo: docs[i]['serNo'],
                    subCategory: docs[i]['subCategory'],
                  ));
                  ids.add(docs[i]['id']);
                }
                return ListView.builder(
                  itemCount: assets.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: double.infinity,
                      child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTxt(
                                      txt: 'Holder Name : ${assets[index].holdername}',
                                      txt_style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    CustomTxt(
                                      txt: 'Barcode : ${assets[index].assetBarcode}',
                                      txt_style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    CustomTxt(
                                      txt: 'Description : ${assets[index].assetsDes}',
                                      txt_style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    CustomTxt(
                                      txt: 'Floor : ${assets[index].floor}',
                                      txt_style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    CustomTxt(
                                      txt: 'Branch : ${assets[index].branch}',
                                      txt_style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    CustomTxt(
                                      txt: 'City : ${assets[index].city}',
                                      txt_style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    CustomTxt(
                                      txt: 'Category : ${assets[index].category}',
                                      txt_style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    assets[index].assetsImg != null
                                        ? SizedBox(
                                            width: 200.w,
                                            height: 100.h,
                                            child: Image.memory(base64.decode(assets[index].assetsImg!)),
                                          )
                                        : Text(''),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            assetss.assetBarcode.text = assets[index].assetBarcode!;
                                            assetss.assetDes.text = assets[index].assetsDes!;
                                            assetss.assetsImage = assets[index].assetsImg!;
                                            assetss.floor.text = assets[index].floor!;
                                            assetss.room.text = assets[index].room!;
                                            assetss.subCategory.text = assets[index].subCategory!;
                                            assetss.ref.text = assets[index].ref!;
                                            assetss.repRef.text = assets[index].erpRef!;
                                            assetss.holderName.text = assets[index].holdername!;
                                            assetss.serNo.text = assets[index].serNo!;
                                            assetss.id = ids[index];
                                            assetss.isUpdate = true;
                                            assetss.city = assets[index].city;
                                            assetss.branch = assets[index].branch;
                                            assetss.category = assets[index].category;

                                            assetss.update();
                                            Get.to(AddAssets());
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            assetss.delete(ids[index]);
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
