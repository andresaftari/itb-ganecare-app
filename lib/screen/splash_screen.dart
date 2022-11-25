import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itb_ganecare/models/link_data.dart';
import 'package:itb_ganecare/screen/auth/login_screen.dart';

class SplashScreen extends StatelessWidget {
  final GlobalKey scaffoldKey;

  const SplashScreen({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      log('on delay 5s', name: 'loading');

      Navigator.pushReplacement(
        context,
        // MaterialPageRoute(
        //   builder: (context) => HomePage(
        //     scaffoldKey: scaffoldKey,
        //     isDarkMode: false,
        //   ),
        // ),
        MaterialPageRoute(
          builder: (context) => LoginScreen(
            deviceId: '0001',
            alertMessage: '',
            scaffoldKey: scaffoldKey,
            forgotPassLink: LinkData(title: 'A', description: 'B', url: 'C'),
          ),
        ),
      );
    });

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset('assets/images/polosan splash login.png'),
            ),
          ),
          Positioned(
            bottom: 350.h,
            child: SizedBox(
              height: 140.h,
              width: 140.w,
              child: Image.asset('assets/images/logo gerak.gif'),
            ),
          ),
        ],
      ),
    );
  }
}
