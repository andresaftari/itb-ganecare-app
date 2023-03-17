import 'dart:async';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itb_ganecare/screen/app/mainpage/main_page_councelor.dart';

import '../../../data/controllers/profile_controller.dart';

class ConcelorEditProfileScreen extends StatefulWidget {
  final String profilePicture;
  final String noReg;
  final String about;
  final String nickName;
  final String role;
  const ConcelorEditProfileScreen({
    Key? key,
    required this.profilePicture,
    required this.noReg,
    required this.about,
    required this.nickName,
    required this.role,
  }) : super(key: key);

  @override
  State<ConcelorEditProfileScreen> createState() =>
      _ConcelorEditProfileScreenState();
}

class _ConcelorEditProfileScreenState extends State<ConcelorEditProfileScreen> {
  // final TextEditingController _noReg = TextEditingController();
  // final TextEditingController _nickName = TextEditingController();
  // final TextEditingController _about = TextEditingController();

  bool isLoading = false;
  final ProfileController _profileController = Get.find();
  final _formKey = GlobalKey<FormState>();
  String noReg = '';
  String nickName = '';
  String about = '';

  XFile? img;
  bool status = false;

  final ImagePicker picker = ImagePicker();
  File? _image;

  Future getImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    try {
      // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      // ignore: unnecessary_null_comparison
      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() {
        img = image;
        _image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed cause: $e');
    }
  }

  Future getCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    try {
      // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      // ignore: unnecessary_null_comparison
      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() {
        img = image;
        _image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed cause: $e');
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            getCamera();
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.camera,
                          ),
                        ),
                        Text(
                          'Pilih kamera',
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            getImage();
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.image,
                          ),
                        ),
                        Text(
                          'Pilih galeri',
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Tutup',
                style: TextStyle(
                  color: Colors.grey,
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

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Row(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: IconButton(
              onPressed: () {
                Get.to(const MainPageCouncelor(initialPage: 2));
              },
              icon: const Icon(
                Icons.arrow_back,
                // color: Colors.white,
              ),
            ),
          ),
          const Expanded(
            child: Text(
              'Update Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                  // color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(
            height: 50,
            width: 50,
          ),
        ],
      );
    }

    Widget content() {
      return Column(
        children: [
          (img == null)
              ? Container(
                  height: 100.h,
                  width: 100.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                    image: DecorationImage(
                        image: NetworkImage(widget.profilePicture),
                        fit: BoxFit.cover),
                    border: Border.all(
                      color: Colors.white,
                      width: 10,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            _showMyDialog();
                          },
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  height: 100.h,
                  width: 100.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(
                        File(
                          img!.path,
                        ),
                      ),
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 10,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            _showMyDialog();
                          },
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      );
    }

    Widget dataForm() {
      final ButtonStyle style = ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
        ),
      );
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    readOnly: true,
                    initialValue: widget.noReg,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'No Reg',
                      labelStyle: const TextStyle(
                        fontSize: 14,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: widget.nickName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some nickname';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        nickName = value!;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Enter nickname',
                      labelStyle: const TextStyle(
                        fontSize: 14,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: widget.about,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some about';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        about = value!;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Enter about',
                      labelStyle: const TextStyle(
                        fontSize: 14,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            isLoading
                ? const SpinKitFadingCircle(
                    size: 40,
                    color: Colors.blue,
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: style,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          setState(() {
                            isLoading = true;
                          });
                          if (_image == null) {
                            _profileController
                                .updateProfile(
                                    widget.noReg, nickName, about, widget.role)
                                .then((value) => {
                                      if (value == 200)
                                        {
                                          Flushbar(
                                            duration: const Duration(
                                                milliseconds: 3000),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            backgroundColor: Colors.green,
                                            titleText: const Text(
                                              'Update Success',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            messageText: const Text(
                                              'Berhasil melakukan update',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ).show(context),
                                          setState(() {
                                            var duration = const Duration(
                                                milliseconds: 3000);
                                            Timer(duration, () {
                                              setState(() {
                                                isLoading = false;
                                                Get.to(
                                                  const MainPageCouncelor(
                                                      initialPage: 2),
                                                );
                                              });
                                            });
                                          }),
                                        }
                                      else
                                        {
                                          Flushbar(
                                            duration: const Duration(
                                                milliseconds: 2000),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            backgroundColor: Colors.red,
                                            titleText: const Text(
                                              'Update failed',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            messageText: const Text(
                                              'Gagal melakukan update',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ).show(context),
                                          setState(() {
                                            isLoading = false;
                                          })
                                        }
                                    });
                          } else {
                            _profileController
                                .updatePhoto(widget.noReg, _image!, widget.role)
                                .then((value) {
                              print('Berhasil brow');
                            });
                            _profileController
                                .updateProfile(
                                    widget.noReg, nickName, about, widget.role)
                                .then((value) => {
                                      if (value == 200)
                                        {
                                          Flushbar(
                                            duration: const Duration(
                                                milliseconds: 3000),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            backgroundColor: Colors.green,
                                            titleText: const Text(
                                              'Update Success',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            messageText: const Text(
                                              'Berhasil melakukan update',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ).show(context),
                                          setState(() {
                                            var duration = const Duration(
                                                milliseconds: 3000);
                                            Timer(duration, () {
                                              setState(() {
                                                isLoading = false;
                                                Get.to(
                                                  const MainPageCouncelor(
                                                      initialPage: 2),
                                                );
                                              });
                                            });
                                          }),
                                        }
                                      else
                                        {
                                          Flushbar(
                                            duration: const Duration(
                                                milliseconds: 2000),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            backgroundColor: Colors.red,
                                            titleText: const Text(
                                              'Update failed',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            messageText: const Text(
                                              'Gagal melakukan update',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ).show(context),
                                          setState(() {
                                            isLoading = false;
                                          })
                                        }
                                    });
                          }
                        } else {
                          Flushbar(
                            duration: const Duration(milliseconds: 2000),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Colors.red,
                            titleText: const Text(
                              'Update failed!',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            messageText: const Text(
                              'Terdapat inputan kosong',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ).show(context);
                          setState(() {
                            isLoading = true;
                          });
                          var duration = const Duration(milliseconds: 500);
                          Timer(duration, () {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        }
                      },
                      child: const Text('Update'),
                    ),
                  ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        // backgroundColor: Colors.blue,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                header(),
                content(),
                dataForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
