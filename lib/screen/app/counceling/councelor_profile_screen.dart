import 'dart:io';

import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itb_ganecare/data/controllers/jadwal_conselor_controller.dart';
import 'package:itb_ganecare/data/sharedprefs.dart';
import 'package:itb_ganecare/screen/app/counceling/concelor_edit_profile_screen.dart';

import '../../../data/controllers/profile_controller.dart';
import '../../home/home_screen.dart';

class CouncelorProfileScreen extends StatefulWidget {
  const CouncelorProfileScreen({Key? key}) : super(key: key);

  @override
  State<CouncelorProfileScreen> createState() => _CouncelorProfileScreenState();
}

class _CouncelorProfileScreenState extends State<CouncelorProfileScreen> {
  final JadwalConselorController _jadwalConselorController = Get.find();
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

  final ProfileController _profileController = Get.find();
  final SharedPrefUtils _sharedPreference = SharedPrefUtils();
  String profilePicture = '';
  String idReg = '';
  String about = '';
  String nickName = '';
  String angkatan = '';
  String nim = '';
  String jurusan = '';
  String gender = '';
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
            profilePicture = value['data']['conselor']['profilepic_image'];
            idReg = value['data']['conselor']['register_id'];
            about = value['data']['conselor']['about'];
            nickName = value['data']['conselor']['nickname'];
            role = value['data']['conselor']['role'];
            angkatan = value['data']['conselor']['angkatan'].toString();
            nim = value['data']['conselor']['nim'].toString();
            jurusan = value['data']['conselor']['jurusan'];
            gender = value['data']['conselor']['gender'];
          })
        });
  }

  List<String> dataTime = [
    "07.00",
    "08.00",
    "09.00",
    "10.00",
    "11.00",
    "12.00",
    "13.00",
    "14.00",
    "15.00",
    "16.00",
    "17.00",
    "18.00",
    "19.00",
    "20.00",
    "21.00",
  ];

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
                        width: 70.w,
                        child: Center(
                          child: Text(
                            (about != '') ? about : 'Anonymous',
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
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    children: [
                      vConselorSenin(),
                      vConselorSelasa(),
                      vConselorRabu(),
                      vConselorKamis(),
                      vConselorJumat(),
                      vConselorSabtu(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
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
                  builder: (context) => ConcelorEditProfileScreen(
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

  Widget vConselorSenin() {
    return FutureBuilder<dynamic>(
      future: _jadwalConselorController.getJadwal(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              width: double.infinity,
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            // List From Api Data
            List<int> indexFirst = snapshot.data.data.senin.sublist(0, 5);
            List<int> indexSecond = snapshot.data.data.senin.sublist(5, 10);
            List<int> indexThird = snapshot.data.data.senin.sublist(10, 15);
            // List jam statuc
            List<String> splitFirst = dataTime.sublist(0, 5);
            List<String> splitSecond = dataTime.sublist(5, 10);
            List<String> splitThrid = dataTime.sublist(10, 15);
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(crossFadePoint: 0),
                  header: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Senin",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
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
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              'Pagi',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: MediaQuery.of(context).size.height / 15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: indexFirst
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    decoration: BoxDecoration(
                                                        color: (e == 0)
                                                            ? Colors.white
                                                            : Colors
                                                                .amberAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: splitFirst
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Center(
                                                        child:
                                                            Text(e.toString())),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              'Siang',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: MediaQuery.of(context).size.height / 15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: indexSecond
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    decoration: BoxDecoration(
                                                        color: (e == 0)
                                                            ? Colors.white
                                                            : Colors
                                                                .amberAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: splitSecond
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Center(
                                                        child:
                                                            Text(e.toString())),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              'Sore',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: MediaQuery.of(context).size.height / 15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: indexThird
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    decoration: BoxDecoration(
                                                        color: (e == 0)
                                                            ? Colors.white
                                                            : Colors
                                                                .amberAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: splitThrid
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Center(
                                                        child:
                                                            Text(e.toString())),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              width: double.infinity,
              child: const Align(
                alignment: Alignment.center,
                child: Text('Data kosong'),
              ),
            );
          }
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            width: double.infinity,
            child: const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          );
        }
      },
    );
  }

  Widget vConselorSelasa() {
    return FutureBuilder<dynamic>(
      future: _jadwalConselorController.getJadwal(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              width: double.infinity,
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<int> indexFirst = snapshot.data.data.selasa.sublist(0, 5);
            List<int> indexSecond = snapshot.data.data.selasa.sublist(5, 10);
            List<int> indexThird = snapshot.data.data.selasa.sublist(10, 15);
            // List jam statuc
            List<String> splitFirst = dataTime.sublist(0, 5);
            List<String> splitSecond = dataTime.sublist(5, 10);
            List<String> splitThrid = dataTime.sublist(10, 15);
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(crossFadePoint: 0),
                  header: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Selasa",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
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
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              'Pagi',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: MediaQuery.of(context).size.height / 15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: indexFirst
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    decoration: BoxDecoration(
                                                        color: (e == 0)
                                                            ? Colors.white
                                                            : Colors
                                                                .amberAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: splitFirst
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Center(
                                                        child:
                                                            Text(e.toString())),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              'Siang',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: MediaQuery.of(context).size.height / 15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: indexSecond
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    decoration: BoxDecoration(
                                                        color: (e == 0)
                                                            ? Colors.white
                                                            : Colors
                                                                .amberAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: splitSecond
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Center(
                                                        child:
                                                            Text(e.toString())),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              'Sore',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: MediaQuery.of(context).size.height / 15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: indexThird
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    decoration: BoxDecoration(
                                                        color: (e == 0)
                                                            ? Colors.white
                                                            : Colors
                                                                .amberAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: splitThrid
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Center(
                                                        child:
                                                            Text(e.toString())),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              width: double.infinity,
              child: const Align(
                alignment: Alignment.center,
                child: Text('Data kosong'),
              ),
            );
          }
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            width: double.infinity,
            child: const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          );
        }
      },
    );
  }

  Widget vConselorRabu() {
    return FutureBuilder<dynamic>(
      future: _jadwalConselorController.getJadwal(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              width: double.infinity,
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<int> indexFirst = snapshot.data.data.rabu.sublist(0, 5);
            List<int> indexSecond = snapshot.data.data.rabu.sublist(5, 10);
            List<int> indexThird = snapshot.data.data.rabu.sublist(10, 15);
            // List jam statuc
            List<String> splitFirst = dataTime.sublist(0, 5);
            List<String> splitSecond = dataTime.sublist(5, 10);
            List<String> splitThrid = dataTime.sublist(10, 15);
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(crossFadePoint: 0),
                  header: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Rabu",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
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
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              'Pagi',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: MediaQuery.of(context).size.height / 15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: indexFirst
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    decoration: BoxDecoration(
                                                        color: (e == 0)
                                                            ? Colors.white
                                                            : Colors
                                                                .amberAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: splitFirst
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Center(
                                                        child:
                                                            Text(e.toString())),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              'Siang',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: MediaQuery.of(context).size.height / 15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: indexSecond
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    decoration: BoxDecoration(
                                                        color: (e == 0)
                                                            ? Colors.white
                                                            : Colors
                                                                .amberAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: splitSecond
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Center(
                                                        child:
                                                            Text(e.toString())),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              'Sore',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: MediaQuery.of(context).size.height / 15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: indexThird
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    decoration: BoxDecoration(
                                                        color: (e == 0)
                                                            ? Colors.white
                                                            : Colors
                                                                .amberAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: splitThrid
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Center(
                                                        child:
                                                            Text(e.toString())),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              width: double.infinity,
              child: const Align(
                alignment: Alignment.center,
                child: Text('Data kosong'),
              ),
            );
          }
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            width: double.infinity,
            child: const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          );
        }
      },
    );
  }

  Widget vConselorKamis() {
    return FutureBuilder<dynamic>(
      future: _jadwalConselorController.getJadwal(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              width: double.infinity,
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<int> indexFirst = snapshot.data.data.kamis.sublist(0, 5);
            List<int> indexSecond = snapshot.data.data.kamis.sublist(5, 10);
            List<int> indexThird = snapshot.data.data.kamis.sublist(10, 15);
            // List jam statuc
            List<String> splitFirst = dataTime.sublist(0, 5);
            List<String> splitSecond = dataTime.sublist(5, 10);
            List<String> splitThrid = dataTime.sublist(10, 15);
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(crossFadePoint: 0),
                  header: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Kamis",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
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
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              'Pagi',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: MediaQuery.of(context).size.height / 15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: indexFirst
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    decoration: BoxDecoration(
                                                        color: (e == 0)
                                                            ? Colors.white
                                                            : Colors
                                                                .amberAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: splitFirst
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Center(
                                                        child:
                                                            Text(e.toString())),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              'Siang',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: MediaQuery.of(context).size.height / 15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: indexSecond
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    decoration: BoxDecoration(
                                                        color: (e == 0)
                                                            ? Colors.white
                                                            : Colors
                                                                .amberAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: splitSecond
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Center(
                                                        child:
                                                            Text(e.toString())),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              'Sore',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: MediaQuery.of(context).size.height / 15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: indexThird
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    decoration: BoxDecoration(
                                                        color: (e == 0)
                                                            ? Colors.white
                                                            : Colors
                                                                .amberAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: splitThrid
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Center(
                                                        child:
                                                            Text(e.toString())),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              width: double.infinity,
              child: const Align(
                alignment: Alignment.center,
                child: Text('Data kosong'),
              ),
            );
          }
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            width: double.infinity,
            child: const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          );
        }
      },
    );
  }

  Widget vConselorJumat() {
    return FutureBuilder<dynamic>(
      future: _jadwalConselorController.getJadwal(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 10,
              width: double.infinity,
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<int> indexFirst = snapshot.data.data.jumat.sublist(0, 5);
            List<int> indexSecond = snapshot.data.data.jumat.sublist(5, 10);
            List<int> indexThird = snapshot.data.data.jumat.sublist(10, 15);
            // List jam statuc
            List<String> splitFirst = dataTime.sublist(0, 5);
            List<String> splitSecond = dataTime.sublist(5, 10);
            List<String> splitThrid = dataTime.sublist(10, 15);
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(crossFadePoint: 0),
                  header: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "jumat",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
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
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              'Pagi',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: MediaQuery.of(context).size.height / 15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: indexFirst
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    decoration: BoxDecoration(
                                                        color: (e == 0)
                                                            ? Colors.white
                                                            : Colors
                                                                .amberAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: splitFirst
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Center(
                                                        child:
                                                            Text(e.toString())),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              'Siang',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: MediaQuery.of(context).size.height / 15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: indexSecond
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    decoration: BoxDecoration(
                                                        color: (e == 0)
                                                            ? Colors.white
                                                            : Colors
                                                                .amberAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: splitSecond
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Center(
                                                        child:
                                                            Text(e.toString())),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              'Sore',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: MediaQuery.of(context).size.height / 15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: indexThird
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    decoration: BoxDecoration(
                                                        color: (e == 0)
                                                            ? Colors.white
                                                            : Colors
                                                                .amberAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: splitThrid
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Center(
                                                        child:
                                                            Text(e.toString())),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 10,
              width: double.infinity,
              child: const Align(
                alignment: Alignment.center,
                child: Text('Data kosong'),
              ),
            );
          }
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 10,
            width: double.infinity,
            child: const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          );
        }
      },
    );
  }

  Widget vConselorSabtu() {
    return FutureBuilder<dynamic>(
      future: _jadwalConselorController.getJadwal(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 10,
              width: double.infinity,
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<int> indexFirst = snapshot.data.data.sabtu.sublist(0, 5);
            List<int> indexSecond = snapshot.data.data.sabtu.sublist(5, 10);
            List<int> indexThird = snapshot.data.data.sabtu.sublist(10, 15);
            // List jam statuc
            List<String> splitFirst = dataTime.sublist(0, 5);
            List<String> splitSecond = dataTime.sublist(5, 10);
            List<String> splitThrid = dataTime.sublist(10, 15);
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(crossFadePoint: 0),
                  header: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "sabtu",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
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
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              'Pagi',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: MediaQuery.of(context).size.height / 15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: indexFirst
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    decoration: BoxDecoration(
                                                        color: (e == 0)
                                                            ? Colors.white
                                                            : Colors
                                                                .amberAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: splitFirst
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Center(
                                                        child:
                                                            Text(e.toString())),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              'Siang',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: MediaQuery.of(context).size.height / 15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: indexSecond
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    decoration: BoxDecoration(
                                                        color: (e == 0)
                                                            ? Colors.white
                                                            : Colors
                                                                .amberAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: splitThrid
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Center(
                                                        child:
                                                            Text(e.toString())),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              'Sore',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: MediaQuery.of(context).size.height / 15,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: indexThird
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    decoration: BoxDecoration(
                                                        color: (e == 0)
                                                            ? Colors.white
                                                            : Colors
                                                                .amberAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        children: [
                                          Row(
                                            children: splitThrid
                                                .map(
                                                  (e) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Center(
                                                        child:
                                                            Text(e.toString())),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 10,
              width: double.infinity,
              child: const Align(
                alignment: Alignment.center,
                child: Text('Data kosong'),
              ),
            );
          }
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 10,
            width: double.infinity,
            child: const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          );
        }
      },
    );
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
                    builder: (context) => ConcelorEditProfileScreen(
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
                      children: const [
                        Text(
                          'Bio',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                          style: TextStyle(
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
        'Jadwal Concelor',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget content() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 1.2,
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 50,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            vConselorSenin(),
            vConselorSelasa(),
            vConselorRabu(),
            vConselorKamis(),
            vConselorJumat(),
            vConselorSabtu(),
          ],
        ),
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
