import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itb_ganecare/screen/app/beasiswa/beasiswa_webview_screen.dart';

import '../../../data/controllers/prestasi_controller.dart';

class DetailBeasiswa extends StatefulWidget {
  final String namaBeasiswa;
  final String namaDonatur;
  final String kuota;
  final String anggaran;
  final String awalPem;
  final String akhirPem;
  final String deskripsi;

  const DetailBeasiswa({
    Key? key,
    required this.namaBeasiswa,
    required this.namaDonatur,
    required this.kuota,
    required this.anggaran,
    required this.awalPem,
    required this.akhirPem,
    required this.deskripsi,
  }) : super(key: key);

  @override
  State<DetailBeasiswa> createState() => _DetailBeasiswaState();
}

class _DetailBeasiswaState extends State<DetailBeasiswa> {
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

  Widget contentOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Text(
          widget.namaBeasiswa,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20.h,
        ),
        // Container(
        //   height: 250.h,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     color: Colors.grey.shade300,
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Row(
        //       children: [
        //         const Icon(
        //           Icons.person,
        //           color: Colors.black,
        //         ),
        //         Text(
        //           widget.kuota + 'orang',
        //         ),
        //       ],
        //     ),
        //     Row(
        //       children: const [
        //         Icon(
        //           Icons.timer,
        //           color: Colors.black,
        //         ),
        //         Text('60 Hari'),
        //       ],
        //     ),
        //   ],
        // )
      ],
    );
  }

  Widget contentTwo() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      height: MediaQuery.of(context).size.height / 3.5,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Deskripsi Beasiswa',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 200,
                  height: 20,
                  child: Text(
                    'Nama Donatur',
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 20,
                    child: Text(
                      ': ' + widget.namaDonatur,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 200,
                  height: 20,
                  child: Text(
                    'Kuota',
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 20,
                    child: Text(': ' + widget.kuota),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 200,
                  height: 20,
                  child: Text(
                    'Anggaran',
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 20,
                    child: Text(': ' + widget.anggaran),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 200,
                  height: 20,
                  child: Text(
                    'Awal periode pembayaran',
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 20,
                    child: Text(': ' + widget.awalPem),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 200,
                  height: 20,
                  child: Text(
                    'Akhir periode pembayaran',
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 20,
                    child: Text(': ' + widget.akhirPem),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Deskripsi lainnya',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            (widget.deskripsi != "")
                ? Text(widget.deskripsi)
                : const Text(
                    'Tidak terdapat deskripsi',
                  ),
          ],
        ),
      ),
    );
  }

  Widget contentThree() {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Berkas Pengajuan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 2,
            color: Colors.grey.shade300,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Persyaratan berkas',
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            '1. Bukti pembayaran kuliah',
          ),
          const Text(
            '2. Bukti sertifikat',
          ),
          const Text(
            '3. Rekomendasi Dosen',
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 2,
            color: Colors.grey.shade300,
          ),
          const SizedBox(
            height: 10,
          ),
          // DottedBorder(
          //   borderType: BorderType.RRect,
          //   radius: Radius.circular(20),
          //   dashPattern: [10, 10],
          //   color: Colors.grey,
          //   strokeWidth: 2,
          //   child: Container(
          //     padding: const EdgeInsets.only(left: 10, right: 10),
          //     width: double.infinity,
          //     height: MediaQuery.of(context).size.height / 15,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         (img == null) ? const Text('Pilih berkas') : Text(img!.name),
          //         IconButton(
          //           onPressed: () {
          //             getImage();
          //           },
          //           icon: const Icon(
          //             Icons.upload,
          //             color: Colors.blue,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget contentFourth() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 15,
      margin: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        // onPressed: (img == null) ? null : () {},
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BeasiswaWebViewScreen(),
            ),
          );
        },
        child: const Text(
          'Lihat Beasiswa',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Detail Beasiswa')),
        actions: const [
          SizedBox(
            width: 35,
            height: 20,
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                contentOne(),
                contentTwo(),
                contentThree(),
                contentFourth(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
