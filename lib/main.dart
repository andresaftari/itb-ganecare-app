import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:itb_ganecare/data/controllers/auth_controller.dart';
import 'package:itb_ganecare/data/controllers/counseling_controller.dart';
import 'package:itb_ganecare/data/controllers/home_controller.dart';
import 'package:itb_ganecare/data/controllers/profile_controller.dart';
import 'package:itb_ganecare/data/sharedprefs.dart';
import 'package:itb_ganecare/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting();

  await ProfileSharedPreference.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    precacheImage(
      const AssetImage('assets/images/logo gerak.gif'),
      context,
    );
    precacheImage(
      const AssetImage('assets/images/logo fix2.png'),
      context,
    );
    precacheImage(
      const AssetImage('assets/images/polosan splash login.png'),
      context,
    );

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => CounselingController());
    Get.lazyPut(() => ProfileController());

    return ScreenUtilInit(
      builder: (context) {
        return const GetMaterialApp(
          // initialBinding: ,
          title: 'ITB Wellbeing apps',
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
