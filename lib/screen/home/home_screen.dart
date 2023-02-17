import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/controllers/home_controller.dart';
import 'package:itb_ganecare/data/controllers/profile_controller.dart';
import 'package:itb_ganecare/data/sharedprefs.dart';
import 'package:itb_ganecare/repositories/app_data_repository.dart';
import 'package:itb_ganecare/screen/app/counceling/councelee/councelee_sebaya_screen.dart';
import 'package:itb_ganecare/screen/app/counceling/councelor/councelor_sebaya_screen.dart';
import 'package:itb_ganecare/themes/custom_themes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final bool isDarkMode;

  const HomePage({
    Key? key,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeNotifier(
        isDarkMode ? darkTheme : lightTheme,
        appDataRepository: AppDataRepository(),
      ),
      child: const WorldTheme(),
    );
  }
}

class WorldTheme extends StatefulWidget {
  const WorldTheme({Key? key}) : super(key: key);

  @override
  State<WorldTheme> createState() => _WorldThemeState();
}

class _WorldThemeState extends State<WorldTheme> {
  final HomeController _homeController = Get.find();
  final ProfileController _profileController = Get.find();
  final SharedPrefUtils _sharedPreference = SharedPrefUtils();

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    // int page = 1;
    _homeController.getQuickHelp().then((value) {
      log(value.toString(), name: 'get-aja');
    });

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
            margin: EdgeInsets.only(left: 16.w, top: 8.h),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 55.h,
            child: Center(
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      height: 55.h,
                      width: 60.w,
                      padding: EdgeInsets.all(4.w),
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      child: GestureDetector(
                        onTap: () {
                          showBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            builder: (context) => GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: _sharedPreference
                                              .getString('councelor_id')
                                              .toString() !=
                                          ''
                                      ? Container(
                                          margin: EdgeInsets.only(top: 16.h),
                                          height: 300.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16.r),
                                              bottomRight:
                                                  Radius.circular(16.r),
                                            ),
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 16.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    'Counceling Sebaya',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 24.h),
                                                Text(
                                                  'Anda akan membuka aplikasi Pendamping Sebay yang membuat Anda masuk ke mode anonim.\n\n'
                                                  'Data pribadi Anda terkait Nama dan NIM tidak akan diketahui oleh\n'
                                                  'Pendamping Sebaya maupun pengguna lain',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 8.h),
                                                const Center(
                                                  child:
                                                      Text('Masuk sebagai :'),
                                                ),
                                                SizedBox(height: 16.h),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                      child: Text(
                                                        'Councelee',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.sp,
                                                        ),
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: const Color
                                                            .fromRGBO(
                                                          253,
                                                          143,
                                                          1,
                                                          1,
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            16.r,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const CounceleeSebayaScreen(),
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
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: const Color
                                                                .fromRGBO(
                                                            253, 143, 1, 1),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            16.r,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const CouncelorSebayaScreen(),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(
                                          margin: EdgeInsets.only(top: 16.h),
                                          height: 300.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16.r),
                                              bottomRight:
                                                  Radius.circular(16.r),
                                            ),
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 16.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    'Counceling Sebaya',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 24.h),
                                                Text(
                                                  'cobaaaa',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                // SizedBox(height: 8.h),
                                                // const Center(
                                                //   child:
                                                //       Text('Masuk sebagai :'),
                                                // ),
                                                // SizedBox(height: 16.h),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment.center,
                                                //   children: [
                                                //     ElevatedButton(
                                                //       child: Text(
                                                //         'Councelee',
                                                //         style: TextStyle(
                                                //           color: Colors.white,
                                                //           fontSize: 16.sp,
                                                //         ),
                                                //       ),
                                                //       style: ElevatedButton
                                                //           .styleFrom(
                                                //         primary: const Color
                                                //             .fromRGBO(
                                                //           253,
                                                //           143,
                                                //           1,
                                                //           1,
                                                //         ),
                                                //         shape:
                                                //             RoundedRectangleBorder(
                                                //           borderRadius:
                                                //               BorderRadius
                                                //                   .circular(
                                                //             16.r,
                                                //           ),
                                                //         ),
                                                //       ),
                                                //       onPressed: () {
                                                //         Navigator.push(
                                                //           context,
                                                //           MaterialPageRoute(
                                                //             builder: (context) =>
                                                //                 const CounceleeSebayaScreen(),
                                                //           ),
                                                //         );
                                                //       },
                                                //     ),
                                                //     SizedBox(width: 8.w),
                                                //     ElevatedButton(
                                                //       child: Text(
                                                //         'Councelor',
                                                //         style: TextStyle(
                                                //           color: Colors.white,
                                                //           fontSize: 16.sp,
                                                //         ),
                                                //       ),
                                                //       style: ElevatedButton
                                                //           .styleFrom(
                                                //         primary: const Color
                                                //                 .fromRGBO(
                                                //             253, 143, 1, 1),
                                                //         shape:
                                                //             RoundedRectangleBorder(
                                                //           borderRadius:
                                                //               BorderRadius
                                                //                   .circular(
                                                //             16.r,
                                                //           ),
                                                //         ),
                                                //       ),
                                                //       onPressed: () {
                                                //         Navigator.push(
                                                //           context,
                                                //           MaterialPageRoute(
                                                //             builder: (context) =>
                                                //                 const CouncelorSebayaScreen(),
                                                //           ),
                                                //         );
                                                //       },
                                                //     ),
                                                //   ],
                                                // ),
                                              ],
                                            ),
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
                      padding: EdgeInsets.all(4.w),
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
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
                      padding: EdgeInsets.all(4.w),
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
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
                      padding: EdgeInsets.all(4.w),
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
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
                      padding: EdgeInsets.all(4.w),
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Image.asset('assets/images/achievement.png'),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(253, 143, 1, 1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget loadCounseleeData(BuildContext context) {
  Widget buildConselee(BuildContext context) {
    log('sw: ${1.sw} | sh: ${1.sh}', name: 'sw size | sh size');

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
          height: 160.h,
          child: ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                child: Card(
                  child: SizedBox(
                    width: 1.sw <= 400 && 1.sw >= 300 ? 220.w : 195.w,
                    // margin: const EdgeInsets.symmetric(horizontal: 16),
                    // padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.w),
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          child: const Center(
                            child: Text(
                              '{Anonymous Conselee}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        if (1.sh > 100 && 1.sh < 800)
                          SizedBox(height: 24.h)
                        else if (1.sh >= 800)
                          SizedBox(height: 33.h),
                        buildTextChatConselee(context),
                      ],
                    ),
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
        SizedBox(height: 46.6.h),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 1.sw,
            height: 30.h,
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
    String nim = _sharedPreference.getString('nim').toString();

    return FutureBuilder<dynamic>(
      future: _homeController.postGetUserid(nim).then(
            (value) => _homeController.postBeasiswa(value['user_id']),
          ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          } else if (snapshot.connectionState == ConnectionState.done) {
            List list = snapshot.data.content;

            if (list.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                  SizedBox(height: 16.h),
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
                                      '${list[index].namaBeasiswa.substring(0, 25)}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Flexible(
                                      child: Text(
                                        '${list[index].deskripsi.substring(0, 40)}',
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
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  SizedBox(height: 16.h),
                  Card(
                    child: Container(
                      width: 1.sw,
                      height: 60.h,
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Center(
                        child: Text(
                          'Belum ada beasiswa\nyang tersedia',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          } else {
            return Container();
          }
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
              SizedBox(height: 16.h),
              Card(
                child: Container(
                  width: 1.sw,
                  height: 60.h,
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Center(
                    child: Text(
                      'Belum ada beasiswa\nyang tersedia',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget buildFloatingActionButton() {
    String nim = _sharedPreference.getString('nim').toString();
    String id = '';

    _profileController
        .getProfile(nim)
        .then((value) => id = value['data']['id']);

    return FloatingActionButton(
      onPressed: () {
        _homeController.postQuickHelp(id).then((value) {
          Get.snackbar('Quick Help', 'Posting!');
        });
      },
      backgroundColor: Colors.redAccent,
      child: const Icon(Icons.campaign_sharp),
    );
  }
}
