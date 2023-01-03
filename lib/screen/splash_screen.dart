import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itb_ganecare/models/link_data.dart';
import 'package:itb_ganecare/screen/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  final GlobalKey scaffoldKey;

  const SplashScreen({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Map<String, dynamic> _deviceData = <String, dynamic>{};
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    String deviceId = '';

    if (Platform.isAndroid) {
      deviceId = _deviceData['id'];
      log(_deviceData['id'], name: 'id');
    } else if (Platform.isIOS) {
      deviceId = _deviceData['identifierForVendor'];
      log(_deviceData['identifierForVendor'], name: 'id');
    }

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
            deviceId: deviceId,
            alertMessage: '',
            scaffoldKey: widget.scaffoldKey,
            forgotPassLink: LinkData(title: 'A', description: 'B', url: 'C'),
          ),
        ),
      );
    });

    return Scaffold(
      key: widget.scaffoldKey,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height:  MediaQuery.of(context).size.height,
            width:  MediaQuery.of(context).size.width,
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

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    if (Platform.isAndroid) {
      deviceData =
          _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
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
