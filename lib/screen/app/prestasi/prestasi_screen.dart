import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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

  Widget headerPrestasi() {
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
                child: Text('Daftar Prestasi',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
              ),
            ),
          ),
          SizedBox(
            width: 60,
            height: MediaQuery.of(context).size.height / 10,
            child: IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardPrestasi(
    String image,
    String title,
    String subtitle,
    String id,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: Row(
          children: [
            Container(
              height: 70,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    image,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 50,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPrestasi(idPenghargaan: id),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getDataPrestasi(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<dynamic>(
          future: _prestasiController.getPretasi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 1,
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
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
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
                          child: cardPrestasi(
                            snapshot.data.data[index].fotoKegiatan,
                            snapshot.data.data[index].namaPenghargaan,
                            snapshot.data.data[index].eventPenghargaan,
                            snapshot.data.data[index].idPenghargaan,
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 1,
                  width: double.infinity,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text('Data kosong'),
                  ),
                );
              }
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerPrestasi(),
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
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  right: 5,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            result.fotoKegiatan,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        height: 50,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              result.namaPenghargaan,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              result.eventPenghargaan,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailPrestasi(
                                                idPenghargaan: snapshot.data
                                                    .data[index].idPenghargaan,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.more_horiz,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
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
