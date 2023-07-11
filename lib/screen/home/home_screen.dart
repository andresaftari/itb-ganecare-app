import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/controllers/auth_controller.dart';
import 'package:itb_ganecare/data/controllers/beasiswa_controller.dart';
import 'package:itb_ganecare/data/controllers/home_controller.dart';
import 'package:itb_ganecare/data/controllers/prestasi_controller.dart';
import 'package:itb_ganecare/data/controllers/profile_controller.dart';
import 'package:itb_ganecare/data/sharedprefs.dart';
import 'package:itb_ganecare/models/link_data.dart';
import 'package:itb_ganecare/repositories/app_data_repository.dart';
import 'package:itb_ganecare/screen/app/beasiswa/beasiswa_screen.dart';
import 'package:itb_ganecare/screen/app/beasiswa/detail_beasiswa_screen.dart';
import 'package:itb_ganecare/screen/app/jadwal/jadwal_screen.dart';
import 'package:itb_ganecare/screen/app/mainpage/main_page_beasiswa.dart';
import 'package:itb_ganecare/screen/app/mainpage/main_page_councelee.dart';
import 'package:itb_ganecare/screen/app/mainpage/main_page_councelor.dart';
import 'package:itb_ganecare/screen/app/prestasi/prestasi_screen.dart';
import 'package:itb_ganecare/screen/auth/login_screen.dart';
import 'package:itb_ganecare/themes/custom_themes.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app/prestasi/detail_prestasi_screen.dart';

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
  final BeasiswaController _beasiswaController = Get.find();
  final PrestasiController _prestasiController = Get.find();
  final AuthController _authController = Get.find();

  final SharedPrefUtils _sharedPreference = SharedPrefUtils();

  late Map<String, dynamic> _deviceData = <String, dynamic>{'id': ''};
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String profilePicture = '';
  String deviceId = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getProfileData();
  }

  getProfileData() {
    String noreg = _sharedPreference.getString('noreg').toString();

    _profileController.getProfileV2(noreg).then((value) => {
          setState(() {
            profilePicture = value['data']['conselee']['profilepic_image'];
          }),
        });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout Aplikasi',
            style: GoogleFonts.poppins(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Apakah anda yakin keluar aplikasi Ganecare?',
                  style: GoogleFonts.poppins(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Ya',
                style: GoogleFonts.poppins(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w300,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Sementara untuk logout
                _sharedPreference.putInt('isLogin', 0);
                _authController.azureLogout();

                Get.snackbar('GaneCare', 'Logging Out');

                Get.to(
                  () => LoginScreen(
                    deviceId: deviceId,
                    alertMessage: '',
                    forgotPassLink: LinkData(
                      title: 'A',
                      description: 'B',
                      url: 'C',
                    ),
                  ),
                );
              },
            ),
            TextButton(
              child: Text(
                'Tidak',
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget headerHome() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: 15,
      ),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  _sharedPreference.getString('username').toString(),
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            (profilePicture != "")
                ? GestureDetector(
                    onTap: () {
                      _showMyDialog();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
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
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      _showMyDialog();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget contentMenu(
    BuildContext context,
    int index,
    String icon,
    String title,
  ) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ),
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
                              bottomRight: Radius.circular(16.r),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 16.w,
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
                                        fontFamily: 'Montserrat'),
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
                                      fontFamily: 'Montserrat'),
                                ),
                                SizedBox(height: 8.h),
                                const Center(
                                  child: Text(
                                    'Masuk sebagai :',
                                    style: TextStyle(fontFamily: 'Montserrat'),
                                  ),
                                ),
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
                                            fontFamily: 'Montserrat'),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                          253,
                                          143,
                                          1,
                                          1,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16.r,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MainPageCouncelee(
                                              initialPage: 0,
                                            ),
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
                                            fontFamily: 'Montserrat'),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            253, 143, 1, 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16.r,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MainPageCouncelor(
                                              initialPage: 0,
                                            ),
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
                              bottomRight: Radius.circular(16.r),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
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
                                        fontFamily: 'Montserrat'),
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
                                      fontFamily: 'Montserrat'),
                                ),
                                SizedBox(height: 32.h),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ElevatedButton(
                                    child: Text(
                                      'Lanjutkan',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontFamily: 'Montserrat'),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromRGBO(
                                        253,
                                        143,
                                        1,
                                        1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_sharedPreference
                                                  .getString('councelee_id')
                                                  .toString() !=
                                              '' &&
                                          _sharedPreference
                                                  .getString('councelee_id') !=
                                              null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MainPageCouncelee(
                                              initialPage: 0,
                                            ),
                                          ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MainPageCouncelor(
                                              initialPage: 0,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                );
              });
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPageBeasiswa(
                initialPage: 0,
              ),
            ),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const JadwalScreen(),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PrestasiScreen(),
            ),
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.height / 6,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(
            20,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 10,
              height: MediaQuery.of(context).size.height / 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(
                    icon,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuHome() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 15,
      ),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 6,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    children: [
                      contentMenu(context, 0, 'assets/icons/chat.png', 'Chat'),
                      const SizedBox(
                        width: 10,
                      ),
                      contentMenu(
                          context, 1, 'assets/images/beasiswa.png', 'Beasiswa'),
                      const SizedBox(
                        width: 10,
                      ),
                      contentMenu(
                          context, 2, 'assets/images/konsultasi.png', 'Jadwal'),
                      const SizedBox(
                        width: 10,
                      ),
                      contentMenu(context, 3, 'assets/images/achievement.png',
                          'Prestasi'),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget contentPrestasi(
    String id,
    String title,
    String subtitle,
    String foto,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPrestasi(
              idPenghargaan: id,
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 3,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(
            20,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 5,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    foto,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget prestasiHome() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 15,
      ),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Our Prestasi',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'See all',
                  style: GoogleFonts.poppins(
                    color: Colors.blueAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            FutureBuilder<dynamic>(
              future: _prestasiController.getPretasi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 4,
                        child: const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data.data.length == 0) {
                      return Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 4,
                          child: const Center(
                            child: Text(
                              'Belum terdapat pretasi',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 3.5,
                        child: ListView.builder(
                          itemCount: snapshot.data.data.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(left: (index == 0) ? 0 : 10),
                              child: contentPrestasi(
                                snapshot.data.data[index].idPenghargaan,
                                snapshot.data.data[index].namaPenghargaan,
                                snapshot.data.data[index].eventPenghargaan,
                                snapshot.data.data[index].fotoKegiatan,
                              ),
                            );
                          },
                        ),
                      );
                    }
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 4,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text('Terdapat kesalahan pada server!'),
                      ),
                    );
                  }
                } else {
                  return Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 4,
                    child: const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget contentBeasiswa(
    String title,
    String subtitle,
  ) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          20,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 6,
            height: MediaQuery.of(context).size.height / 8,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget beasiswaHome() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Our Beasiswa',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                    )),
                Text('See all',
                    style: GoogleFonts.poppins(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    )),
              ],
            ),
            FutureBuilder<dynamic>(
              future: _beasiswaController.getBeasiswaTersedia(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 2.5,
                      width: double.infinity,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data['data'].length == 0) {
                      return Center(
                        child: SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 2.5,
                          child: const Center(
                            child: Text(
                              'Belum terdapat beasiswa',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 3,
                        child: ListView.builder(
                          itemCount: snapshot.data['data'].length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(top: (index == 0) ? 0 : 10),
                              child: contentBeasiswa(
                                snapshot.data['data'][index]['nama_beasiswa'],
                                snapshot.data['data'][index]['nama_donatur'],
                              ),
                            );
                            // return Padding(
                            //   padding: const EdgeInsets.all(2.0),
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) => DetailBeasiswa(
                            //             namaBeasiswa: snapshot.data['data']
                            //                 [index]['nama_beasiswa'],
                            //             namaDonatur: snapshot.data['data']
                            //                 [index]['nama_donatur'],
                            //             kuota: snapshot.data['data'][index]
                            //                 ['kuota'],
                            //             anggaran: snapshot.data['data'][index]
                            //                 ['anggaran'],
                            //             awalPem: snapshot.data['data'][index]
                            //                 ['awal_periode_pembiayaan'],
                            //             akhirPem: snapshot.data['data'][index]
                            //                 ['akhir_periode_pembiayaan'],
                            //             deskripsi: snapshot.data['data'][index]
                            //                 ['deskripsi'],
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //     child: Card(
                            //       child: ListTile(
                            //         title: Text(
                            //           snapshot.data['data'][index]
                            //               ['nama_beasiswa'],
                            //           style: const TextStyle(
                            //             fontSize: 14,
                            //             fontWeight: FontWeight.bold,
                            //           ),
                            //         ),
                            //         subtitle: Column(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: [
                            //             Text(
                            //               snapshot.data['data'][index]
                            //                   ['nama_donatur'],
                            //               style: const TextStyle(
                            //                 fontSize: 12,
                            //               ),
                            //             ),
                            //             const SizedBox(
                            //               height: 10,
                            //             ),
                            //             Row(
                            //               children: [
                            //                 const Icon(
                            //                   Icons.calendar_today,
                            //                   color: Colors.blue,
                            //                   size: 10,
                            //                 ),
                            //                 Text(
                            //                   snapshot.data['data'][index]
                            //                       ['tgl_input'],
                            //                   style: const TextStyle(
                            //                     fontSize: 12,
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ],
                            //         ),
                            //         isThreeLine: true,
                            //       ),
                            //     ),
                            //   ),
                            // );
                          },
                        ),
                      );
                    }
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 2.5,
                      width: double.infinity,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Terjadi kesalahan server!',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: double.infinity,
                    child: const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    // int page = 1;
    // _homeController.getQuickHelp().then((value) {
    // log(value.toString(), name: 'get-aja');
    // });

    if (Platform.isAndroid) {
      deviceId = _deviceData['id'];
      // log(_deviceData['id'].toString(), name: 'id');
    } else if (Platform.isIOS) {
      deviceId = _deviceData['identifierForVendor'];
      // log(_deviceData['identifierForVendor'], name: 'id');
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MaterialApp(
        theme: themeNotifier.getTheme(),
        home: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  color: Color(0XFFD3EAFF),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      headerHome(),
                      menuHome(),
                      prestasiHome(),
                      beasiswaHome(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // initialRoute: '/homePage',
        // home: Scaffold(
        //   floatingActionButton: buildFloatingActionButton(),
        //   appBar: AppBar(
        //     elevation: 0,
        //     toolbarHeight: 80.h,
        //     automaticallyImplyLeading: false,
        //     flexibleSpace: Container(
        //       decoration: const BoxDecoration(
        //         gradient: LinearGradient(
        //           colors: [
        //             Color.fromRGBO(0, 171, 233, 1),
        //             Color.fromRGBO(6, 146, 196, 1),
        //           ],
        //           begin: Alignment.centerRight,
        //           end: Alignment.centerLeft,
        //         ),
        //       ),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Container(
        //                 child: Text(
        //                   'Selamat datang',
        //                   style: TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 16.sp,
        //                     fontWeight: FontWeight.w600,
        //                   ),
        //                 ),
        //                 margin: EdgeInsets.only(top: 40.h, left: 24.w),
        //               ),
        //               Container(
        //                 child: Text(
        //                   _sharedPreference.getString('username').toString(),
        //                   style: TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 14.sp,
        //                     fontWeight: FontWeight.w600,
        //                   ),
        //                 ),
        //                 margin: EdgeInsets.only(top: 4.h, left: 24.w),
        //               ),
        //             ],
        //           ),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               GestureDetector(
        //                 onTap: () {},
        //                 child: Container(
        //                   margin: EdgeInsets.only(top: 42.h),
        //                   child: Icon(
        //                     Icons.notifications_rounded,
        //                     color: Colors.white,
        //                     size: 28.sp,
        //                   ),
        //                 ),
        //               ),
        //               SizedBox(width: 8.w),
        //               GestureDetector(
        //                 onTap: () {
        //                   // Sementara untuk logout
        //                   _sharedPreference.putInt('isLogin', 0);

        //                   Get.snackbar('GaneCare', 'Logging Out');
        //                   Get.to(
        //                     () => LoginScreen(
        //                       deviceId: deviceId,
        //                       alertMessage: '',
        //                       forgotPassLink: LinkData(
        //                         title: 'A',
        //                         description: 'B',
        //                         url: 'C',
        //                       ),
        //                     ),
        //                   );
        //                 },
        //                 child: (profilePicture != '')
        //                     ? Container(
        //                         height: 50.h,
        //                         width: 44.w,
        //                         margin: EdgeInsets.only(right: 24.w, top: 32.h),
        //                         decoration: BoxDecoration(
        //                           color: Colors.white,
        //                           shape: BoxShape.circle,
        //                           border: Border.all(
        //                             color: Colors.black,
        //                             width: 0.5.w,
        //                           ),
        //                           image: DecorationImage(
        //                             fit: BoxFit.cover,
        //                             image: NetworkImage(profilePicture),
        //                           ),
        //                           boxShadow: [
        //                             BoxShadow(
        //                               color: Colors.black.withOpacity(0.5),
        //                               blurRadius: 8,
        //                               offset: const Offset(3, 2),
        //                             ),
        //                           ],
        //                         ),
        //                       )
        //                     : Container(
        //                         height: 50.h,
        //                         width: 44.w,
        //                         margin: EdgeInsets.only(right: 24.w, top: 32.h),
        //                         decoration: BoxDecoration(
        //                           color: Colors.white,
        //                           shape: BoxShape.circle,
        //                           image: const DecorationImage(
        //                             fit: BoxFit.cover,
        //                             image: AssetImage('assets/images/cat.png'),
        //                           ),
        //                           border: Border.all(
        //                             color: Colors.black,
        //                             width: 0.5.w,
        //                           ),
        //                           boxShadow: [
        //                             BoxShadow(
        //                               color: Colors.black.withOpacity(0.5),
        //                               blurRadius: 8,
        //                               offset: const Offset(3, 2),
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        //   body: Stack(
        //     children: [
        //       _backgroundContainer(),
        //       Container(
        //         margin: EdgeInsets.symmetric(horizontal: 16.w),
        //         child: SingleChildScrollView(
        //           primary: true,
        //           child: Column(
        //             children: [
        //               buildHomeBody(context),
        //               SizedBox(height: 16.h),
        //               _sharedPreference.checkKey('councelor_id')
        //                   ? buildQuickHelp(context)
        //                   : Container(),
        //               SizedBox(height: 16.h),
        //               buildPrestasi(context),
        //               SizedBox(height: 16.h),
        //               buildBeasiswa(),
        //               // buildScholarshipNews(context),
        //             ],
        //           ),
        //         ),
        //       ),
        //       buildButtonBeasiswa(),
        //     ],
        //   ),
        // ),
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
              'Our Menu',
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
                                              horizontal: 16.w,
                                            ),
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
                                                        backgroundColor:
                                                            const Color
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
                                                                const MainPageCouncelee(
                                                              initialPage: 0,
                                                            ),
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
                                                        backgroundColor:
                                                            const Color
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
                                                                const MainPageCouncelor(
                                                              initialPage: 0,
                                                            ),
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
                                                  'Anda akan membuka aplikasi Pendamping Sebay yang membuat Anda masuk ke mode anonim.\n\n'
                                                  'Data pribadi Anda terkait Nama dan NIM tidak akan diketahui oleh\n'
                                                  'Pendamping Sebaya maupun pengguna lain',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 32.h),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: ElevatedButton(
                                                    child: Text(
                                                      'Lanjutkan',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color.fromRGBO(
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
                                                      if (_sharedPreference
                                                                  .getString(
                                                                      'councelee_id')
                                                                  .toString() !=
                                                              '' &&
                                                          _sharedPreference
                                                                  .getString(
                                                                      'councelee_id') !=
                                                              null) {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const MainPageCouncelee(
                                                              initialPage: 0,
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const MainPageCouncelor(
                                                              initialPage: 0,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPageBeasiswa(
                              initialPage: 0,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 60.h,
                        width: 60.w,
                        padding: EdgeInsets.all(4.w),
                        margin: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Image.asset('assets/images/beasiswa.png'),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(253, 143, 1, 1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    );
                  } else if (index == 2) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const JadwalScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 60.h,
                        width: 60.w,
                        padding: EdgeInsets.all(4.w),
                        margin: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Image.asset('assets/images/konsultasi.png'),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(253, 143, 1, 1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    );
                  } else if (index == 3) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrestasiScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 60.h,
                        width: 60.w,
                        padding: EdgeInsets.all(4.w),
                        margin: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Image.asset('assets/images/achievement.png'),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(253, 143, 1, 1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
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

  Widget buildQuickHelp(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: const Text(
            'Quick help',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          margin: EdgeInsets.only(
            left: 16.w,
            top: 8.h,
            bottom: 8.h,
          ),
        ),
        FutureBuilder<dynamic>(
          future: _homeController.getQuickHelp(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                  width: 1.sw,
                  height: 160.h,
                  child: ListView.builder(
                    itemCount: snapshot.data.data.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Card(
                          child: SizedBox(
                            width: 1.sw <= 400 && 1.sw >= 300 ? 220.w : 195.w,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Center(
                                    child: Text(
                                      _sharedPreference
                                              .getString('nickname')
                                              .toString()
                                              .contains('Konselee')
                                          ? _sharedPreference
                                              .getString('nickname')
                                              .toString()
                                          : 'Konselee',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                if (1.sh > 100 && 1.sh < 800)
                                  SizedBox(height: 24.h)
                                else if (1.sh >= 800)
                                  SizedBox(height: 33.h),
                                Column(
                                  children: [
                                    Text(snapshot.data.data[index].quickHelp),
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
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
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
                    child: const Text('Lorem Ipsum Dolor Sit Amet'),
                  ),
                );
              }
            } else {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: const Text('Lorem Ipsum Dolor Sit Amet'),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget buildPrestasi(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: const Text(
            'Prestasi',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          margin: EdgeInsets.only(
            left: 16.w,
            top: 8.h,
            bottom: 8.h,
          ),
        ),
        FutureBuilder<dynamic>(
          future: _prestasiController.getPretasi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  width: double.infinity,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.data.length == 0) {
                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 5,
                    child: const Center(
                      child: Text(
                        'Belum terdapat pretasi',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 4,
                    child: ListView.builder(
                      itemCount: snapshot.data.data.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPrestasi(
                                  idPenghargaan:
                                      snapshot.data.data[index].idPenghargaan,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: MediaQuery.of(context).size.height / 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: const Offset(2, 2), // Shadow position
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        snapshot.data.data[index].fotoKegiatan,
                                      ),
                                    ),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  height:
                                      MediaQuery.of(context).size.height / 7,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    snapshot.data.data[index].namaPenghargaan,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    snapshot.data.data[index].eventPenghargaan,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today,
                                        color: Colors.blue,
                                        size: 10,
                                      ),
                                      Text(
                                        snapshot
                                            .data.data[index].tahunPerolehan,
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  width: double.infinity,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text('Terdapat kesalahan pada server!'),
                  ),
                );
              }
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                width: double.infinity,
                child: const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  // Widget loadCounseleeData(BuildContext context) {
  Widget buildConselee(BuildContext context) {
    // log('sw: ${1.sw} | sh: ${1.sh}', name: 'sw size | sh size');

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

  Widget buildBeasiswa() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: const Text(
            'Beasiswa',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          margin: EdgeInsets.only(
            left: 16.w,
            top: 8.h,
            bottom: 8.h,
          ),
        ),
        FutureBuilder<dynamic>(
          future: _beasiswaController.getBeasiswaTersedia(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  width: double.infinity,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data['data'].length == 0) {
                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 5,
                    child: const Center(
                      child: Text(
                        'Belum terdapat beasiswa',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 3,
                    child: ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailBeasiswa(
                                    namaBeasiswa: snapshot.data['data'][index]
                                        ['nama_beasiswa'],
                                    namaDonatur: snapshot.data['data'][index]
                                        ['nama_donatur'],
                                    kuota: snapshot.data['data'][index]
                                        ['kuota'],
                                    anggaran: snapshot.data['data'][index]
                                        ['anggaran'],
                                    awalPem: snapshot.data['data'][index]
                                        ['awal_periode_pembiayaan'],
                                    akhirPem: snapshot.data['data'][index]
                                        ['akhir_periode_pembiayaan'],
                                    deskripsi: snapshot.data['data'][index]
                                        ['deskripsi'],
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              child: ListTile(
                                title: Text(
                                  snapshot.data['data'][index]['nama_beasiswa'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data['data'][index]
                                          ['nama_donatur'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          color: Colors.blue,
                                          size: 10,
                                        ),
                                        Text(
                                          snapshot.data['data'][index]
                                              ['tgl_input'],
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                isThreeLine: true,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  width: double.infinity,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Terjadi kesalahan server!',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                width: double.infinity,
                child: const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget buildButtonBeasiswa() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 20,
        margin: const EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orange),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BeasiswaScreen(),
              ),
            );
          },
          child: const Text(
            'Tampilkan lebih banyak',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
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

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    if (Platform.isAndroid) {
      deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
      deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    }

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'id': build.id,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'isPhysicalDevice': build.isPhysicalDevice,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'identifierForVendor': data.identifierForVendor,
      'model': data.model,
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'localizedModel': data.localizedModel,
      'isPhysicalDevice': data.isPhysicalDevice,
    };
  }
}
