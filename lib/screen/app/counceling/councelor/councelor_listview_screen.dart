import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itb_ganecare/data/sharedprefs.dart';
import 'package:itb_ganecare/data_provider/chat_room_utils.dart';
import 'package:itb_ganecare/models/chats.dart';

import '../../../../data/controllers/profile_controller.dart';
import '../../../home/home_screen.dart';

class CouncelorListViewScreen extends StatefulWidget {
  const CouncelorListViewScreen({Key? key}) : super(key: key);

  @override
  State<CouncelorListViewScreen> createState() =>
      _CouncelorListViewScreenState();
}

class _CouncelorListViewScreenState extends State<CouncelorListViewScreen> {
  final SharedPrefUtils _sharedPreference = SharedPrefUtils();
  final FirestoreUtils _firestoreUtils = FirestoreUtils();

  final RxList<String> isApproved = <String>[].obs;
  final RxList<String> isEnded = <String>[].obs;
  final ProfileController _profileController = Get.find();
  String profilePicture = '';

  @override
  void initState() {
    getProfileData();
    return super.initState();
  }

  getProfileData() {
    String noreg = _sharedPreference.getString('noreg').toString();
    _profileController.getProfileV2(noreg).then((value) => {
          setState(() {
            profilePicture = value['data']['conselor']['profilepic_image'];
          })
        });
  }

  Future<void> _showMyDialog(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Konfirmasi Request',
            style: GoogleFonts.poppins(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Apakah anda menyetujui request concelee ini?',
                  style: GoogleFonts.poppins(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Ya',
                style: GoogleFonts.poppins(
                  color: Colors.green,
                  fontWeight: FontWeight.w300,
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await _firestoreUtils.updateRoom(
                  id,
                  'approve',
                );
              },
            ),
            TextButton(
              child: Text(
                'Tidak',
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontWeight: FontWeight.w300,
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await _firestoreUtils.updateRoom(
                  id,
                  'ended',
                );
              },
            ),
            TextButton(
              child: Text(
                'Tutup',
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                ),
              ),
              onPressed: () async {
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
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            buildHeader(context),
            // buildCouncelee(context),
            buildListRequest(context),
          ],
        ),
      ),
    );
  }

  StreamBuilder buildListRequest(BuildContext context) {
    String currentUserId =
        _sharedPreference.getString('councelor_id').toString();

    List<Rooms> rooms = [];
    List<Rooms> temp = [];

    return StreamBuilder<List<Rooms>>(
      stream: _firestoreUtils.getLiveChatRoom(),
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasData) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            rooms = snap.data;
            // log(rooms.toString(), name: 'test');

            if (temp.isNotEmpty) temp.clear();
            for (final r in rooms) {
              if (r.roomStatus == 'request') {
                temp.add(r);
              }
            }

            return Container(
              width: 1.sw,
              height: 1.sh,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 15,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Pilih',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Concelee',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: temp.length,
                    itemBuilder: (context, index) {
                      if (temp[index].idConselor.toString() == currentUserId) {
                        return Container(
                          width: 1.sw,
                          height: 80.h,
                          padding: EdgeInsets.all(8.w),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  image: const DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                      'assets/images/cat.png',
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Anonymous',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            softWrap: true,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          temp[index]
                                                      .genderConselee
                                                      .toString() ==
                                                  'P'
                                              ? const Icon(
                                                  Icons.female,
                                                  color: Colors.pinkAccent,
                                                  size: 15,
                                                )
                                              : const Icon(
                                                  Icons.male,
                                                  color: Colors.blueAccent,
                                                  size: 15,
                                                ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Row(
                                        children: [
                                          Text(
                                            '#${temp[index].idConselee}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            '-',
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            rooms[index].generationConselee,
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            '-',
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            temp[index].majorConselee.contains(
                                                    'Tahap Tahun Pertama')
                                                ? temp[index]
                                                    .majorConselee
                                                    .substring(20)
                                                : temp[index]
                                                        .majorConselee
                                                        .contains(
                                                            'Tahap Tahun Kedua')
                                                    ? temp[index]
                                                        .majorConselee
                                                        .substring(18)
                                                    : temp[index]
                                                            .majorConselee
                                                            .contains(
                                                                'Tahap Tahun Ketiga')
                                                        ? temp[index]
                                                            .majorConselee
                                                            .substring(19)
                                                        : temp[index]
                                                                .majorConselee
                                                                .contains(
                                                                    'Tahap Tahun Keempat')
                                                            ? temp[index]
                                                                .majorConselee
                                                                .substring(20)
                                                            : temp[index]
                                                                .majorConselee,
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _showMyDialog(temp[index].id);
                                },
                                icon: Icon(
                                  Icons.more_horiz,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              // Column(
                              //   children: [
                              //     Row(
                              //       children: [
                              //         Text(
                              //           rooms[index].generationConselee,
                              //           style: TextStyle(
                              //             backgroundColor:
                              //                 Colors.grey.withOpacity(0.4),
                              //             color: Colors.black,
                              //             fontWeight: FontWeight.w500,
                              //             fontSize: 9.sp,
                              //           ),
                              //         ),
                              //         SizedBox(width: 2.w),
                              //         Text(
                              //           temp[index]
                              //                   .majorConselee
                              //                   .contains('Tahap Tahun Pertama')
                              //               ? temp[index]
                              //                   .majorConselee
                              //                   .substring(20)
                              //               : temp[index]
                              //                       .majorConselee
                              //                       .contains(
                              //                           'Tahap Tahun Kedua')
                              //                   ? temp[index]
                              //                       .majorConselee
                              //                       .substring(18)
                              //                   : temp[index]
                              //                           .majorConselee
                              //                           .contains(
                              //                               'Tahap Tahun Ketiga')
                              //                       ? temp[index]
                              //                           .majorConselee
                              //                           .substring(19)
                              //                       : temp[index]
                              //                               .majorConselee
                              //                               .contains(
                              //                                   'Tahap Tahun Keempat')
                              //                           ? temp[index]
                              //                               .majorConselee
                              //                               .substring(20)
                              //                           : temp[index]
                              //                               .majorConselee,
                              //           style: TextStyle(
                              //             backgroundColor:
                              //                 Colors.grey.withOpacity(0.4),
                              //             color: Colors.black,
                              //             fontWeight: FontWeight.w500,
                              //             fontSize: 9.sp,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //     Row(
                              //       children: [
                              //         IconButton(
                              //           onPressed: () async {
                              //             await _firestoreUtils.updateRoom(
                              //               temp[index].id,
                              //               'approve',
                              //             );
                              //           },
                              //           icon: const Icon(
                              //             Icons.check_circle,
                              //             color: Colors.greenAccent,
                              //           ),
                              //         ),
                              //         SizedBox(width: 2.w),
                              //         IconButton(
                              //           onPressed: () async {
                              //             await _firestoreUtils.updateRoom(
                              //               temp[index].id,
                              //               'ended',
                              //             );
                              //           },
                              //           icon: const Icon(
                              //             Icons.cancel_rounded,
                              //             color: Colors.redAccent,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: const Text('No pending request'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          }
        } else {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: const Text('No pending request'),
            ),
          );
        }
      },
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 6,
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(
                          isDarkMode: false,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Hi, ',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            _sharedPreference
                                    .getString('nickname')
                                    .toString()
                                    .contains('Konselor')
                                ? _sharedPreference
                                    .getString('nickname')
                                    .toString()
                                : 'Konselor',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Daftar',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Request Concelee',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                (profilePicture != '')
                    ? Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(profilePicture),
                          ),
                        ),
                      )
                    : Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/cat.png'),
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );

    // return Container(
    //   width: 1.sw,
    //   height: 52.h,
    //   color: const Color.fromRGBO(253, 143, 1, 1),
    //   child: Padding(
    //     padding: EdgeInsets.only(top: 16.h, bottom: 16.h, left: 16.w),
    //     child: Text(
    //       'Daftar Request Conselee',
    //       style: TextStyle(
    //         color: Colors.black,
    //         fontSize: 16.sp,
    //         fontWeight: FontWeight.w600,
    //       ),
    //     ),
    //   ),
    // );
  }

// Widget buildCouncelee(BuildContext context) {
//   return SizedBox(
//     width: MediaQuery.of(context).size.width,
//     height: 250,
//     child: ListView.builder(
//       itemCount: 2,
//       shrinkWrap: true,
//       itemBuilder: ((context, index) {
//         return GestureDetector(
//           onTap: () {
//             log('Logged');
//
//             // Navigator.push(
//             //   context,
//             //   MaterialPageRoute(
//             //     builder: (context) {
//             //       return const CouncelingChatScreen();
//             //     },
//             //   ),
//             // );
//             // Get.to(() => const CouncelingChatScreen());
//           },
//           child: Card(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: 80,
//               padding: const EdgeInsets.all(8),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: Image.asset('assets/images/cat.png'),
//                   ),
//                   const SizedBox(width: 4),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(left: 8.0),
//                         child: Text(
//                           '#21346',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 10,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: const [
//                           Icon(
//                             Icons.male,
//                             color: Colors.blueAccent,
//                           ),
//                           Text(
//                             'Anonymous',
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 2,
//                             softWrap: true,
//                             style: TextStyle(
//                               overflow: TextOverflow.ellipsis,
//                               color: Colors.black,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 2),
//                       const Padding(
//                         padding: EdgeInsets.only(left: 8.0),
//                         child: Text(
//                           'Saya seorang yang hiya hiya hiya',
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 2,
//                           softWrap: true,
//                           style: TextStyle(
//                             overflow: TextOverflow.ellipsis,
//                             color: Colors.grey,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 10,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             '2017',
//                             style: TextStyle(
//                               backgroundColor: Colors.grey.withOpacity(0.4),
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 11,
//                             ),
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             'Beda Jurusan',
//                             style: TextStyle(
//                               backgroundColor: Colors.grey.withOpacity(0.4),
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 11,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Icon(
//                         Icons.arrow_right_alt_rounded,
//                         color: Colors.black,
//                         size: 28,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }),
//     ),
//   );
// }

// Widget buildPendingRequestList(BuildContext context) {
//   return SizedBox(
//     width: MediaQuery.of(context).size.width,
//     height: 260.h,
//     child: Column(
//       children: [
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Pending Request',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       elevation: 1,
//                       backgroundColor: Colors.orange,
//                       content: Text(
//                         'Sorting still in development',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 icon: const Icon(
//                   CupertinoIcons.sort_down,
//                   size: 24,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         ListView.builder(
//           itemCount: 2,
//           shrinkWrap: true,
//           itemBuilder: ((context, index) {
//             return GestureDetector(
//               onTap: () {
//                 log('Logged');
//
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //     builder: (context) {
//                 //       return const CouncelingChatScreen();
//                 //     },
//                 //   ),
//                 // );
//                 // Get.to(() => const CouncelingChatScreen());
//               },
//               child: Card(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 80,
//                   padding: const EdgeInsets.all(8),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8),
//                         child: Image.asset('assets/images/cat.png'),
//                       ),
//                       const SizedBox(width: 4),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Padding(
//                             padding: EdgeInsets.only(left: 8.0),
//                             child: Text(
//                               '#21345',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 10,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             children: const [
//                               Icon(
//                                 Icons.female,
//                                 color: Colors.pinkAccent,
//                               ),
//                               Text(
//                                 'Anonymous',
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 2,
//                                 softWrap: true,
//                                 style: TextStyle(
//                                   overflow: TextOverflow.ellipsis,
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 2),
//                           const Padding(
//                             padding: EdgeInsets.only(left: 8.0),
//                             child: Text(
//                               'Saya seorang yang hiya hiya hiya',
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 2,
//                               softWrap: true,
//                               style: TextStyle(
//                                 overflow: TextOverflow.ellipsis,
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 10,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 '2017',
//                                 style: TextStyle(
//                                   backgroundColor:
//                                       Colors.grey.withOpacity(0.4),
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 11,
//                                 ),
//                               ),
//                               const SizedBox(width: 4),
//                               Text(
//                                 'Beda Jurusan',
//                                 style: TextStyle(
//                                   backgroundColor:
//                                       Colors.grey.withOpacity(0.4),
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 11,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//       ],
//     ),
//   );
// }
}
