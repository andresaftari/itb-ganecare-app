import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itb_ganecare/repositories/app_data_repository.dart';
import 'package:itb_ganecare/screen/app/counceling/councelee/councelee_sebaya_screen.dart';
import 'package:itb_ganecare/screen/app/counceling/councelor/councelor_sebaya_screen.dart';
import 'package:itb_ganecare/themes/custom_themes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final GlobalKey scaffoldKey;
  final bool isDarkMode;

  const HomePage({
    Key? key,
    required this.scaffoldKey,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeNotifier(
        isDarkMode ? darkTheme : lightTheme,
        appDataRepository: AppDataRepository(),
      ),
      child: WorldTheme(scaffoldKey: scaffoldKey),
    );
  }
}

class WorldTheme extends StatelessWidget {
  final GlobalKey localScaffoldKey;

  final bool isLoading = true;
  final bool isCouncelor = false;

  const WorldTheme({
    Key? key,
    required GlobalKey scaffoldKey,
  })  : localScaffoldKey = scaffoldKey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      theme: themeNotifier.getTheme(),
      // initialRoute: '/homePage',
      home: Scaffold(
        floatingActionButton: buildFloatingActionButton(),
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 80.h,
          automaticallyImplyLeading: false,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Selamat datang',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      margin: EdgeInsets.only(top: 62.h, left: 24.w),
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
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: 58.h),
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
                      margin: EdgeInsets.only(right: 24.w, top: 58.h),
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
        // body: isLoading ? buildHomeLoading() : buildHomeBody(),
        body: Stack(
          children: [
            _backgroundContainer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                primary: true,
                child: Column(
                  children: [
                    buildHomeBody(context),
                    SizedBox(height: 16.h),
                    buildConselee(context),
                    SizedBox(height: 16.h),
                    buildScholarshipNews(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _backgroundContainer() {
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
    );
  }

  Widget buildHomeLoading() {
    return Stack(
      children: [
        _backgroundContainer(),
        Center(
          child: Image.asset(
            'assets/images/logo gerak.gif',
            width: 200.w,
          ),
        ),
      ],
    );
  }

  Widget buildHomeBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: const Text(
              'Apps',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            margin: EdgeInsets.only(left: 16.w, top: 32.h),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 60.h,
            child: Center(
              child: ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  if (index == 0) {
                    return Container(
                      height: 60.h,
                      width: 60.w,
                      padding: const EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: GestureDetector(
                        onTap: () {
                          showBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            builder: (context) => GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Padding(
                                  padding: EdgeInsets.all(16.w),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 8.h),
                                    height: 300.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.r),
                                        bottomRight: Radius.circular(16.r),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            'Counceling Sebaya',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 24.h),
                                        Text(
                                          'Anda akan membuka aplikasi Pendamping Sebaya\n'
                                          'yang membuat Anda masuk ke mode anonim. Data pribadi\n'
                                          'Anda terkait Nama dan NIM tidak akan diketahui oleh\n'
                                          'Pendamping Sebaya maupun pengguna lain',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 32.h),
                                        const Center(child: Text('Masuk sebagai :')),
                                        SizedBox(height: 16.h),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              child: Text(
                                                'Councelee',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary: const Color.fromRGBO(253, 143, 1, 1),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => const CounceleeSebayaScreen(),
                                                  ),
                                                );
                                              },
                                            ),
                                            SizedBox(width: 8.w),
                                            ElevatedButton(
                                              child: Text(
                                                'Councelor',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary: const Color.fromRGBO(253, 143, 1, 1),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(16.r),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return const CouncelorSebayaScreen();
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/icons/chat.png',
                          width: 60.w,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(253, 143, 1, 1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    );
                  } else if (index == 1) {
                    return Container(
                      height: 60.h,
                      width: 60.w,
                      padding: EdgeInsets.all(8.w),
                      margin: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Image.asset('assets/images/beasiswa.png'),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(253, 143, 1, 1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    );
                  } else if (index == 2) {
                    return Container(
                      height: 60.h,
                      width: 60.w,
                      padding: EdgeInsets.all(8.w),
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Image.asset('assets/images/konsultasi.png'),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(253, 143, 1, 1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    );
                  } else if (index == 3) {
                    return Container(
                      height: 60.h,
                      width: 60.w,
                      padding: EdgeInsets.all(8.w),
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Image.asset('assets/images/achievement.png'),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(253, 143, 1, 1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    );
                  } else {
                    return Container(
                      height: 60.h,
                      width: 60.w,
                      padding: EdgeInsets.all(8.w),
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Image.asset('assets/images/achievement.png'),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(253, 143, 1, 1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    );
                  }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildConselee(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: const Text(
            'Conselee',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          margin: EdgeInsets.only(left: 16.w),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: 1.sw,
          height: 135.h,
          child: ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return Card(
                child: SizedBox(
                  width: 200.w,
                  // margin: const EdgeInsets.symmetric(horizontal: 16),
                  // padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        child: Row(
                          children: [
                            const Center(child: Text('{Anonymous Conselee}')),
                            SizedBox(width: 4.w),
                            Image.asset(
                              'assets/images/redalert.png',
                              width: 12.w,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      buildTextChatConselee(context),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget buildTextChatConselee(BuildContext context) {
    return Column(
      children: [
        const Text('Owww ma gadd 🙂'),
        SizedBox(height: 32.h),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 1.sw,
            height: 34.h,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(253, 143, 1, 1),
            ),
            child: const Center(
              child: Text(
                'Bantu',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildScholarshipNews(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: const Text(
            'Beasiswa Terbaru',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          margin: EdgeInsets.only(left: 16.w),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 1.sw,
          height: 400.h,
          child: ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              return Card(
                child: Container(
                  width: 1.sw,
                  height: 100.h,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  padding: EdgeInsets.all(8.w),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/emotes/a1.png',
                        width: 32.w,
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '{Nama Beasiswa}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Flexible(
                            child: Text(
                              'Lorem Ipsum Dolor sit Amet, this is\njust a dummy text',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.redAccent,
      child: const Icon(Icons.campaign_sharp),
    );
  }
}
