import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/controllers/counseling_controller.dart';
import 'package:itb_ganecare/data/sharedprefs.dart';
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

  final ProfileSharedPreference _sharedPreference = ProfileSharedPreference();
  final CounselingController _councelingController = Get.find();

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
          buildCounceleeWidget(context),
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

  FutureBuilder buildCounceleeWidget(BuildContext context) {
    String nim = _sharedPreference.getString('nim').toString();
    String name = _sharedPreference.getString('name').toString();

    return FutureBuilder<dynamic>(
      future: _councelingController.postPeerCounselee(nim, name),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          } else if (snapshot.connectionState == ConnectionState.done) {
            List dataset = snapshot.data['data'];
            log(dataset.toString(), name: 'log-dataset');

            return SizedBox(
              width: 1.sw,
              height: 260.h,
              child: ListView.builder(
                itemCount: dataset.length,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      log('Logged ${dataset[index]['counselee_name']}');

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CouncelingChatScreen(
                              id: dataset[index]['counselee_id'],
                              nim: dataset[index]['nim'],
                            );
                          },
                        ),
                      );
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
                                Padding(
                                  padding: EdgeInsets.only(left: 8.w),
                                  child: Text(
                                    '#${dataset[index]['counselee_id']}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    dataset[index]['gender'].toString() == 'P'
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
                                    'Last chat dummy',
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
                                      '${dataset[index]['angkatan']}',
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
                                      '${dataset[index]['jurusan']}',
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
                }),
              ),
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      }),
    );
  }

  Widget buildHistoryCounceling(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 250.h,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'History Counceling',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        elevation: 1,
                        backgroundColor: Colors.orange,
                        content: Text(
                          'Sorting still in development',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    CupertinoIcons.sort_down,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            itemCount: 2,
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {
                  log('Logged');

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return const CouncelingChatScreen();
                  //     },
                  //   ),
                  // );
                  // Get.to(() => const CouncelingChatScreen());
                },
                child: Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset('assets/images/cat.png'),
                        ),
                        const SizedBox(width: 4),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                '#21345',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: const [
                                Icon(
                                  Icons.female,
                                  color: Colors.pinkAccent,
                                ),
                                Text(
                                  'Anonymous',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: true,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Saya seorang yang hiya hiya hiya',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: true,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '2017',
                                  style: TextStyle(
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.4),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Beda Jurusan',
                                  style: TextStyle(
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.4),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
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
            }),
          ),
        ],
      ),
    );
  }
}
