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
  String angkatan = '';
  String nim = '';
  String gender = '';
  String jurusan = '';
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
            print(value);
            profilePicture = value['data']['conselee']['profilepic_image'];
            idReg = value['data']['conselee']['register_id'];
            about = value['data']['conselee']['about'];
            nickName = value['data']['conselee']['name'];
            angkatan = value['data']['conselee']['angkatan'].toString();
            nim = value['data']['conselee']['nim'].toString();
            gender = value['data']['conselee']['gender'];
            jurusan = value['data']['conselee']['jurusan'];
            role = value['data']['conselee']['role'];
          })
        });
  }

  Widget navHeader() {
    return Container(
      height: MediaQuery.of(context).size.height / 15,
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: MediaQuery.of(context).size.height / 15,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(
                      isDarkMode: false,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.close),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 15,
              child: const Center(
                child: Text(
                  'Profile Page',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 50,
            height: MediaQuery.of(context).size.height / 15,
            child: IconButton(
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
              icon: Icon(
                Icons.edit,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            offset: Offset(0, 1), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 4,
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 6,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: AssetImage('assets/icons/profil.png'),
                    ),
                  ),
                ),
                Text(
                  (nim != '') ? nim : 'not found!',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      overflow: TextOverflow.ellipsis),
                ),
                Text(
                  (nickName != '') ? nickName : 'Anonymous',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 5.5,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 10,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Angkatan',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            (angkatan != '') ? angkatan : 'not found!',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Jurusan',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            (jurusan.length > 10)
                                ? jurusan.substring(20, 25)
                                : 'not found!',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Jenis Kelamin',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            (gender == 'L') ? 'Pria' : 'Wanita',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 10,
                    child: Column(
                      children: [
                        const Text(
                          'Bio',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          (about != "") ? about : "-",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navContent() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 20,
      child: const Text(
        'Mood Tracker',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget content() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      width: MediaQuery.of(context).size.height / 1,
      height: MediaQuery.of(context).size.height / 4,
      child: FutureBuilder<dynamic>(
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
            } else if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 4,
                child: ListView.builder(
                    itemCount: snapshot.data.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return contentData(
                        index,
                        snapshot.data.data[index].text,
                        snapshot.data.data[index].mood.toString(),
                        snapshot.data.data[index].emotion.toString(),
                        convertDateTime(snapshot.data.data[index].createdAt),
                      );
                    }),
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
    );
  }

  Widget contentData(
    int index,
    String text,
    String mood,
    String emotion,
    String date,
  ) {
    return Container(
      margin: EdgeInsets.only(left: (index == 0) ? 0 : 10),
      width: MediaQuery.of(context).size.width / 2.5,
      height: MediaQuery.of(context).size.height / 4,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            offset: Offset(0, 1), // Shadow position
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Icon(
              Icons.pentagon,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            date,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            text,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              navHeader(),
              header(),
              navContent(),
              content(),
            ],
          ),
        ),
        floatingActionButton: buildFloatingActionButton(),
      ),
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
