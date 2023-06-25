import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

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

  Widget headerDetailPrestasi() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            height: MediaQuery.of(context).size.height / 10,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 10,
              child: Center(
                child: Text(
                  'Detail Prestasi',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 60,
            height: MediaQuery.of(context).size.height / 10,
          ),
        ],
      ),
    );
  }

  Widget contentOne() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 20,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
      ),
    );
  }

  Widget contentTwo() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (namaPrestasi != "") ? namaPrestasi : '-',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget contenThree() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ExpandablePanel(
                theme: const ExpandableThemeData(iconColor: Colors.white),
                header: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Lingkup/Tingkat",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                collapsed: const SizedBox(),
                expanded: Column(
                  children: [
                    Text(
                      (lingkup != "") ? lingkup : "-",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ExpandablePanel(
                theme: const ExpandableThemeData(iconColor: Colors.white),
                header: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Tanggal",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                collapsed: const SizedBox(),
                expanded: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Start Date :',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Text(
                          (startDate != "") ? startDate : "-",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'End Date :',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            (endDate != "") ? endDate : "-",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ExpandablePanel(
                theme: const ExpandableThemeData(iconColor: Colors.white),
                header: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Deksripsi",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                collapsed: const SizedBox(),
                expanded: Padding(
                  padding: const EdgeInsets.all(0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (deskripsi != "") ? deskripsi : '-',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerDetailPrestasi(),
              contentOne(),
              contentTwo(),
              contenThree(),
            ],
          ),
        ),
      ),
    );
  }
}
