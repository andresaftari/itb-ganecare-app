import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/sharedprefs.dart';
import 'package:itb_ganecare/data_provider/chat_room_utils.dart';
import 'package:itb_ganecare/models/chats.dart';
import 'package:itb_ganecare/screen/app/counceling/counceling_chat_screen.dart';
import 'package:itb_ganecare/screen/app/counceling/councelor/councelor_listview_screen.dart';
import 'package:itb_ganecare/screen/app/counceling/councelor_profile_screen.dart';

import '../../../../data/controllers/profile_controller.dart';
import '../counceling_profile_screen.dart';

class CouncelorSebayaScreen extends StatefulWidget {
  const CouncelorSebayaScreen({Key? key}) : super(key: key);

  @override
  State<CouncelorSebayaScreen> createState() => _ConcelorSebayaScreenState();
}

class _ConcelorSebayaScreenState extends State<CouncelorSebayaScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
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
            label: 'Councelee',
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
    const CouncelorSebayaViews(),
    const CouncelorListViewScreen(),
    const CouncelorProfileScreen(),
    // Container(),
  ];
}

class CouncelorSebayaViews extends StatefulWidget {
  const CouncelorSebayaViews({Key? key}) : super(key: key);

  @override
  State<CouncelorSebayaViews> createState() => _CouncelorSebayaViewsState();
}

class _CouncelorSebayaViewsState extends State<CouncelorSebayaViews> {
  final SharedPrefUtils _sharedPreference = SharedPrefUtils();

  // final CounselingController _councelingController = Get.find();
  final FirestoreUtils _firestoreUtils = FirestoreUtils();

  // final RxList<String> isPending = <String>[].obs;
  final RxList<String> isApproved = <String>[].obs;

  final RxList<String> isEnded = <String>[].obs;
  final ProfileController _profileController = Get.find();
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
            profilePicture = value['data']['conselor']['profilepic_image'];
          })
        });
  }

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
                        _sharedPreference.getString('username').toString(),
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
                    (profilePicture != '')
                        ? Container(
                            height: 50.h,
                            width: 44.w,
                            margin: EdgeInsets.only(right: 24.w, top: 32.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 0.5.w,
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(profilePicture),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8,
                                  offset: const Offset(3, 2),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            height: 50.h,
                            width: 44.w,
                            margin: EdgeInsets.only(right: 24.w, top: 32.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/cat.png'),
                              ),
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
          buildCounselorWidget(context),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      height: 52.h,
      color: const Color.fromRGBO(253, 143, 1, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.h, bottom: 16.h, left: 16.w),
            child: Text(
              'Daftar Conselee Kamu',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showBottomSheet(
                context: context, 
                backgroundColor: Colors.white,
                builder: (context) => GestureDetector(
                  onTap: () => Navigator.pop(context),  
                  child: Container(
                    height: 300.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10.w, 
                        sigmaY: 10.h,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Filter', 
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.black, 
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Jenis Kelamin', 
                                      style: TextStyle(
                                        color: Colors.black, 
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                    Container(
                                      padding: EdgeInsets.all(8.w),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black, 
                                          width: 0.8.w,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16.r),
                                        ),
                                      ),
                                      child: Text(
                                        'Laki-Laki',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Container(
                                      padding: EdgeInsets.all(8.w),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black, 
                                          width: 0.8.w,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16.r),
                                        ),
                                      ),
                                      child: Text(
                                        'Perempuan',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Icon(CupertinoIcons.sort_down, color: Colors.black, size: 26.w),
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder buildCounselorWidget(BuildContext context) {
    List<Rooms> rooms = [];

    return StreamBuilder<List<Rooms>>(
      stream: _firestoreUtils.getLiveChatRoom(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            rooms = snapshot.data;

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

  Widget buildListWidget(List<Rooms> rooms) {
    String currentUserId =
        _sharedPreference.getString('councelor_id').toString();
    // log('test $currentUserId');

    if (rooms.isNotEmpty) {
      List<Rooms> temp = [];

      if (temp.isNotEmpty) temp.clear();

      for (final r in rooms) {
        if (r.roomStatus == 'approved' || r.roomStatus == 'approve') {
          temp.add(r);
        }
      }

      return SizedBox(
        width: 1.sw,
        height: 260.h,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: temp.length,
          itemBuilder: (context, index) {
            if (temp[index].idConselor.toString() == currentUserId) {
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
                                temp[index].genderConselor.toString() == 'P'
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
                                temp[index].lastMessageConselor,
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
                                  temp[index].generationConselor,
                                  style: TextStyle(
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.4),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 9.sp,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  temp[index]
                                          .majorConselor
                                          .contains('Tahap Tahun Pertama')
                                      ? temp[index].majorConselor.substring(20)
                                      : temp[index]
                                              .majorConselor
                                              .contains('Tahap Tahun Kedua')
                                          ? temp[index]
                                              .majorConselor
                                              .substring(18)
                                          : temp[index].majorConselor.contains(
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
                                                  : temp[index].majorConselor,
                                  style: TextStyle(
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.4),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 9.sp,
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
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: const Text('No chat history'),
                ),
              );
            }
          },
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

  Widget buildHistoryList(List<Rooms> rooms) {
    String currentUserId =
        _sharedPreference.getString('councelor_id').toString();

    if (rooms.isNotEmpty) {
      List<Rooms> temp = [];

      if (temp.isNotEmpty) temp.clear();
      for (final r in rooms) {
        if (r.roomStatus == 'ended') temp.add(r);
      }

      return SizedBox(
        width: 1.sw,
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: temp.length,
              itemBuilder: (context, index) {
                if (temp[index].idConselor.toString() == currentUserId) {
                  return GestureDetector(
                    onTap: () {},
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
                                    temp[index].genderConselor.toString() == 'P'
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
                                    temp[index].lastMessageConselor,
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
                                      temp[index].generationConselor,
                                      style: TextStyle(
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.4),
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 9.sp,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      temp[index]
                                              .majorConselor
                                              .contains('Tahap Tahun Pertama')
                                          ? temp[index]
                                              .majorConselor
                                              .substring(20)
                                          : temp[index]
                                                  .majorConselor
                                                  .contains('Tahap Tahun Kedua')
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
                                      style: TextStyle(
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.4),
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 9.sp,
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
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: const Text('No chat history'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      );
    } else {
      return Column(
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
      );
    }
  }
}
