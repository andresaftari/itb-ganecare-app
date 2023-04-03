import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/controllers/beasiswa_controller.dart';
import 'package:itb_ganecare/models/beasiswaku_model.dart';
import 'package:itb_ganecare/models/dummy_prestasi.dart';
import 'package:itb_ganecare/screen/app/beasiswa/detail_beasiswa_screen.dart';

class BeasiswaScreen extends StatefulWidget {
  const BeasiswaScreen({Key? key}) : super(key: key);

  @override
  State<BeasiswaScreen> createState() => _BeasiswaScreenState();
}

class _BeasiswaScreenState extends State<BeasiswaScreen> {
  final BeasiswaController _beasiswaController = Get.find();
  Widget getDataBeasiswa(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<dynamic>(
          future: _beasiswaController.getBeasiswaTersedia(),
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
                                      "",
                                  akhirPem: snapshot.data['data'][index]
                                          ['akhir_periode_pembiayaan'] ??
                                      "",
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Center(
          child: Text('Daftar Beasiswa'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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

class CustomSearchDelegate extends SearchDelegate {
  final BeasiswaController _beasiswaController = Get.find();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
    // List<DummyPrestasi> matchQuery = [];
    // for (var title in mockPrestasi) {
    //   if (title.title.toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(title);
    //   }
    // }
    // return ListView.builder(
    //   itemCount: matchQuery.length,
    //   itemBuilder: ((context, index) {
    //     var result = matchQuery[index];
    //     return Padding(
    //       padding: const EdgeInsets.all(2.0),
    //       child: GestureDetector(
    //         onTap: () {
    //           print('build result');
    //         },
    //         child: Card(
    //           child: ListTile(
    //             leading: Container(
    //               height: 50,
    //               width: 50,
    //               decoration: const BoxDecoration(
    //                 image: DecorationImage(
    //                   fit: BoxFit.cover,
    //                   image: AssetImage('assets/images/cat.png'),
    //                 ),
    //               ),
    //             ),
    //             title: Text(
    //               result.title,
    //               style: const TextStyle(
    //                 fontSize: 14,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //             subtitle: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   result.subtitle,
    //                   style: const TextStyle(
    //                     fontSize: 12,
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   height: 10,
    //                 ),
    //                 Row(
    //                   children: [
    //                     const Icon(
    //                       Icons.calendar_today,
    //                       color: Colors.blue,
    //                       size: 10,
    //                     ),
    //                     Text(
    //                       result.date,
    //                       style: const TextStyle(
    //                         fontSize: 12,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //             isThreeLine: true,
    //           ),
    //         ),
    //       ),
    //     );
    //   }),
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Datum> matchQuery = [];

    _beasiswaController.getBeasiswaTersedia().then((value) {
      for (var data in value['data']) {
        if (data['nama_beasiswa'].toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(Datum(
            namaDonatur: data['nama_donatur'],
            namaBeasiswa: data['nama_beasiswa'],
            anggaran: data['anggaran'],
            kuota: data['kuota'],
            idPermohonan: data['id_permohonan'],
            useridPemohon: data['userid_pemohon'],
            noReg: data['no_reg'],
            nim: data['nim'],
            idBeasiswa: data['id_beasiswa'],
            tglInput: data['tgl_input'],
            awalPeriodePembiayaan: data['awal_periode_pembiayaan'] ?? "",
            akhirPeriodePembiayaan: data['akhir_periode_pembiayaan'] ?? "",
            prioritasKe: data['prioritas_ke'],
            status: data['status'],
            idPeriode: data['id_periode'],
            modifyDate: data['modify_date'],
            cek: data['cek'],
            statusName: data['status_name'],
          ));
        }
      }
    });
    // print(matchQuery);
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<dynamic>(
            future: _beasiswaController.getBeasiswaTersedia(),
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
                      itemCount: matchQuery.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var result = matchQuery[index];

                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => DetailBeasiswa(
                              //       namaBeasiswa: snapshot.data['data'][index]
                              //           ['nama_beasiswa'],
                              //       namaDonatur: snapshot.data['data'][index]
                              //           ['nama_donatur'],
                              //       kuota: snapshot.data['data'][index]
                              //           ['kuota'],
                              //       status: snapshot.data['data'][index]
                              //           ['status_name'],
                              //     ),
                              //   ),
                              // );
                            },
                            child: Card(
                              child: ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          // snapshot.data.data[index].fotoKegiatan,
                                          'assets/images/cat.png'),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  result.namaBeasiswa,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      result.namaDonatur,
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
                                          result.tglInput,
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
      ),
    );
  }
}
