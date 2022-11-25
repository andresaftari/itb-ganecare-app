import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itb_ganecare/screen/app/counceling/counceling_chat_screen.dart';

class CouncelorListViewScreen extends StatefulWidget {
  const CouncelorListViewScreen({Key? key}) : super(key: key);

  @override
  State<CouncelorListViewScreen> createState() =>
      _CouncelorListViewScreenState();
}

class _CouncelorListViewScreenState extends State<CouncelorListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
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
            margin: const EdgeInsets.only(left: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'Selamat datang',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      margin: const EdgeInsets.only(top: 62, left: 24),
                    ),
                    Container(
                      child: const Text(
                        'Developer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      margin: const EdgeInsets.only(top: 4, left: 24),
                    ),
                  ],
                ),
                Container(
                  width: 44,
                  margin: const EdgeInsets.only(right: 24, top: 42),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
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
          ),
        ),
      ),
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            buildHeader(context),
            buildCouncelee(context),
            const SizedBox(height: 16),
            buildPendingRequestList(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 52,
      color: const Color.fromRGBO(253, 143, 1, 1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Daftar Conselee',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      elevation: 1,
                      backgroundColor: Colors.orange,
                      content: Text('Sorting still in development', 
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
    );
  }

  Widget buildCouncelee(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 260,
      child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {
              log('Logged');

              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) {
                    return const CouncelingChatScreen();
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
                            '#21345',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            const Icon(
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
                            'Saya seorang yang hiya hiya hiya',
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
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '2018',
                              style: TextStyle(
                                backgroundColor: Colors.grey.withOpacity(0.4),
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 11.sp,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Satu Jurusan',
                              style: TextStyle(
                                backgroundColor: Colors.grey.withOpacity(0.4),
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
        }),
      ),
    );
  }

  Widget buildPendingRequestList(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 260,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pending Request',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                IconButton(onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      elevation: 1,
                      backgroundColor: Colors.orange,
                      content: Text('Sorting still in development', 
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

                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) {
                        return const CouncelingChatScreen();
                      },
                    ),
                  );
                },
                child: Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80.h,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding: EdgeInsets.all(8.w),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.w),
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
                                '#21345',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
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
                            SizedBox(height: 2.h),
                            Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: Text(
                                'Saya seorang yang hiya hiya hiya',
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
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '2017',
                                  style: TextStyle(
                                    backgroundColor: Colors.grey.withOpacity(0.4),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Beda Jurusan',
                                  style: TextStyle(
                                    backgroundColor: Colors.grey.withOpacity(0.4),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        elevation: 1,
                                        backgroundColor: Colors.orange,
                                        content: Text('This feature is still in development', 
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
                                    Icons.do_not_disturb_on_outlined,
                                    color: Colors.redAccent,
                                  ),
                                  iconSize: 20,
                                  splashRadius: 20,
                                ),
                                IconButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        elevation: 1,
                                        backgroundColor: Colors.orange,
                                        content: Text('This feature is still in development', 
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
                                    Icons.check_circle_outlined,
                                    color: Colors.greenAccent,
                                  ),
                                  iconSize: 20,
                                  splashRadius: 20,
                                ),
                              ],
                            )
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
