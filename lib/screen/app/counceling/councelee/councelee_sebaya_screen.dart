import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/controllers/counseling_controller.dart';
import 'package:itb_ganecare/data/sharedprefs.dart';
import 'package:itb_ganecare/data_provider/chat_room_utils.dart';
import 'package:itb_ganecare/models/chats.dart';
import 'package:itb_ganecare/models/counseling.dart';
import 'package:itb_ganecare/screen/app/counceling/councelee/councelee_listview_screen.dart';
import 'package:itb_ganecare/screen/app/counceling/counceling_chat_screen.dart';
import 'package:itb_ganecare/screen/app/counceling/counceling_profile_screen.dart';

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

  void _onIconTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  static List<Widget> pages = [
    CounceleeSebayaViews(),
    const CounceleeListViewScreen(),
    const CouncelingProfileScreen(),
  ];
}

class CounceleeSebayaViews extends StatelessWidget {
  CounceleeSebayaViews({Key? key}) : super(key: key);

  final SharedPrefUtils _sharedPreference = SharedPrefUtils();
  final CounselingController _councelingController = Get.find();
  final FirestoreUtils _firestoreUtils = FirestoreUtils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80.h,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Icon(Icons.close, color: Colors.white),
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
          child: Container(
            margin: EdgeInsets.only(left: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        'Selamat datang',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      margin: EdgeInsets.only(top: 40.h, left: 24.w),
                    ),
                    Container(
                      child: Text(
                        'Developer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      margin: EdgeInsets.only(top: 4.h, left: 24.w),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: 42.h),
                        child: Icon(
                          Icons.notifications_rounded,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 44.w,
                      margin: EdgeInsets.only(right: 24.w, top: 32.h),
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
                            blurRadius: 8,
                            offset: const Offset(3, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset('assets/images/cat.png'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          buildHeader(context),
          buildCouncelee(context),
          // buildHistoryCounceling(context),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 52.h,
      color: const Color.fromRGBO(253, 143, 1, 1),
      child: Padding(
        padding: EdgeInsets.only(top: 16.h, bottom: 16.h, left: 16.w),
        child: Text(
          'Daftar Pendamping Sebaya Kamu',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  StreamBuilder buildCouncelee(BuildContext context) {
    String nim = _sharedPreference.getString('nim').toString();
    String name = _sharedPreference.getString('name').toString();

    List<String> roomIds = [];
    List<String> lastMessages = [];
    List<bool> isReads = [];
    List<Rooms> rooms = [];
    List<int> counseleeIds = [];
    List<int> counselorIds = [];

    return StreamBuilder<List<Rooms>>(
        stream: _firestoreUtils.getLiveChatRoom(),
        initialData: const [],
        builder: (context, AsyncSnapshot snap) {
          if (snap.hasData) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              if (snap.data.isNotEmpty) {
                rooms = snap.data;

                for (final data in rooms) {
                  if (roomIds.isNotEmpty) roomIds.clear();
                  roomIds.add(data.id);

                  if (counselorIds.isNotEmpty) counselorIds.clear();
                  counselorIds.add(data.idConselor);

                  if (counseleeIds.isNotEmpty) counseleeIds.clear();
                  counseleeIds.add(data.idConselee);

                  _firestoreUtils.getLiveChat(data.id).listen((event) {
                    _firestoreUtils.chatList = event;

                    for (final texts in event) {
                      if (lastMessages.isNotEmpty) lastMessages.clear();
                      lastMessages.add(texts.message);

                      // if (isReads.isNotEmpty) isReads.clear();
                      isReads.add(texts.isRead);
                    }
                  });
                }
              }
            }
          }

          return FutureBuilder<dynamic>(
            future: Future.delayed(
              const Duration(seconds: 2),
              () => _councelingController.postPeerCounselee(nim, name),
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<Counselee> dataset = snapshot.data.data;
                  log(isReads.toString(), name: 'log-dataset');

                  if (rooms.isNotEmpty) {
                    return Column(
                      children: [
                        buildCounceleeWidget(
                          dataset,
                          rooms,
                          roomIds,
                          lastMessages,
                          counseleeIds,
                          counselorIds,
                          snap.data.roomStatus,
                        ),
                        buildHistoryCounceling(
                          context,
                          dataset,
                          rooms,
                          roomIds,
                          lastMessages,
                          counseleeIds,
                          counselorIds,
                          snap.data.roomStatus,
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: const Text('No chat history'),
                      ),
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
        });
  }

  Widget buildCounceleeWidget(
    List<Counselee> dataset,
    List<Rooms> rooms,
    List<String> roomIds,
    List<String> lastMessages,
    List<int> counseleeIds,
    List<int> counselorIds,
    String status,
  ) {
    if (status == 'approved') {
      return SizedBox(
        width: 1.sw,
        height: 260.h,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: rooms.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                log('Logged ${dataset[index].counseleeId}');

                _sharedPreference.putString(
                  'roomId',
                  roomIds[index],
                );

                if (_firestoreUtils.chatList.isEmpty) {
                  Get.snackbar('Chat', 'Belum ada histori pesan');
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CouncelingChatScreen(
                          conseleeId: counseleeIds[index],
                          conselorId: counselorIds[index],
                        );
                      },
                    ),
                  );
                }
              },
              child: Card(
                child: Container(
                  width: 1.sw,
                  height: 80.h,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  padding: EdgeInsets.all(8.w),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Image.asset(
                          'assets/images/cat.png',
                          width: 46.w,
                          height: 46.h,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              dataset[index].gender.toString() == 'P'
                                  ? const Icon(
                                      Icons.female,
                                      color: Colors.pinkAccent,
                                    )
                                  : const Icon(
                                      Icons.male,
                                      color: Colors.blueAccent,
                                    ),
                              Text(
                                'Anonymous',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: true,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Padding(
                            padding: EdgeInsets.only(left: 8.h),
                            child: Text(
                              lastMessages[index],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 24.w),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                '${dataset[index].angkatan}',
                                style: TextStyle(
                                  backgroundColor: Colors.grey.withOpacity(0.4),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 8.sp,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                dataset[index].jurusan,
                                style: TextStyle(
                                  backgroundColor: Colors.grey.withOpacity(0.4),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 8.sp,
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
          },
        ),
      );
    } else {
      return SizedBox(width: 1.sw, height: 260.h);
    }
  }

  Widget buildHistoryCounceling(
    BuildContext context,
    List<Counselee> dataset,
    List<Rooms> rooms,
    List<String> roomIds,
    List<String> lastMessages,
    List<int> counseleeIds,
    List<int> counselorIds,
    String status,
  ) {
    if (status == 'ended') {
      return SizedBox(
        width: 1.sw,
        height: 150.h,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'History Counceling',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    log('Logged ${dataset[index].counseleeId}');

                    _sharedPreference.putString(
                      'roomId',
                      roomIds[index],
                    );

                    if (_firestoreUtils.chatList.isEmpty) {
                      Get.snackbar('Chat', 'Belum ada histori pesan');
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CouncelingChatScreen(
                              conseleeId: counseleeIds[index],
                              conselorId: counselorIds[index],
                            );
                          },
                        ),
                      );
                    }
                  },
                  child: Card(
                    child: Container(
                      width: 1.sw,
                      height: 80.h,
                      padding: EdgeInsets.all(8.w),
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Image.asset(
                              'assets/images/cat.png',
                              width: 46.w,
                              height: 46.h,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  dataset[index].gender.toString() == 'P'
                                      ? const Icon(
                                          Icons.female,
                                          color: Colors.pinkAccent,
                                        )
                                      : const Icon(
                                          Icons.male,
                                          color: Colors.blueAccent,
                                        ),
                                  Text(
                                    'Anonymous',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    softWrap: true,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              Padding(
                                padding: EdgeInsets.only(left: 8.h),
                                child: Text(
                                  lastMessages[index],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: true,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 24.w),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${dataset[index].angkatan}',
                                    style: TextStyle(
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.4),
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 8.sp,
                                    ),
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    dataset[index].jurusan,
                                    style: TextStyle(
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.4),
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 8.sp,
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
              },
            ),
          ],
        ),
      );
    } else {
      return SizedBox(
        width: 1.sw,
        height: 150.h,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'History Counceling',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: const Text('No chat history'),
              ),
            ),
          ],
        ),
      );
    }
  }
}
