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
            buildCounselorWidget(context),
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
        padding: EdgeInsets.only(top: 16.h, bottom: 16.h, left: 16.w),
        child: Text(
          'Pilih Pendamping Sebaya',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
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

      return SizedBox(
        width: 1.sw,
        height: 260.h,
        child: ListView.builder(
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
                                  fontSize: 9.sp,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                councelorList[index]
                                        .jurusan
                                        .contains('Tahap Tahun Pertama')
                                    ? councelorList[index].jurusan.substring(20)
                                    : councelorList[index]
                                            .jurusan
                                            .contains('Tahap Tahun Kedua')
                                        ? councelorList[index]
                                            .jurusan
                                            .substring(18)
                                        : councelorList[index]
                                                .jurusan
                                                .contains('Tahap Tahun Ketiga')
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
                                                : councelorList[index].jurusan,
                                style: TextStyle(
                                  backgroundColor: Colors.grey.withOpacity(0.4),
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
          },
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

            return SizedBox(
              width: 1.sw,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    child: const Text(
                      'Pending Request',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: temp.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          child: Container(
                            width: 1.sw,
                            height: 80.h,
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
                                        '#${temp[index].idConselor}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      children: [
                                        temp[index].genderConselor.toString() ==
                                                'P'
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
                                          rooms[index].generationConselor,
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
                                          temp[index].majorConselor.contains(
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
                    },
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
