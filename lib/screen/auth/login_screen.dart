import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/controllers/auth_controller.dart';
import 'package:itb_ganecare/data/sharedprefs.dart';
import 'package:itb_ganecare/models/link_data.dart';
import 'package:itb_ganecare/screen/home/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  final String deviceId, alertMessage;
  final LinkData forgotPassLink;

  const LoginScreen({
    Key? key,
    required this.deviceId,
    required this.alertMessage,
    required this.forgotPassLink,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String? alertMessage;
  late LinkData? _forgotPasswordLink;

  String username = '', password = '';

  final AuthController _authController = Get.find();
  final SharedPrefUtils _sharedPreference = SharedPrefUtils();

  final _formKey = GlobalKey<FormState>(debugLabel: 'Login');

  void _showDialogLogin() {
    alertMessage = widget.alertMessage;
    _forgotPasswordLink = widget.forgotPassLink;

    if (alertMessage != '') {
      Future.delayed(const Duration(milliseconds: 500), () {
        final text = alertMessage;

        log(alertMessage.toString(), name: 'Alert');

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(child: Text(text!)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        alertMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _showDialogLogin();
    return Scaffold(
      body: Container(
        color: const Color(0xff00acea),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset('assets/images/polosan splash login.png'),
                ),
              ),
              Form(
                key: _formKey,
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: SizedBox(
                          height: 130.h,
                          width: 130.w,
                          child: Image.asset('assets/images/logo gerak.gif'),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Instruction
                      FractionallySizedBox(
                        widthFactor: 0.7,
                        child: FittedBox(
                          child: Text(
                            "Login dengan INA",
                            style: TextStyle(
                              fontSize: 10000.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),

                      // Email field
                      TextFormField(
                        // enabled: state is AuthenticationLoadingState
                        //     ? false
                        //     : true,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          contentPadding: EdgeInsets.all(0.w),
                        ),
                        validator: (usernameValue) {
                          if (usernameValue!.isEmpty) {
                            return 'Tolong input dengan benar';
                          }

                          username = usernameValue;
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),

                      // Password field
                      TextFormField(
                        // enabled: state is AuthenticationLoadingState
                        //     ? false
                        //     : true,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          contentPadding: EdgeInsets.all(0.w),
                        ),
                        validator: (passwordValue) {
                          if (passwordValue!.isEmpty) {
                            return 'Tolong input dengan benar';
                          }
                          password = passwordValue;
                          return null;
                        },
                      ),

                      SizedBox(height: 30.h),

                      //Button
                      ButtonTheme(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                          ),
                          child: FittedBox(
                            child: Text(
                              'Login',
                              // state is AuthenticationLoadingState
                              //     ? 'Processing...'
                              //     : 'Login',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _authController
                                  .postLogin(
                                username,
                                password,
                                widget.deviceId,
                              )
                                  .then((value) {
                                if (value.statusCode == 200) {
                                  _sharedPreference.putString(
                                    'username',
                                    username,
                                  );

                                  _sharedPreference.putString(
                                    'name',
                                    value.data.name,
                                  );

                                  _sharedPreference.putString(
                                    'nim',
                                    value.data.nim,
                                  );

                                  _sharedPreference.putString(
                                    'token_user',
                                    value.auth.tokenMahasiswa.token,
                                  );

                                  _sharedPreference.putInt(
                                    'angkatan',
                                    value.auth.user.angkatan,
                                  );

                                  _sharedPreference.putString(
                                    'major',
                                    value.auth.user.jurusan,
                                  );

                                  _sharedPreference.putString(
                                    'gender',
                                    value.auth.user.gender,
                                  );

                                  if (value.userGroup.conselee == '') {
                                    _sharedPreference.putString(
                                      'councelee_id',
                                      value.userGroup.conselee,
                                    );
                                  } else if (value.userGroup.conselee != '') {
                                    _sharedPreference.putString(
                                      'councelee_id',
                                      value.userGroup.conselee,
                                    );
                                  }

                                  if (value.userGroup.conselor == '') {
                                    _sharedPreference.putString(
                                      'councelor_id',
                                      value.userGroup.conselor,
                                    );
                                  } else if (value.userGroup.conselor != '') {
                                    _sharedPreference.putString(
                                      'councelor_id',
                                      value.userGroup.conselor,
                                    );
                                  }

                                  Get.off(
                                    () => const HomePage(isDarkMode: false),
                                  );
                                }
                              });

                              // In case of server error, uncomment these code
                              // below & comment the main code above to check
                              // login-screen function
                              // Get.off(
                              //       () => const HomePage(isDarkMode: false),
                              // );
                            }
                          },
                        ),
                      ),
                      // if (_forgotPasswordLink != null)
                      // Padding(
                      //   padding: EdgeInsets.all(10.w),
                      //   child: InkWell(
                      //     onTap: _launchLupaPassword,
                      //     child: const Text(
                      //       'Lupa password?',
                      //       style: TextStyle(color: Colors.red),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchLupaPassword() async {
    if (await canLaunch(_forgotPasswordLink!.url)) {
      await launch(_forgotPasswordLink!.url, forceWebView: false);
    } else {
      throw 'Could not launch ${_forgotPasswordLink!.url}';
    }
  }
}
