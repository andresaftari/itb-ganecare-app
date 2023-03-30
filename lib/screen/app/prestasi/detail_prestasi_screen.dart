import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../data/controllers/prestasi_controller.dart';

class DetailPrestasi extends StatefulWidget {
  final String idPenghargaan;
  const DetailPrestasi({
    Key? key,
    required this.idPenghargaan,
  }) : super(key: key);

  @override
  State<DetailPrestasi> createState() => _DetailPrestasiState();
}

class _DetailPrestasiState extends State<DetailPrestasi> {
  final PrestasiController _prestasiController = Get.find();
  @override
  void initState() {
    getPrestasiData();
    return super.initState();
  }

  String namaPrestasi = '';
  String lingkup = '';
  String penyelenggara = '';
  String deskripsi = '';
  String fotoKegiatan = '';
  String startDate = '';
  String endDate = '';

  getPrestasiData() {
    _prestasiController
        .getDetailPrestasi(widget.idPenghargaan)
        .then((value) => {
              setState(() {
                for (var data in value['data']) {
                  namaPrestasi = data['nama_penghargaan'];
                  lingkup = data['tingkat'];
                  penyelenggara = data['lembaga'];
                  deskripsi = data['penghargaan_deskripsi'];
                  startDate = data['penghargaan_tanggal'];
                  endDate = data['penghargaan_tanggal_berakhir'];
                  fotoKegiatan = data['foto_kegiatan'];
                }
              }),
            });
  }

  Widget contentOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Text(
          (namaPrestasi != '') ? namaPrestasi : 'Data kosong',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20.h,
        ),
        (fotoKegiatan != "")
            ? Container(
                height: 250.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(fotoKegiatan), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20),
                ),
              )
            : Container(
                height: 250.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
      ],
    );
  }

  Widget contentTwo() {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 150,
              height: 20,
              child: Text('Lingkup/Tingkat'),
            ),
            Expanded(
              child: SizedBox(
                height: 20,
                child: Text(': $lingkup'),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            const SizedBox(
              width: 150,
              height: 20,
              child: Text('Tanggal'),
            ),
            Expanded(
              child: SizedBox(
                height: 20,
                child: Text(': $startDate sd $endDate'),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            const SizedBox(
              width: 150,
              height: 20,
              child: Text('Penyelenggara'),
            ),
            Expanded(
              child: SizedBox(
                height: 30,
                child: Text(
                  ': $penyelenggara',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }

  Widget contenThree() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (deskripsi != '')
                ? Text(deskripsi)
                : const Text('Belum terdapat deskripsi'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Detail Prestasi')),
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
                contenThree(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
