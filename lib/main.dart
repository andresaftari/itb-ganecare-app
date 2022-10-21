import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itb_ganecare/screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

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

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'ITB Wellbeing apps',
      // debugShowCheckedModeBanner: true,
      home: SplashScreen(scaffoldKey: scaffoldKey),
      // home: MultiRepositoryProvider(
      //   providers: [],
      //   child: MultiBlocProvider(
      //     providers: [],
      //     child: BlocConsumer(
      //       // listenWhen: (_, state) {},
      //       listener: (context, state) {},
      //       builder: (context, state) {
      //         return Container();
      //       },
      //       // buildWhen: (context, state) {},
      //     ),
      //   ),
      // ),
    );
  }
}
