import 'dart:async';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itb_ganecare/data/sharedprefs.dart';
import 'package:itb_ganecare/screen/home/home_screen.dart';

import '../../../data/controllers/profile_controller.dart';
import '../../../models/profile_v2.dart';
import 'counceling_edit_profile_screen.dart';
// import 'package:get/get.dart';
// import 'package:itb_ganecare/data/controllers/profile_controller.dart';
// import 'package:itb_ganecare/data/sharedprefs.dart';

class CouncelingProfileScreen extends StatefulWidget {
  const CouncelingProfileScreen({Key? key}) : super(key: key);

  @override
  State<CouncelingProfileScreen> createState() =>
      _CouncelingProfileScreenState();
}

class _CouncelingProfileScreenState extends State<CouncelingProfileScreen> {
  // handle stepper
  int _currentState = 0;
  List<StepperData> stepperData = [
    StepperData(
      title: StepperText(
        "Percaya diri",
        textStyle: const TextStyle(
          color: Colors.green,
        ),
      ),
      subtitle: StepperText(
        "Jangan lupa maen epep",
        textStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
      iconWidget: Container(
        padding: const EdgeInsets.all(1),
        decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: const Center(
          child: Icon(Icons.adb, color: Colors.white),
        ),
      ),
    ),
    StepperData(
      title: StepperText(
        "Stresss",
        textStyle: const TextStyle(
          color: Colors.red,
        ),
      ),
      subtitle: StepperText(
        "Jangan lupa maen epep",
        textStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
      iconWidget: Container(
        padding: const EdgeInsets.all(1),
        decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: const Center(
          child: Icon(Icons.adb, color: Colors.white),
        ),
      ),
    ),
  ];
  // final ProfileController _authController = Get.find();
  // final SharedPrefUtils _sharedPreference = SharedPrefUtils();
  final ProfileController _profileController = Get.find();
  final SharedPrefUtils _sharedPreference = SharedPrefUtils();
  String profilePicture = '';
  String idReg = '';
  String about = '';
  String nickName = '';
  int role = 0;

  @override
  void initState() {
    getProfileData();
    return super.initState();
  }

  getProfileData() {
    String noreg = _sharedPreference.getString('noreg').toString();
    _profileController.getProfileV2(noreg).then((value) => {
          setState(() {
            profilePicture = value['data']['conselee']['profilepic_image'];
            idReg = value['data']['conselee']['register_id'];
            about = value['data']['conselee']['about'];
            nickName = value['data']['conselee']['nickname'];
            role = value['data']['conselee']['role'];
          })
        });
  }

  Widget appBarCustom() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              _sharedPreference.removeKey('councelor_status');
              _sharedPreference.removeKey('councelee_status');
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomePage(isDarkMode: false)),
              );
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          Text(
            'Profile',
            style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CouncelingEditProfileScreen(
                    profilePicture: profilePicture,
                    noReg: idReg,
                    about: about,
                    nickName: nickName,
                    role: role.toString(),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget contentAvatar() {
    return Padding(
      padding: EdgeInsets.only(top: 120.h),
      child: Center(
        child: Column(
          children: [
            (profilePicture != "")
                ? Container(
                    height: 100.h,
                    width: 100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        100,
                      ),
                      image: DecorationImage(
                          image: NetworkImage(profilePicture),
                          fit: BoxFit.cover),
                      border: Border.all(
                        color: Colors.white,
                        width: 10,
                      ),
                    ),
                  )
                : Container(
                    height: 100.h,
                    width: 100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        100,
                      ),
                      image: DecorationImage(
                          image: AssetImage('assets/images/cat.png'),
                          fit: BoxFit.cover),
                      border: Border.all(
                        color: Colors.white,
                        width: 10,
                      ),
                    ),
                  ),
            SizedBox( 
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (idReg != '') ? '#' + idReg : '00000',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10.h),
                        height: 24.h,
                        width: 24.h,
                        child: const Icon(
                          Icons.list,
                          color: Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (nickName != '') ? nickName : 'Anonymous',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.grey),
                          child: const Center(
                            child: Text(
                              '2017',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: const Center(
                            child: Text(
                              'Beda jurusan',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10.h),
                        height: 20.h,
                        width: 150.w,
                        child: Center(
                          child: Text(
                            (about != '') ? about : 'Anonymous',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            vConsele(),
          ],
        ),
      ),
    );
  }

  Widget vConsele() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: SizedBox(
        height: 250.h,
        width: double.infinity,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: [
                Container(
                  height: 30.h,
                  width: double.infinity,
                  color: const Color.fromRGBO(255, 195, 70, 1),
                  child: const Center(child: Text('Hari ini,13 Maret 22')),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  height: 170.h,
                  width: double.infinity,
                  color: Colors.white,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      AnotherStepper(
                        stepperList: stepperData,
                        stepperDirection: Axis.vertical,
                        iconWidth:
                            25, // Height that will be applied to all the stepper icons
                        iconHeight:
                            25, // Width that will be applied to all the stepper icons
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 30.h,
                  width: double.infinity,
                  color: const Color.fromRGBO(255, 195, 70, 1),
                  child: const Center(child: Text('Hari ini,12 Januari 22')),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  height: 170.h,
                  width: double.infinity,
                  color: Colors.white,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      AnotherStepper(
                        stepperList: stepperData,
                        stepperDirection: Axis.vertical,
                        iconWidth:
                            25, // Height that will be applied to all the stepper icons
                        iconHeight:
                            25, // Width that will be applied to all the stepper icons
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // _sharedPreference.removeKey('councelor_status');
        // _sharedPreference.removeKey('councelee_status');
        // // Navigator.pop(context);
        // Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   toolbarHeight: 75.h,
        //   automaticallyImplyLeading: false,
        //   leading: GestureDetector(
        //     onTap: () {
        //       _sharedPreference.removeKey('councelor_status');
        //       _sharedPreference.removeKey('councelee_status');
        //       Navigator.pop(context);
        //       Navigator.pop(context);
        //     },
        //     child: const Icon(
        //       Icons.close,
        //       color: Colors.white,
        //     ),
        //   ),
        //   flexibleSpace: Container(
        //     decoration: const BoxDecoration(
        //       gradient: LinearGradient(
        //         colors: [
        //           Color.fromRGBO(0, 171, 233, 1),
        //           Color.fromRGBO(6, 146, 196, 1),
        //         ],
        //         begin: Alignment.centerRight,
        //         end: Alignment.centerLeft,
        //       ),
        //     ),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Container(
        //               margin: EdgeInsets.only(left: 46.w, top: 44.h),
        //               child: Text(
        //                 'Profile',
        //                 style: TextStyle(
        //                   color: const Color.fromRGBO(255, 255, 255, 1),
        //                   fontSize: 18.sp,
        //                   fontWeight: FontWeight.w600,
        //                 ),
        //               ),
        //             ),
        //             Container(
        //               margin: EdgeInsets.only(left: 46.w, top: 44.h),
        //               child: IconButton(
        //                 onPressed: () {
        //                   Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                       builder: (context) => CouncelingEditProfileScreen(
        //                         profilePicture: profilePicture,
        //                         noReg: idReg,
        //                         about: about,
        //                         nickName: nickName,
        //                         role: role.toString(),
        //                       ),
        //                     ),
        //                   );
        //                 },
        //                 icon: const Icon(
        //                   Icons.edit,
        //                   color: Colors.white,
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        body: Stack(
          children: [
            Container(
              color: const Color.fromRGBO(0, 171, 233, 1),
            ),
            buildHeader(),
            // buildProfileFace(),
            appBarCustom(),
            contentAvatar(),
          ],
        ),
        floatingActionButton: buildFloatingActionButton(),
      ),
    );
  }

  // void loadData() {
  //   String nim = _sharedPreference.getString('nim').toString();
  // String username = _sharedPreference.getString('username').toString();

  //   Future(
  //     () => _authController.getProfile(nim).then(
  //           (value) => log(
  //             value.toString(),
  //           ),
  //         ),
  //   );
  // }

  Widget buildHeader() {
    return Column(
      children: [
        Container(
          color: const Color.fromRGBO(0, 171, 233, 1),
          width: 1.sw,
          height: MediaQuery.of(context).size.height / 9,
        ),
        Container(
          color: const Color.fromRGBO(255, 195, 70, 1),
          width: 1.sw,
          height: MediaQuery.of(context).size.height / 5,
        ),
        Container(
          color: Colors.white,
          width: 1.sw,
          height: MediaQuery.of(context).size.height / 5,
        ),
      ],
    );
  }

  Widget buildProfileFace() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: 125.w,
            margin: EdgeInsets.only(right: 24.w, top: 42.h),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 0.5.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 8.r,
                  offset: const Offset(3, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Image.asset('assets/images/cat.png'),
            ),
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          (nickName != '') ? nickName : 'Anonymous',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Text(
                '2018',
                style: TextStyle(
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Text(
                'Satu Jurusan',
                style: TextStyle(
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          'BIO Example Text...',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(height: 44.h),
        Text(
          'Jan 2022',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget buildFloatingActionButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 55.h),
      child: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              elevation: 1,
              backgroundColor: Colors.orange,
              content: Text(
                'This feature still in development',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add_circle_rounded,
          color: Color.fromRGBO(3, 160, 217, 1),
          size: 44,
        ),
      ),
    );
  }
}
