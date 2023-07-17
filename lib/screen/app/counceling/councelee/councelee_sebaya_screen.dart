import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itb_ganecare/data/sharedprefs.dart';
import 'package:itb_ganecare/data_provider/chat_room_utils.dart';
import 'package:itb_ganecare/models/chats.dart';
import 'package:itb_ganecare/screen/app/counceling/councelee/councelee_listview_screen.dart';
import 'package:itb_ganecare/screen/app/counceling/counceling_chat_screen.dart';
import 'package:itb_ganecare/screen/app/counceling/counceling_profile_screen.dart';

import '../../../../data/controllers/profile_controller.dart';
import '../../../home/home_screen.dart';

class CounceleeSebayaScreen extends StatefulWidget {
  const CounceleeSebayaScreen({Key? key}) : super(key: key);

  @override
  State<CounceleeSebayaScreen> createState() => _CounceleeSebayaScreenState();
}

class _CounceleeSebayaScreenState extends State<CounceleeSebayaScreen> {
  final GlobalKey scaffoldKey = GlobalKey();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages.elementAt(currentIndex),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Widget bottomNavBar() {
    return Container(
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
      child: BottomNavigationBar(
        elevation: 0,
        currentIndex: currentIndex,
        onTap: _onIconTapped,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black45,
        selectedItemColor: Colors.blueAccent,
        items: [
          BottomNavigationBarItem(
            label: 'Pesan',
            icon: Image.asset('assets/images/chat_fill.png'),
            activeIcon: Image.asset(
              'assets/images/chat_fill_active.png',
            ),
          ),
          BottomNavigationBarItem(
            label: 'Cari Councelor',
            icon: Image.asset('assets/images/chat_search_fill.png'),
            activeIcon: Image.asset(
              'assets/images/chat_search_fill_active.png',
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Image.asset('assets/images/user_box_fill.png'),
          ),
        ],
      ),
    );
  }

  void _onIconTapped(int index) => setState(() => currentIndex = index);

  static List<Widget> pages = [
    const CounceleeSebayaViews(),
    const CounceleeListViewScreen(),
    const CouncelingProfileScreen(),
  ];
}

class CounceleeSebayaViews extends StatefulWidget {
  const CounceleeSebayaViews({Key? key}) : super(key: key);

  @override
  State<CounceleeSebayaViews> createState() => _CounceleeSebayaViewsState();
}

class _CounceleeSebayaViewsState extends State<CounceleeSebayaViews> {
  // final CounselingController _councelingController = Get.find();
  final FirestoreUtils _firestoreUtils = FirestoreUtils();

  final RxList<String> isApproved = <String>[].obs;

  final RxList<String> isEnded = <String>[].obs;

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
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildHeader(context),
            buildCouncelee(context),
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
                            'Daftar Pendamping',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Sebaya Kamu',
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
                // Container(
                //   width: 50,
                //   height: 50,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(50),
                //   ),
                // ),
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

  StreamBuilder buildCouncelee(BuildContext context) {
    List<Rooms> rooms = [];

    return StreamBuilder<List<Rooms>>(
      stream: _firestoreUtils.getLiveChatRoom(),
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasData) {
          if (snap.connectionState == ConnectionState.waiting) {
            return SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.5,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            );
          } else {
            rooms = snap.data;
            // log(rooms.toString(), name: 'log-dataset');

            return Column(
              children: [
                buildListWidget(rooms),
                buildHistoryList(rooms),
              ],
            );
          }
        } else {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: const Text('No chat history'),
            ),
          );
        }
      },
    );
  }

  // StreamBuilder buildCouncelee(BuildContext context) {
  Widget buildListWidget(List<Rooms> rooms) {
    String currentUserId =
        _sharedPreference.getString('councelee_id').toString();

    if (rooms.isNotEmpty) {
      List<Rooms> temp = [];

      if (temp.isNotEmpty) temp.clear();

      for (final r in rooms) {
        if (r.roomStatus == 'approved' || r.roomStatus == 'approve') {
          temp.add(r);
        }
      }

      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 15,
              ),
              child: Row(
                children: [
                  Text(
                    'Pinned',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Message',
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
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2.5,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: temp.length,
                itemBuilder: (context, index) {
                  if (temp[index].idConselee.toString() == currentUserId) {
                    return GestureDetector(
                      onTap: () {
                        // log('Logged ee: ${temp[index].idConselee} - or: ${temp[index].idConselor}');

                        _sharedPreference.putString(
                          'roomId',
                          temp[index].id,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CouncelingChatScreen(
                                conseleeId: temp[index].idConselee,
                                conselorId: temp[index].idConselor,
                                currentId: currentUserId,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: 1.sw,
                        height: 80.h,
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
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
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                        temp[index].genderConselor.toString() ==
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
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      temp[index].lastMessageConselor,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      softWrap: true,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.more_horiz,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                // Text(
                                //   temp[index].generationConselor,
                                //   style: GoogleFonts.poppins(
                                //     color: Colors.blueAccent,
                                //     fontSize: 12,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                // Text(
                                //   temp[index]
                                //           .majorConselor
                                //           .contains('Tahap Tahun Pertama')
                                //       ? temp[index].majorConselor.substring(20)
                                //       : temp[index]
                                //               .majorConselor
                                //               .contains('Tahap Tahun Kedua')
                                //           ? temp[index]
                                //               .majorConselor
                                //               .substring(18)
                                //           : temp[index]
                                //                   .majorConselor
                                //                   .contains('Tahap Tahun Ketiga')
                                //               ? temp[index]
                                //                   .majorConselor
                                //                   .substring(19)
                                //               : temp[index]
                                //                       .majorConselor
                                //                       .contains(
                                //                           'Tahap Tahun Keempat')
                                //                   ? temp[index]
                                //                       .majorConselor
                                //                       .substring(20)
                                //                   : temp[index].majorConselor,
                                //   style: GoogleFonts.poppins(
                                //     color: Colors.blueAccent,
                                //     fontSize: 12,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: const Text('No chat history'),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: const Text('No chat history'),
        ),
      );
    }
  }

  // Widget buildCounceleeWidget(
  Widget buildHistoryList(List<Rooms> rooms) {
    String currentUserId =
        _sharedPreference.getString('councelee_id').toString();

    if (rooms.isNotEmpty) {
      List<Rooms> temp = [];

      if (temp.isNotEmpty) temp.clear();

      for (final r in rooms) {
        if (r.roomStatus == 'ended' || r.roomStatus == 'closed') temp.add(r);
      }

      return Container(
        color: Colors.white,
        width: 1.sw,
        padding: EdgeInsets.only(bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Text(
                    'History',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Conceling',
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
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2.5,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: temp.length,
                itemBuilder: (context, index) {
                  if (temp[index].idConselee.toString() == currentUserId) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 1.sw,
                        height: 80.h,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/cat.png'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        temp[index].genderConselor.toString() ==
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
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      temp[index].lastMessageConselor,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      softWrap: true,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
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
                            // Column(
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Text(
                            //           temp[index].genderConselor,
                            //           style: TextStyle(
                            //             backgroundColor:
                            //                 Colors.grey.withOpacity(0.4),
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w500,
                            //             fontSize: 9.sp,
                            //           ),
                            //         ),
                            //         SizedBox(width: 2.w),
                            //         Text(
                            //           temp[index]
                            //                   .majorConselor
                            //                   .contains('Tahap Tahun Pertama')
                            //               ? temp[index]
                            //                   .majorConselor
                            //                   .substring(20)
                            //               : temp[index]
                            //                       .majorConselor
                            //                       .contains('Tahap Tahun Kedua')
                            //                   ? temp[index]
                            //                       .majorConselor
                            //                       .substring(18)
                            //                   : temp[index]
                            //                           .majorConselor
                            //                           .contains(
                            //                               'Tahap Tahun Ketiga')
                            //                       ? temp[index]
                            //                           .majorConselor
                            //                           .substring(19)
                            //                       : temp[index]
                            //                               .majorConselor
                            //                               .contains(
                            //                                   'Tahap Tahun Keempat')
                            //                           ? temp[index]
                            //                               .majorConselor
                            //                               .substring(20)
                            //                           : temp[index].majorConselor,
                            //           style: TextStyle(
                            //             backgroundColor:
                            //                 Colors.grey.withOpacity(0.4),
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w500,
                            //             fontSize: 9.sp,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: const Text('No chat history'),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'History Counseling',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: const Text('No chat history'),
            ),
          ],
        ),
      );
    }
  }
}
