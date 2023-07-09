import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/controllers/beasiswa_controller.dart';
import 'package:itb_ganecare/screen/app/beasiswa/detail_beasiswa_screen.dart';

class BeasiswakuScreen extends StatefulWidget {
  const BeasiswakuScreen({Key? key}) : super(key: key);

  @override
  State<BeasiswakuScreen> createState() => _BeasiswakuScreenState();
}

class _BeasiswakuScreenState extends State<BeasiswakuScreen> {
  Widget getDataBeasiswa(BuildContext context) {
    final BeasiswaController _beasiswaController = Get.find();
    return Column(
      children: [
        FutureBuilder<dynamic>(
          future: _beasiswaController.getBeasiswaKu(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 1.2,
                  width: double.infinity,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1,
                  child: ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailBeasiswa(
                                  namaBeasiswa: snapshot.data['data'][index]
                                      ['nama_beasiswa'],
                                  namaDonatur: snapshot.data['data'][index]
                                      ['nama_donatur'],
                                  kuota: snapshot.data['data'][index]['kuota'],
                                  anggaran: snapshot.data['data'][index]
                                      ['anggaran'],
                                  awalPem: snapshot.data['data'][index]
                                          ['awal_periode_pembiayaan'] ??
                                      '',
                                  akhirPem: snapshot.data['data'][index]
                                          ['akhir_periode_pembiayaan'] ??
                                      '',
                                  deskripsi: snapshot.data['data'][index]
                                      ['deskripsi'],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(
                                snapshot.data['data'][index]['nama_beasiswa'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data['data'][index]
                                        ['nama_donatur'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today,
                                        color: Colors.blue,
                                        size: 10,
                                      ),
                                      Text(
                                        snapshot.data['data'][index]
                                            ['tgl_input'],
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              isThreeLine: true,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 1.2,
                  width: double.infinity,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text('Data kosong'),
                  ),
                );
              }
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.2,
                width: double.infinity,
                child: const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 6,
          ),
          child: Column(
            children: [
              getDataBeasiswa(context),
            ],
          ),
        ),
      ),
    );
  }
}
