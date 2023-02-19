import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/controllers/counseling_controller.dart';
import 'package:itb_ganecare/data/sharedprefs.dart';
import 'package:itb_ganecare/data_provider/chat_room_utils.dart';
import 'package:itb_ganecare/models/chats.dart';
import 'package:itb_ganecare/models/counseling.dart';
import 'package:itb_ganecare/screen/app/counceling/counceling_chat_screen.dart';
import 'package:itb_ganecare/screen/app/counceling/counceling_profile_screen.dart';
import 'package:itb_ganecare/screen/app/counceling/councelor/councelor_listview_screen.dart';

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
    CouncelorSebayaViews(),
    const CouncelorListViewScreen(),
    const CouncelingProfileScreen(),
  ];
}

class CouncelorSebayaViews extends StatelessWidget {
  CouncelorSebayaViews({Key? key}) : super(key: key);

  final SharedPrefUtils _sharedPreference = SharedPrefUtils();
  final CounselingController _councelingController = Get.find();
  final FirestoreUtils _firestoreUtils = FirestoreUtils();

  // final RxList<String> isPending = <String>[].obs;
  final RxList<String> isApproved = <String>[].obs;
  final RxList<String> isEnded = <String>[].obs;

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
          buildCounselorWidget(context),
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
          'Daftar Conselee Kamu',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
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
          } else if (snapshot.connectionState == ConnectionState.done) {
            rooms = snapshot.data;

            return Column(
              children: [buildListWidget(rooms)],
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
      },
    );
  }

  Widget buildListWidget(List<Rooms> rooms) {
    String currentUserId =
        _sharedPreference.getString('councelor_id').toString();

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
          itemBuilder: (context, index) {
            if (temp[index].idConselee.toString() == currentUserId) {
              return GestureDetector(
                onTap: () {
                  log('Logged ee: ${temp[index].idConselee} - or: ${temp[index].idConselor}');

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
        _sharedPreference.getString('councelee_id').toString();

    if (rooms.isNotEmpty) {
      List<Rooms> temp = [];

      if (temp.isNotEmpty) temp.clear();

      for (final r in rooms) {
        if (r.roomStatus == 'ended' || r.roomStatus == 'closed') temp.add(r);
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
                                      temp[index].genderConselor,
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
      return Center(
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: const Text('No chat history'),
        ),
      );
    }
  }

  // StreamBuilder buildCounselor(BuildContext context) {
  //   // String jurusan = _sharedPreference.getString('major').toString();
  //   // String angkatan = _sharedPreference.getInt('angkatan').toString();
  //   // String gender = _sharedPreference.getString('gender').toString();

  //   String nim = _sharedPreference.getString('nim').toString();
  //   String name = _sharedPreference.getString('name').toString();

  //   List<String> roomIds = [];
  //   List<String> lastMessages = [];
  //   // List<bool> isReads = [];
  //   List<Rooms> rooms = [];
  //   List<int> counseleeIds = [];
  //   List<int> counselorIds = [];

  //   return StreamBuilder<List<Rooms>>(
  //     stream: _firestoreUtils.getLiveChatRoom(),
  //     builder: (context, AsyncSnapshot snap) {
  //       if (snap.hasData) {
  //         if (snap.connectionState == ConnectionState.waiting) {
  //           return const Padding(
  //             padding: EdgeInsets.all(8.0),
  //             child: CircularProgressIndicator.adaptive(),
  //           );
  //         } else {
  //           if (snap.data.isNotEmpty) {
  //             rooms = snap.data;

  //             for (final data in rooms) {
  //               if (roomIds.isNotEmpty) roomIds.clear();
  //               roomIds.add(data.id);

  //               if (counselorIds.isNotEmpty) counselorIds.clear();
  //               counselorIds.add(data.idConselor);

  //               if (counseleeIds.isNotEmpty) counseleeIds.clear();
  //               counseleeIds.add(data.idConselee);

  //               // if (isPending.isNotEmpty) isPending.clear();
  //               // if (data.roomStatus == 'pending' ||
  //               //     data.roomStatus == 'requested' ||
  //               //     data.roomStatus == 'request') {
  //               //   isPending.add(data.roomStatus);
  //               // }

  //               if (isApproved.isNotEmpty) isApproved.clear();
  //               if (data.roomStatus == 'approve' ||
  //                   data.roomStatus == 'accepted') {
  //                 isApproved.add(data.roomStatus);
  //               }

  //               if (isEnded.isNotEmpty) isEnded.clear();
  //               if (data.roomStatus == 'ended') isEnded.add(data.roomStatus);

  //               _firestoreUtils.getLiveChat(data.id).listen((event) {
  //                 _firestoreUtils.chatList = event;

  //                 for (final texts in event) {
  //                   if (lastMessages.isNotEmpty) lastMessages.clear();
  //                   lastMessages.add(texts.message);
  //                 }
  //               });
  //             }
  //           }
  //         }
  //       }

  //       return FutureBuilder<dynamic>(
  //         future: Future.delayed(
  //           const Duration(seconds: 1),
  //           () => _councelingController.postPeerCounselee(nim, name),
  //         ),
  //         builder: (context, snapshot) {
  //           if (snapshot.hasData) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               return const Padding(
  //                 padding: EdgeInsets.all(8.0),
  //                 child: CircularProgressIndicator.adaptive(),
  //               );
  //             } else if (snapshot.connectionState == ConnectionState.done) {
  //               List<Counselee> dataset = snapshot.data.data;
  //               log(rooms.toString(), name: 'log-dataset');

  //               if (rooms.isNotEmpty) {
  //                 return Column(
  //                   children: [
  //                     buildCounselingWidget(
  //                       dataset,
  //                       rooms,
  //                       roomIds,
  //                       lastMessages,
  //                       counseleeIds,
  //                       counselorIds,
  //                       isApproved,
  //                     ),
  //                     buildHistoryCounceling(
  //                       context,
  //                       dataset,
  //                       rooms,
  //                       roomIds,
  //                       lastMessages,
  //                       counseleeIds,
  //                       counselorIds,
  //                       isEnded,
  //                     ),
  //                   ],
  //                 );
  //               } else {
  //                 return Center(
  //                   child: Padding(
  //                     padding: EdgeInsets.all(8.w),
  //                     child: const Text('No chat history'),
  //                   ),
  //                 );
  //               }
  //             } else {
  //               return Center(
  //                 child: Padding(
  //                   padding: EdgeInsets.all(8.w),
  //                   child: const Text('No chat history'),
  //                 ),
  //               );
  //             }
  //           } else {
  //             return Center(
  //               child: Padding(
  //                 padding: EdgeInsets.all(8.w),
  //                 child: const Text('No chat history'),
  //               ),
  //             );
  //           }
  //         },
  //       );
  //     },
  //   );
  // }

  // Widget buildCounselingWidget(
  //   List<Counselee> dataset,
  //   List<Rooms> rooms,
  //   List<String> roomIds,
  //   List<String> lastMessages,
  //   List<int> counseleeIds,
  //   List<int> counselorIds,
  //   List<String> status,
  // ) {
  //   String currentUserId =
  //       _sharedPreference.getString('councelor_id').toString();
  //   List<Rooms> tempRooms = [];

  //   if (status.isNotEmpty) {
  //     if (tempRooms.isNotEmpty) tempRooms.clear();

  //     for (final x in rooms) {
  //       if (x.idConselor.toString() == currentUserId) {
  //         tempRooms.add(x);
  //       }
  //     }

  //     return SizedBox(
  //       width: 1.sw,
  //       height: 260.h,
  //       child: ListView.builder(
  //         shrinkWrap: true,
  //         itemCount: tempRooms.length,
  //         itemBuilder: (context, index) {
  //           log(dataset[index].counseleeName);

  //           return GestureDetector(
  //             onTap: () {
  //               log('Logged ${dataset[index].counseleeId}', name: 'konselor');

  //               _sharedPreference.putString(
  //                 'roomId',
  //                 roomIds[index],
  //               );

  //               if (_firestoreUtils.chatList.isEmpty) {
  //                 Get.snackbar('Chat', 'Belum ada histori pesan');
  //               } else {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) {
  //                       return CouncelingChatScreen(
  //                         conseleeId: counseleeIds[index],
  //                         conselorId: counselorIds[index],
  //                         currentId: _sharedPreference
  //                             .getString('councelor_id')
  //                             .toString(),
  //                       );
  //                     },
  //                   ),
  //                 );
  //               }
  //             },
  //             child: Card(
  //               child: Container(
  //                 width: 1.sw,
  //                 height: 80.h,
  //                 margin: EdgeInsets.symmetric(horizontal: 16.w),
  //                 padding: EdgeInsets.all(8.w),
  //                 child: Row(
  //                   children: [
  //                     Padding(
  //                       padding: EdgeInsets.all(8.w),
  //                       child: Image.asset(
  //                         'assets/images/cat.png',
  //                         width: 46.w,
  //                         height: 46.h,
  //                       ),
  //                     ),
  //                     Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             dataset[index].gender.toString() == 'P'
  //                                 ? const Icon(
  //                                     Icons.female,
  //                                     color: Colors.pinkAccent,
  //                                   )
  //                                 : const Icon(
  //                                     Icons.male,
  //                                     color: Colors.blueAccent,
  //                                   ),
  //                             Text(
  //                               'Anonymous',
  //                               overflow: TextOverflow.ellipsis,
  //                               maxLines: 2,
  //                               softWrap: true,
  //                               style: TextStyle(
  //                                 overflow: TextOverflow.ellipsis,
  //                                 color: Colors.black,
  //                                 fontSize: 14.sp,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(height: 2.h),
  //                         Padding(
  //                           padding: EdgeInsets.only(left: 8.h),
  //                           child: Text(
  //                             lastMessages[index],
  //                             overflow: TextOverflow.ellipsis,
  //                             maxLines: 2,
  //                             softWrap: true,
  //                             style: TextStyle(
  //                               overflow: TextOverflow.ellipsis,
  //                               color: Colors.grey,
  //                               fontWeight: FontWeight.w400,
  //                               fontSize: 10.sp,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(width: 24.w),
  //                     Column(
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Text(
  //                               '${dataset[index].angkatan}',
  //                               style: TextStyle(
  //                                 backgroundColor: Colors.grey.withOpacity(0.4),
  //                                 color: Colors.black,
  //                                 fontWeight: FontWeight.w500,
  //                                 fontSize: 8.sp,
  //                               ),
  //                             ),
  //                             SizedBox(width: 2.w),
  //                             Text(
  //                               dataset[index]
  //                                       .jurusan
  //                                       .contains('Tahap Tahun Pertama')
  //                                   ? dataset[index].jurusan.substring(20)
  //                                   : dataset[index]
  //                                           .jurusan
  //                                           .contains('Tahap Tahun Kedua')
  //                                       ? dataset[index].jurusan.substring(18)
  //                                       : dataset[index]
  //                                               .jurusan
  //                                               .contains('Tahap Tahun Ketiga')
  //                                           ? dataset[index]
  //                                               .jurusan
  //                                               .substring(19)
  //                                           : dataset[index].jurusan.contains(
  //                                                   'Tahap Tahun Keempat')
  //                                               ? dataset[index]
  //                                                   .jurusan
  //                                                   .substring(20)
  //                                               : dataset[index].jurusan,
  //                               style: TextStyle(
  //                                 backgroundColor: Colors.grey.withOpacity(0.4),
  //                                 color: Colors.black,
  //                                 fontWeight: FontWeight.w500,
  //                                 fontSize: 8.sp,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     );
  //   } else {
  //     return SizedBox(width: 1.sw, height: 260.h);
  //   }
  // }

  // Widget buildHistoryCounceling(
  //   BuildContext context,
  //   List<Counselee> dataset,
  //   List<Rooms> rooms,
  //   List<String> roomIds,
  //   List<String> lastMessages,
  //   List<int> counseleeIds,
  //   List<int> counselorIds,
  //   List<String> status,
  // ) {
  //   String currentUserId =
  //       _sharedPreference.getString('councelor_id').toString();
  //   List<Rooms> tempRooms = [];

  //   if (status.isNotEmpty) {
  //     if (tempRooms.isNotEmpty) tempRooms.clear();

  //     for (final x in rooms) {
  //       if (x.idConselee.toString() == currentUserId) {
  //         tempRooms.add(x);
  //       }
  //     }

  //     return SizedBox(
  //       width: 1.sw,
  //       child: Column(
  //         children: [
  //           Container(
  //             margin: EdgeInsets.symmetric(horizontal: 16.w),
  //             child: Text(
  //               'History Counceling',
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.w600,
  //                 fontSize: 16.sp,
  //               ),
  //             ),
  //           ),
  //           ListView.builder(
  //             shrinkWrap: true,
  //             itemCount: tempRooms.length,
  //             itemBuilder: (context, index) {
  //               return GestureDetector(
  //                 onTap: () {
  //                   log('Logged ${dataset[index].counseleeId}',
  //                       name: 'Konselor');

  //                   _sharedPreference.putString(
  //                     'roomId',
  //                     roomIds[index],
  //                   );

  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) {
  //                         return CouncelingChatScreen(
  //                           conseleeId: counseleeIds[index],
  //                           conselorId: counselorIds[index],
  //                           currentId: _sharedPreference
  //                               .getString('councelor_id')
  //                               .toString(),
  //                         );
  //                       },
  //                     ),
  //                   );

  //                   // if (_firestoreUtils.chatList.isEmpty) {
  //                   //   Get.snackbar('Chat', 'Belum ada histori pesan');
  //                   // } else {
  //                   //   Navigator.push(
  //                   //     context,
  //                   //     MaterialPageRoute(
  //                   //       builder: (context) {
  //                   //         return CouncelingChatScreen(
  //                   //           conseleeId: counseleeIds[index],
  //                   //           conselorId: counselorIds[index],
  //                   //         );
  //                   //       },
  //                   //     ),
  //                   //   );
  //                   // }
  //                 },
  //                 child: Card(
  //                   child: Container(
  //                     width: 1.sw,
  //                     height: 80.h,
  //                     padding: EdgeInsets.all(8.w),
  //                     margin: EdgeInsets.symmetric(horizontal: 16.w),
  //                     child: Row(
  //                       children: [
  //                         Padding(
  //                           padding: EdgeInsets.all(8.w),
  //                           child: Image.asset(
  //                             'assets/images/cat.png',
  //                             width: 46.w,
  //                             height: 46.h,
  //                           ),
  //                         ),
  //                         Column(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 dataset[index].gender.toString() == 'P'
  //                                     ? const Icon(
  //                                         Icons.female,
  //                                         color: Colors.pinkAccent,
  //                                       )
  //                                     : const Icon(
  //                                         Icons.male,
  //                                         color: Colors.blueAccent,
  //                                       ),
  //                                 Text(
  //                                   'Anonymous',
  //                                   overflow: TextOverflow.ellipsis,
  //                                   maxLines: 2,
  //                                   softWrap: true,
  //                                   style: TextStyle(
  //                                     overflow: TextOverflow.ellipsis,
  //                                     color: Colors.black,
  //                                     fontSize: 14.sp,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             SizedBox(height: 2.h),
  //                             Padding(
  //                               padding: EdgeInsets.only(left: 8.h),
  //                               child: Text(
  //                                 lastMessages[index],
  //                                 overflow: TextOverflow.ellipsis,
  //                                 maxLines: 2,
  //                                 softWrap: true,
  //                                 style: TextStyle(
  //                                   overflow: TextOverflow.ellipsis,
  //                                   color: Colors.grey,
  //                                   fontWeight: FontWeight.w400,
  //                                   fontSize: 10.sp,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(width: 24.w),
  //                         Column(
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Text(
  //                                   '${dataset[index].angkatan}',
  //                                   style: TextStyle(
  //                                     backgroundColor:
  //                                         Colors.grey.withOpacity(0.4),
  //                                     color: Colors.black,
  //                                     fontWeight: FontWeight.w500,
  //                                     fontSize: 8.sp,
  //                                   ),
  //                                 ),
  //                                 SizedBox(width: 2.w),
  //                                 Text(
  //                                   dataset[index].jurusan,
  //                                   style: TextStyle(
  //                                     backgroundColor:
  //                                         Colors.grey.withOpacity(0.4),
  //                                     color: Colors.black,
  //                                     fontWeight: FontWeight.w500,
  //                                     fontSize: 8.sp,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         ],
  //       ),
  //     );
  //   } else {
  //     return SizedBox(
  //       width: 1.sw,
  //       height: 150.h,
  //       child: Column(
  //         children: [
  //           Container(
  //             margin: EdgeInsets.symmetric(horizontal: 16.w),
  //             child: Text(
  //               'History Counceling',
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.w600,
  //                 fontSize: 16.sp,
  //               ),
  //             ),
  //           ),
  //           Center(
  //             child: Padding(
  //               padding: EdgeInsets.all(8.w),
  //               child: const Text('No chat history'),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }
}
