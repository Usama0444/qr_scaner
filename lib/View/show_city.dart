import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_scaner/Controllers/add_branch.dart';
import 'package:qr_scaner/Controllers/add_city.dart';
import 'package:qr_scaner/View/create_city.dart';
import 'package:qr_scaner/utils/reusabale.dart';

class ShowCity extends StatelessWidget {
  ShowCity({super.key});
  AddCityController controller = Get.find<AddCityController>();
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
            stream: controller.getAll(),
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
                List<String> data_list = [];
                var ids = [];
                for (int i = 0; i < docs!.length; i++) {
                  data_list.add(docs[i]['name']);
                  ids.add(docs[i]['id']);
                }
                return ListView.builder(
                  itemCount: data_list.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTxt(
                                  txt: data_list[index],
                                  txt_style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        controller.name.text = data_list[index];
                                        controller.isUpdate = true;
                                        controller.id = ids[index];
                                        controller.update();
                                        Get.to(CreateCity());
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                        size: 40.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.delete(ids[index]);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 40.sp,
                                      ),
                                    )
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
