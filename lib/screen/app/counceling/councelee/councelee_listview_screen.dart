import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/controllers/counseling_controller.dart';
import 'package:itb_ganecare/data/sharedprefs.dart';
import 'package:itb_ganecare/data_provider/chat_room_utils.dart';
import 'package:itb_ganecare/models/chats.dart';
import 'package:itb_ganecare/models/counseling.dart';

class CounceleeListViewScreen extends StatefulWidget {
  const CounceleeListViewScreen({Key? key}) : super(key: key);

  @override
  State<CounceleeListViewScreen> createState() =>
      _CounceleeListViewScreenState();
}

class _CounceleeListViewScreenState extends State<CounceleeListViewScreen> {
  final SharedPrefUtils _sharedPreference = SharedPrefUtils();

  final CounselingController _councelingController = Get.find();
  final FirestoreUtils _firestoreUtils = FirestoreUtils();

  final RxList<String> isPending = <String>[].obs;
  final RxList<String> isRejected = <String>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            buildHeader(context),
            buildCounselor(context),
            // buildListCounselor(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 52.h,
      color: const Color.fromRGBO(253, 143, 1, 1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pilih Pendamping Sebaya',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
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
              icon: const Icon(CupertinoIcons.sort_down, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListCounselorWidget(
    BuildContext context,
    List<Counselor> councelorList,
  ) {
    // String name = _sharedPreference.getString('name').toString();
    // String gender = _sharedPreference.getString('gender').toString();
    // String angkatan = _sharedPreference.getInt('angkatan').toString();
    // String jurusan = _sharedPreference.getString('major').toString();
    // String counseleeId = _sharedPreference.getString('councelee_id').toString();

    if (councelorList.isNotEmpty) {
      return SizedBox(
        width: 1.sw,
        height: 260.h,
        child: ListView.builder(
          itemCount: councelorList.length,
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                // _firestoreUtils.createNewRoom(
                //   gender,
                //   councelorList[index].gender,
                //   angkatan,
                //   councelorList[index].angkatan.toString(),
                //   counseleeId,
                //   councelorList[index].counselorId.toString(),
                //   jurusan,
                //   councelorList[index].jurusan.toString(),
                //   name,
                //   councelorList[index].counselorName,
                // );

                Get.snackbar(
                  'Counselee',
                  'Create New Room still in development',
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
                              '#${councelorList[index].counselorId}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              councelorList[index].gender.toString() == 'P'
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
                        ],
                      ),
                      SizedBox(width: 24.w),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                '${councelorList[index].angkatan}',
                                style: TextStyle(
                                  backgroundColor: Colors.grey.withOpacity(0.4),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 8.sp,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                councelorList[index].jurusan,
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
          }),
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

  StreamBuilder buildCounselor(BuildContext context) {
    List<Rooms> rooms = [];
    List<int> counseleeIds = [];

    return StreamBuilder<List<Rooms>>(
      stream: _firestoreUtils.getLiveChatRoom(),
      initialData: const [],
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasData) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            if (snap.data.isNotEmpty) {
              rooms = snap.data;

              for (final data in rooms) {
                if (counseleeIds.isNotEmpty) counseleeIds.clear();
                counseleeIds.add(data.idConselee);

                if (isRejected.isNotEmpty) isRejected.clear();
                if (data.roomStatus == 'rejected') {
                  isRejected.add(data.roomStatus);
                }

                if (isPending.isNotEmpty) isPending.clear();
                if (data.roomStatus == 'request' ||
                    data.roomStatus == 'pending') {
                  isPending.add(data.roomStatus);
                }
              }
            }
          }
        }

        return FutureBuilder<dynamic>(
          future: Future.delayed(
            const Duration(seconds: 1),
            () => _councelingController.postPeerCounselor(
              'Teknik Lingkungan',
              '2019',
              'P',
            ),
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                List<Counselor> dataset = snapshot.data.data;

                if (rooms.isNotEmpty) {
                  return Column(
                    children: [
                      buildListCounselorWidget(context, dataset),
                      buildPendingRequestWidget(context, dataset, isPending),
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
      },
    );
  }

  Widget buildPendingRequestWidget(
    BuildContext context,
    List<Counselor> dataset,
    List<String> status,
  ) {
    if (status.isNotEmpty) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 260.h,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pending Request',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          elevation: 1,
                          backgroundColor: Colors.orange,
                          content: Text(
                            'Sorting still in development',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16,
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
              itemCount: status.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
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
                          SizedBox(width: 4.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Text(
                                  '#${dataset[index].counselorId}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
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
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              // const Padding(
                              //   padding: EdgeInsets.only(left: 8.0),
                              //   child: Text(
                              //     'Saya seorang yang hiya hiya hiya',
                              //     overflow: TextOverflow.ellipsis,
                              //     maxLines: 2,
                              //     softWrap: true,
                              //     style: TextStyle(
                              //       overflow: TextOverflow.ellipsis,
                              //       color: Colors.grey,
                              //       fontWeight: FontWeight.w400,
                              //       fontSize: 10,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
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
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    dataset[index].jurusan,
                                    style: TextStyle(
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.4),
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
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
      return Center(
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: const Text('No pending request'),
        ),
      );
    }
  }
}
