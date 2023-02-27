import 'dart:io';

import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itb_ganecare/data/sharedprefs.dart';
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
  XFile? image;
  bool status = false;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      status = true;
    });
  }

  Future getCamera(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      status = true;
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            getImage(ImageSource.camera);
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.camera,
                          ),
                        ),
                        Text(
                          'Pilih kamera',
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            getImage(ImageSource.gallery);
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.image,
                          ),
                        ),
                        Text(
                          'Pilih galeri',
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Tutup',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final SharedPrefUtils _sharedPreference = SharedPrefUtils();
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
  Widget contentAvatar() {
    String nim = _sharedPreference.getString('nim').toString();
    print(nim);
    return Padding(
      padding: EdgeInsets.only(top: 70.h),
      child: Center(
        child: Column(
          children: [
            (image == null)
                ? Container(
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
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              _showMyDialog();
                            },
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
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
                        fit: BoxFit.cover,
                        image: FileImage(
                          File(
                            image!.path,
                          ),
                        ),
                      ),
                      border: Border.all(
                        color: Colors.white,
                        width: 10,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              _showMyDialog();
                            },
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            SizedBox(
              height: 120.h,
              width: 150.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '#21345',
                    style: TextStyle(
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
                      const Expanded(
                        child: Text(
                          'Anonymous Anonymous Anonymous Anonymous',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _showMyDialog();
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10.h),
                        height: 20.h,
                        width: 40.h,
                        decoration: const BoxDecoration(color: Colors.grey),
                        child: const Center(
                            child: Text(
                          '2017',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10.h),
                        height: 20.h,
                        width: 70.h,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: const Center(
                            child: Text(
                          'Beda jurusan',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10.h),
                        height: 20.h,
                        width: 70.w,
                        child: const Center(
                          child: Text(
                            'Hello world Hello world Hello worldHello world',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            vConselor('Senin'),
            vConselor('Selasa'),
            vConselor('Rabu'),
            // vConsele(),
          ],
        ),
      ),
    );
  }

  Widget vConselor(title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 195, 70, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ExpandablePanel(
              theme: const ExpandableThemeData(crossFadePoint: 0),
              header: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(title),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
              collapsed: const SizedBox(),
              expanded: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 60.w,
                        child: Text('Pagi'),
                      ),
                      SizedBox(
                        width: 10.w,
                        child: Text(':'),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '07:00',
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '08:00',
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '09:00',
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '10:00',
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60.w,
                          child: Text('Siang'),
                        ),
                        SizedBox(
                          width: 10.w,
                          child: Text(':'),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '12:00',
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '13:00',
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '14:00',
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '15:00',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60.w,
                          child: Text('Sore'),
                        ),
                        SizedBox(
                          width: 10.w,
                          child: Text(':'),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '16:00',
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '08:00',
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '17:00',
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '18:00',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget vConsele() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          Container(
            height: 30.h,
            width: double.infinity,
            color: const Color.fromRGBO(255, 195, 70, 1),
            child: const Center(child: Text('Hari ini, Januari 22')),
          ),
          Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            height: 170.h,
            color: Colors.white,
            width: double.infinity,
            child: Center(
              child: AnotherStepper(
                stepperList: stepperData,
                stepperDirection: Axis.vertical,
                iconWidth:
                    25, // Height that will be applied to all the stepper icons
                iconHeight:
                    25, // Width that will be applied to all the stepper icons
              ),
            ),
          ),
        ],
      ),
    );
    // return Container(
    //   height: 245.h,
    //   width: double.infinity,
    //   child: Center(
    //     child: Stepper(
    //       controlsBuilder: (BuildContext context, ControlsDetails controls) {
    //         return Row(
    //           children: <Widget>[
    //             Container(),
    //           ],
    //         );
    //       },
    //       steps: const [
    //         Step(
    //           title: Text('Step 01'),
    //           content: SizedBox(),
    //         ),
    //         Step(
    //           title: Text('Step 01'),
    //           content: SizedBox(),
    //         ),
    //         Step(
    //           title: Text('Step 01'),
    //           content: SizedBox(),
    //         ),
    //       ],
    //       onStepTapped: (int newIndex) {
    //         setState(() {
    //           _currentState = newIndex;
    //         });
    //       },
    //       currentStep: _currentState,
    //       onStepContinue: () {
    //         if (_currentState != 2) {
    //           setState(() {
    //             _currentState += 1;
    //           });
    //         }
    //       },
    //       onStepCancel: () {
    //         if (_currentState != 0) {
    //           setState(() {
    //             _currentState -= 1;
    //           });
    //         }
    //       },
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 75.h,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 171, 233, 1),
                Color.fromRGBO(6, 146, 196, 1),
              ],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 46.w, top: 44.h),
                child: Text(
                  'Profile',
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: const Color.fromRGBO(0, 171, 233, 1),
          ),
          buildHeader(),
          // buildProfileFace(),
          contentAvatar(),
        ],
      ),
      floatingActionButton: buildFloatingActionButton(),
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
          color: const Color.fromRGBO(255, 195, 70, 1),
          width: 1.sw,
          height: 120.h,
        ),
        Container(
          color: Colors.white,
          width: 1.sw,
          height: 160.h,
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
          'Anonymous',
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
      margin: EdgeInsets.only(bottom: 48.h),
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
