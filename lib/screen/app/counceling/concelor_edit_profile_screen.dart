import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ConcelorEditProfileScreen extends StatefulWidget {
  final String profilePicture;
  final String noReg;
  final String about;
  final String nickName;
  const ConcelorEditProfileScreen({
    Key? key,
    required this.profilePicture,
    required this.noReg,
    required this.about,
    required this.nickName,
  }) : super(key: key);

  @override
  State<ConcelorEditProfileScreen> createState() =>
      _ConcelorEditProfileScreenState();
}

class _ConcelorEditProfileScreenState
    extends State<ConcelorEditProfileScreen> {
  final TextEditingController _noReg = TextEditingController();
  final TextEditingController _nickName = TextEditingController();
  final TextEditingController _about = TextEditingController();

  XFile? image;
  bool status = false;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      status = true;
    });
  }

  Future getCamera(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      status = true;
    });
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
                            getImage(ImageSource.camera);
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
                            getImage(ImageSource.gallery);
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
          Container(
            height: 50,
            width: 50,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                // color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Update Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                  // color: Colors.white,
                  ),
            ),
          ),
          Container(
            height: 50,
            width: 50,
          ),
        ],
      );
    }

    Widget content() {
      return Column(
        children: [
          (image == null)
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
                          image!.path,
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
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: _noReg..text = widget.noReg,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: 'No Registrasi',
                labelStyle: TextStyle(
                  // color: Colors.white,
                  fontSize: 14,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _nickName..text = widget.nickName,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: 'Nickname',
                labelStyle: TextStyle(
                  // color: Colors.white,
                  fontSize: 14,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _about..text = widget.about,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: 'About',
                labelStyle: TextStyle(
                  // color: Colors.white,
                  fontSize: 14,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: style,
                onPressed: () {
                  print(_noReg);
                  print(_nickName);
                  print(_about);
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
