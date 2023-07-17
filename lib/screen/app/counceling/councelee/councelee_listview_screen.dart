import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itb_ganecare/data/controllers/counseling_controller.dart';
import 'package:itb_ganecare/data/sharedprefs.dart';
import 'package:itb_ganecare/data_provider/chat_room_utils.dart';
import 'package:itb_ganecare/models/chats.dart';
import 'package:itb_ganecare/models/counseling.dart';

import '../../../../data/controllers/profile_controller.dart';
import '../../../home/home_screen.dart';

class CounceleeListViewScreen extends StatefulWidget {
  const CounceleeListViewScreen({Key? key}) : super(key: key);

  @override
  State<CounceleeListViewScreen> createState() =>
      _CounceleeListViewScreenState();
}

class _CounceleeListViewScreenState extends State<CounceleeListViewScreen> {
  final CounselingController _councelingController = Get.find();
  final FirestoreUtils _firestoreUtils = FirestoreUtils();

  final RxList<String> isPending = <String>[].obs;
  final RxList<String> isRejected = <String>[].obs;

  final ProfileController _profileController = Get.find();
  final SharedPrefUtils _sharedPreference = SharedPrefUtils();
  String profilePicture = '';

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
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            buildHeader(context),
            buildCounselorWidget(context),
            // buildListCounselor(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 6,
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
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
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Hi, ',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            _sharedPreference
                                    .getString('nickname')
                                    .toString()
                                    .contains('Konselee')
                                ? _sharedPreference
                                    .getString('nickname')
                                    .toString()
                                : 'Konselee',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Pilih',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Pendamping Sebaya',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                (profilePicture != '')
                    ? Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(profilePicture),
                          ),
                        ),
                      )
                    : Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/cat.png'),
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder buildCounselorWidget(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _councelingController.postPeerCounselor(
        'Teknik Lingkungan',
        '2019',
        'P',
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Counselor> councelorList = snapshot.data.data;

            return Column(
              children: [
                buildListCounselor(context, councelorList),
                buildListRequest(context),
              ],
            );
          } else {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: const Text('No counselor listed yet :('),
              ),
            );
          }
        } else {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: const Text('No counselor listed yet :('),
            ),
          );
        }
      },
    );
  }

  Widget buildListCounselor(
    BuildContext context,
    List<Counselor> councelorList,
  ) {
    if (councelorList.isNotEmpty) {
      String jurusan = _sharedPreference.getString('major').toString();
      String angkatan = _sharedPreference.getInt('angkatan').toString();
      String gender = _sharedPreference.getString('gender').toString();
      String name = _sharedPreference.getString('name').toString();
      String currentUserId =
          _sharedPreference.getString('councelee_id').toString();

      return Container(
        width: 1.sw,
        height: MediaQuery.of(context).size.height / 2.5,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 15,
              ),
              child: Row(
                children: [
                  Text(
                    'Pilih',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Pendamping',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              itemCount: councelorList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _firestoreUtils.createNewRoom(
                      gender,
                      councelorList[index].gender,
                      angkatan,
                      councelorList[index].angkatan.toString(),
                      currentUserId,
                      councelorList[index].counselorId.toString(),
                      jurusan,
                      councelorList[index].jurusan.toString(),
                      name,
                      councelorList[index].counselorName,
                    );

                    Get.snackbar(
                      'Counselee',
                      'Counseling request sent!',
                    );
                  },
                  child: Container(
                    width: 1.sw,
                    height: 80.h,
                    padding: EdgeInsets.all(8.w),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                'assets/images/cat.png',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Row(
                                  children: [
                                    Text(
                                      'Anonymous',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      softWrap: true,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    councelorList[index].gender.toString() ==
                                            'P'
                                        ? const Icon(
                                            Icons.female,
                                            color: Colors.pinkAccent,
                                            size: 15,
                                          )
                                        : const Icon(
                                            Icons.male,
                                            color: Colors.blueAccent,
                                            size: 15,
                                          ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Row(
                                  children: [
                                    Text(
                                      '#${councelorList[index].counselorId}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '-',
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '${councelorList[index].angkatan}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '-',
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      councelorList[index]
                                              .jurusan
                                              .contains('Tahap Tahun Pertama')
                                          ? councelorList[index]
                                              .jurusan
                                              .substring(20)
                                          : councelorList[index]
                                                  .jurusan
                                                  .contains('Tahap Tahun Kedua')
                                              ? councelorList[index]
                                                  .jurusan
                                                  .substring(18)
                                              : councelorList[index]
                                                      .jurusan
                                                      .contains(
                                                          'Tahap Tahun Ketiga')
                                                  ? councelorList[index]
                                                      .jurusan
                                                      .substring(19)
                                                  : councelorList[index]
                                                          .jurusan
                                                          .contains(
                                                              'Tahap Tahun Keempat')
                                                      ? councelorList[index]
                                                          .jurusan
                                                          .substring(20)
                                                      : councelorList[index]
                                                          .jurusan,
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.more_horiz,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: const Text('No counselor listed yet :('),
        ),
      );
    }
  }

  StreamBuilder buildListRequest(BuildContext context) {
    List<Rooms> rooms = [];
    List<Rooms> temp = [];

    return StreamBuilder<List<Rooms>>(
      stream: _firestoreUtils.getLiveChatRoom(),
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasData) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            rooms = snap.data;

            if (temp.isNotEmpty) temp.clear();
            for (final r in rooms) {
              if (r.roomStatus == 'request' || r.roomStatus == 'pending') {
                temp.add(r);
              }
            }

            return Container(
              color: Colors.white,
              padding: EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: Row(
                      children: [
                        Text(
                          'Pending',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Request',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: temp.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 1.sw,
                            height: 80.h,
                            padding: EdgeInsets.all(8.w),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white,
                                    image: const DecorationImage(
                                      image:
                                          AssetImage('assets/images/cat.png'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Anonymous',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              softWrap: true,
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            temp[index]
                                                        .genderConselor
                                                        .toString() ==
                                                    'P'
                                                ? const Icon(
                                                    Icons.female,
                                                    color: Colors.pinkAccent,
                                                    size: 15,
                                                  )
                                                : const Icon(
                                                    Icons.male,
                                                    color: Colors.blueAccent,
                                                    size: 15,
                                                  ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Row(
                                          children: [
                                            Text(
                                              '#${temp[index].idConselor}',
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              '-',
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              rooms[index].generationConselor,
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              '-',
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              temp[index]
                                                      .majorConselor
                                                      .contains(
                                                          'Tahap Tahun Pertama')
                                                  ? temp[index]
                                                      .majorConselor
                                                      .substring(20)
                                                  : temp[index]
                                                          .majorConselor
                                                          .contains(
                                                              'Tahap Tahun Kedua')
                                                      ? temp[index]
                                                          .majorConselor
                                                          .substring(18)
                                                      : temp[index]
                                                              .majorConselor
                                                              .contains(
                                                                  'Tahap Tahun Ketiga')
                                                          ? temp[index]
                                                              .majorConselor
                                                              .substring(19)
                                                          : temp[index]
                                                                  .majorConselor
                                                                  .contains(
                                                                      'Tahap Tahun Keempat')
                                                              ? temp[index]
                                                                  .majorConselor
                                                                  .substring(20)
                                                              : temp[index]
                                                                  .majorConselor,
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.blueAccent,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        } else {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: const Text('No pending request'),
            ),
          );
        }
      },
    );
  }
}
