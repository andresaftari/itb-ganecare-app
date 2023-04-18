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
import 'package:itb_ganecare/data/controllers/moodtracker_controller.dart';
import 'package:itb_ganecare/data/sharedprefs.dart';
import 'package:itb_ganecare/models/mood_model.dart';
import 'package:itb_ganecare/screen/app/mainpage/main_page_councelee.dart';
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
  final _formKey = GlobalKey<FormState>();
  String text = '';
  bool isLoading = false;
  int? selectedMoodId;
  // handle mood tracker api
  final MoodTrackerController _moodTrackerController = Get.find();

  String convertFormatTime(DateTime dateTime) {
    return '${dateTime.hour}' + ":" + '${dateTime.minute}';
  }

  String convertDateTime(DateTime dateTime) {
    String month;

    switch (dateTime.month) {
      case 1:
        month = 'Jan';
        break;
      case 2:
        month = 'Feb';
        break;
      case 3:
        month = 'Mar';
        break;
      case 4:
        month = 'Apr';
        break;
      case 5:
        month = 'May';
        break;
      case 6:
        month = 'Jun';
        break;
      case 7:
        month = 'Jul';
        break;
      case 8:
        month = 'Aug';
        break;
      case 9:
        month = 'Sep';
        break;
      case 10:
        month = 'Oct';
        break;
      case 11:
        month = 'Nov';
        break;
      default:
        month = 'Des';
    }

    return '${dateTime.day} ' + month + ' ${dateTime.year} ';
  }

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
                FutureBuilder<dynamic>(
                  future: _moodTrackerController.getMoodTracker(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 1.2,
                          width: double.infinity,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 3,
                          child: ListView.builder(
                            itemCount: snapshot.data.data.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 8,
                                margin: const EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              25,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffC6F0F3),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          convertDateTime(snapshot
                                              .data.data[index].createdAt),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(
                                                20,
                                              ),
                                            ),
                                            image: snapshot.data.data[index]
                                                        .mood ==
                                                    10
                                                ? const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/emotes/a1.png'),
                                                  )
                                                : snapshot.data.data[index]
                                                            .mood ==
                                                        7
                                                    ? const DecorationImage(
                                                        image: AssetImage(
                                                            'assets/emotes/a2.png'),
                                                      )
                                                    : snapshot.data.data[index]
                                                                .mood ==
                                                            5
                                                        ? const DecorationImage(
                                                            image: AssetImage(
                                                                'assets/emotes/a3.png'),
                                                          )
                                                        : snapshot
                                                                    .data
                                                                    .data[index]
                                                                    .mood ==
                                                                3
                                                            ? const DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/emotes/a4.png'),
                                                              )
                                                            : const DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/emotes/a5.png'),
                                                              ),
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                15,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      snapshot.data.data[index]
                                                                  .mood ==
                                                              10
                                                          ? 'Senang sekali'
                                                          : snapshot
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .mood ==
                                                                  7
                                                              ? 'Percaya Diri'
                                                              : snapshot
                                                                          .data
                                                                          .data[
                                                                              index]
                                                                          .mood ==
                                                                      5
                                                                  ? 'Senang'
                                                                  : snapshot.data.data[index]
                                                                              .mood ==
                                                                          3
                                                                      ? 'Kurang senang'
                                                                      : 'Stress',
                                                      style: TextStyle(
                                                        color: snapshot
                                                                    .data
                                                                    .data[index]
                                                                    .mood ==
                                                                10
                                                            ? Colors.green
                                                            : snapshot
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .mood ==
                                                                    7
                                                                ? Colors.blue
                                                                : snapshot
                                                                            .data
                                                                            .data[
                                                                                index]
                                                                            .mood ==
                                                                        5
                                                                    ? Colors
                                                                        .pink
                                                                    : Colors
                                                                        .red,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      convertFormatTime(snapshot
                                                          .data
                                                          .data[index]
                                                          .updatedAt),
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  snapshot
                                                      .data.data[index].text,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 1.2,
                          width: double.infinity,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text('Data kosong'),
                          ),
                        );
                      }
                    } else {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 1.2,
                        width: double.infinity,
                        child: const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),

                // Container(
                //   height: 30.h,
                //   width: double.infinity,
                //   color: const Color.fromRGBO(255, 195, 70, 1),
                //   child: const Center(child: Text('Hari ini,13 Maret 22')),
                // ),
                // Container(
                //   padding: const EdgeInsets.only(left: 5, right: 5),
                //   height: 170.h,
                //   width: double.infinity,
                //   color: Colors.white,
                //   child: ListView(
                //     scrollDirection: Axis.vertical,
                //     children: [
                //       AnotherStepper(
                //         stepperList: stepperData,
                //         stepperDirection: Axis.vertical,
                //         iconWidth:
                //             25, // Height that will be applied to all the stepper icons
                //         iconHeight:
                //             25, // Width that will be applied to all the stepper icons
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   height: 30.h,
                //   width: double.infinity,
                //   color: const Color.fromRGBO(255, 195, 70, 1),
                //   child: const Center(child: Text('Hari ini,12 Januari 22')),
                // ),
                // Container(
                //   padding: const EdgeInsets.only(left: 5, right: 5),
                //   height: 170.h,
                //   width: double.infinity,
                //   color: Colors.white,
                //   child: ListView(
                //     scrollDirection: Axis.vertical,
                //     children: [
                //       AnotherStepper(
                //         stepperList: stepperData,
                //         stepperDirection: Axis.vertical,
                //         iconWidth:
                //             25, // Height that will be applied to all the stepper icons
                //         iconHeight:
                //             25, // Width that will be applied to all the stepper icons
                //       ),
                //     ],
                //   ),
                // ),
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
          showModalBottomSheet<void>(
            isScrollControlled: true,
            isDismissible: false,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: SizedBox(
                    child: Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Mood Tracking',
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedMoodId = null;
                                        });
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  'Bagaimana kabarmu ?',
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          convertDateTime(
                                            DateTime.now(),
                                          ),
                                          style: const TextStyle(
                                              color: Color(0xff03A0D9)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.timer,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          convertFormatTime(
                                            DateTime.now(),
                                          ),
                                          style: const TextStyle(
                                              color: Color(0xff03A0D9)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: mockMood.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Mood mood = mockMood[index];
                                      return CheckboxListTile(
                                        title: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  20,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      mood.moodImage),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                mood.desc,
                                              ),
                                            ),
                                          ],
                                        ),
                                        value:
                                            selectedMoodId == mood.moodemotion,
                                        onChanged: (bool? isChecked) {
                                          setState(() {
                                            if (isChecked != null &&
                                                isChecked) {
                                              selectedMoodId = mood.moodemotion;
                                            } else {
                                              selectedMoodId = null;
                                            }
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Apa yang anda pikirkan ?',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 0.0),
                                    ),
                                  ),
                                  minLines:
                                      6, // any number you need (It works as the rows for the textarea)
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      text = value!;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                isLoading
                                    ? const SpinKitFadingCircle(
                                        size: 40,
                                        color: Colors.blue,
                                      )
                                    : SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                20,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.orange),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ),
                                            ),
                                          ),
                                          child: const Text(
                                            'Simpan',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: () async {
                                            if (selectedMoodId == null ||
                                                selectedMoodId == 0) {
                                              Flushbar(
                                                duration: const Duration(
                                                    milliseconds: 3000),
                                                flushbarPosition:
                                                    FlushbarPosition.TOP,
                                                backgroundColor: Colors.red,
                                                titleText: const Text(
                                                  'Gagal simpan data!',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                messageText: const Text(
                                                  'Belum memilih emotion',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ).show(context);
                                            } else {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                _moodTrackerController
                                                    .postMoodTracker(
                                                  text,
                                                  selectedMoodId.toString(),
                                                  selectedMoodId.toString(),
                                                )
                                                    .then((value) {
                                                  if (value == 200) {
                                                    Navigator.pop(context);
                                                    Get.to(
                                                        const MainPageCouncelee(
                                                            initialPage: 2));
                                                    Flushbar(
                                                      duration: const Duration(
                                                          milliseconds: 3000),
                                                      flushbarPosition:
                                                          FlushbarPosition.TOP,
                                                      backgroundColor:
                                                          Colors.green,
                                                      titleText: const Text(
                                                        'Create Success',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      messageText: const Text(
                                                        'Berhasil menambahkan mood tracker',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ).show(context);

                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                  } else {
                                                    Flushbar(
                                                      duration: const Duration(
                                                          milliseconds: 3000),
                                                      flushbarPosition:
                                                          FlushbarPosition.TOP,
                                                      backgroundColor:
                                                          Colors.red,
                                                      titleText: const Text(
                                                        'Create Failed',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      messageText: const Text(
                                                        'Gagal menambahkan mood tracker',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ).show(context);
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                  }
                                                });
                                              } else {
                                                Flushbar(
                                                  duration: const Duration(
                                                      milliseconds: 3000),
                                                  flushbarPosition:
                                                      FlushbarPosition.TOP,
                                                  backgroundColor: Colors.red,
                                                  titleText: const Text(
                                                    'Gagal simpan data!',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  messageText: const Text(
                                                    'Terdapat form kosong!',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ).show(context);
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
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
