import 'dart:developer';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final GlobalKey scaffoldKey;

  const SplashScreen({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      log('on delay 5s');
    });

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset('assets/images/polosan splash login.png'),
            ),
          ),
          Positioned(
            bottom: 350,
            child: SizedBox(
              height: 140,
              width: 140,
              child: Image.asset('assets/images/logo gerak.gif'),
            ),
          ),
        ],
      ),
    );
  }
}
