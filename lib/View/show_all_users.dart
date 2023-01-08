import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_scaner/Controllers/add_user.dart';
import 'package:qr_scaner/Model/user_model.dart';
import 'package:qr_scaner/View/add_user.dart';
import 'package:qr_scaner/utils/reusabale.dart';

class ShowAllUsers extends StatelessWidget {
  ShowAllUsers({super.key});
  CreateUserController users = Get.find<CreateUserController>();
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
            stream: users.getAllUsers(),
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
                List<UserModel> user = [];
                var ids = [];
                for (int i = 0; i < docs!.length; i++) {
                  if (docs[i]['username'] != 'admin') {
                    user.add(UserModel(
                      password: docs[i]['password'],
                      username: docs[i]['username'],
                    ));
                    ids.add(docs[i]['uid']);
                  }
                }
                return ListView.builder(
                  itemCount: user.length,
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
                                  txt: user[index].username,
                                  txt_style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        users.username.text = user[index].username!;
                                        users.password.text = user[index].password!;
                                        users.confirm_password.text = user[index].password!;
                                        users.isUserUpdate = true;
                                        users.id = ids[index];
                                        users.update();
                                        Get.to(AddUser());
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
                                        users.delete(ids[index]);
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
