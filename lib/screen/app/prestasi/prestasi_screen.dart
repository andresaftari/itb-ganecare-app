import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/controllers/prestasi_controller.dart';
import 'package:itb_ganecare/models/prestasi_model.dart';
import 'package:itb_ganecare/screen/app/prestasi/detail_prestasi_screen.dart';

class PrestasiScreen extends StatefulWidget {
  const PrestasiScreen({Key? key}) : super(key: key);

  @override
  State<PrestasiScreen> createState() => _PrestasiScreenState();
}

class _PrestasiScreenState extends State<PrestasiScreen> {
  final PrestasiController _prestasiController = Get.find();

  Widget getDataPrestasi(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<dynamic>(
          future: _prestasiController.getPretasi(),
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
                    itemCount: snapshot.data.data.length,
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
                                builder: (context) => DetailPrestasi(
                                  idPenghargaan:
                                      snapshot.data.data[index].idPenghargaan,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      snapshot.data.data[index].fotoKegiatan,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                snapshot.data.data[index].namaPenghargaan,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data.data[index].eventPenghargaan,
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
                                        snapshot
                                            .data.data[index].tahunPerolehan,
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
        title: const Center(child: Text('Daftar Prestasi')),
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
              getDataPrestasi(context),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final PrestasiController _prestasiController = Get.find();
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
    //     itemCount: matchQuery.length,
    //     itemBuilder: ((context, index) {
    //       var result = matchQuery[index];
    //       return Padding(
    //         padding: const EdgeInsets.all(2.0),
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
    //       );
    //     }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<DataPrestasi> matchQuery = [];

    _prestasiController.getPretasi().then((value) {
      for (var data in value.data) {
        if (data.namaPenghargaan.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(DataPrestasi(
              idPenghargaan: data.idPenghargaan,
              fotoKegiatan: data.fotoKegiatan,
              namaPenghargaan: data.namaPenghargaan,
              eventPenghargaan: data.eventPenghargaan,
              capaian: data.capaian,
              tingkat: data.tingkat,
              lembaga: data.lembaga,
              tahunPerolehan: data.tahunPerolehan,
              statusIndividuKelompok: data.statusIndividuKelompok,
              nilai: data.nilai));
        }
      }
    });
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<dynamic>(
            future: _prestasiController.getPretasi(),
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
                              //     builder: (context) => DetailPrestasi(
                              //       idPenghargaan:
                              //           snapshot.data.data[index].idPenghargaan,
                              //     ),
                              //   ),
                              // );
                            },
                            child: Card(
                              child: ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        result.fotoKegiatan,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  result.namaPenghargaan,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      result.eventPenghargaan,
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
                                          result.tahunPerolehan,
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
