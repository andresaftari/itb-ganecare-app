import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itb_ganecare/repositories/app_data_repository.dart';
import 'package:itb_ganecare/screen/app/counceling/councelee/councelee_sebaya_screen.dart';
import 'package:itb_ganecare/screen/app/counceling/councelor/councelor_sebaya_screen.dart';
import 'package:itb_ganecare/themes/custom_themes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final GlobalKey scaffoldKey;
  final bool isDarkMode;

  const HomePage({
    Key? key,
    required this.scaffoldKey,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeNotifier(
        isDarkMode ? darkTheme : lightTheme,
        appDataRepository: AppDataRepository(),
      ),
      child: WorldTheme(scaffoldKey: scaffoldKey),
    );
  }
}

class WorldTheme extends StatelessWidget {
  final GlobalKey localScaffoldKey;

  final bool isLoading = true;
  final bool isCouncelor = false;

  const WorldTheme({
    Key? key,
    required GlobalKey scaffoldKey,
  })  : localScaffoldKey = scaffoldKey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      theme: themeNotifier.getTheme(),
      // initialRoute: '/homePage',
      home: Scaffold(
        floatingActionButton: buildFloatingActionButton(),
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 171, 233, 1),
                  Color.fromRGBO(6, 146, 196, 1),
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'Selamat datang',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      margin: const EdgeInsets.only(top: 62, left: 24),
                    ),
                    Container(
                      child: const Text(
                        'Developer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      margin: const EdgeInsets.only(top: 4, left: 24),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(top: 58),
                        child: const Icon(
                          Icons.notifications_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 44,
                      margin: const EdgeInsets.only(right: 24, top: 58),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 0.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 8,
                            offset: const Offset(3, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          'assets/images/cat.png',
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        // body: isLoading ? buildHomeLoading() : buildHomeBody(),
        body: Stack(
          children: [
            _backgroundContainer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                primary: true,
                child: Column(
                  children: [
                    buildHomeBody(context),
                    const SizedBox(height: 16),
                    buildConselee(context),
                    const SizedBox(height: 16),
                    buildScholarshipNews(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _backgroundContainer() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(0, 171, 233, 1),
            Color.fromRGBO(6, 146, 196, 1),
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
    );
  }

  Widget buildHomeLoading() {
    return Stack(
      children: [
        _backgroundContainer(),
        Center(
          child: Image.asset(
            'assets/images/logo gerak.gif',
            width: 200,
          ),
        ),
      ],
    );
  }

  Widget buildHomeBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: const Text(
              'Apps',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            margin: const EdgeInsets.only(left: 16, top: 32),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 60,
            child: Center(
              child: ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  if (index == 0) {
                    return Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: () {
                          log('Tapped!');

                          showBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            builder: (context) => Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                height: 300,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: Text(
                                        'Counceling Sebaya',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    const Text(
                                      'Anda akan membuka aplikasi Pendamping Sebaya\n'
                                      'yang membuat Anda masuk ke mode anonim. Data pribadi\n'
                                      'Anda terkait Nama dan NIM tidak akan diketahui oleh\n'
                                      'Pendamping Sebaya maupun pengguna lain',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    const Center(
                                      child: Text('Masuk sebagai :'),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          child: const Text(
                                            'Councelee',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: const Color.fromRGBO(
                                              253,
                                              143,
                                              1,
                                              1,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return const CounceleeSebayaScreen();
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                        ElevatedButton(
                                          child: const Text(
                                            'Councelor',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: const Color.fromRGBO(
                                              253,
                                              143,
                                              1,
                                              1,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return const CouncelorSebayaScreen();
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );

                          // if (isCouncelor) {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           const CouncelorSebayaScreen(),
                          //     ),
                          //   );
                          // } else {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           const CounceleeSebayaScreen(),
                          //     ),
                          //   );
                          // }
                        },
                        child: Image.asset(
                          'assets/icons/chat.png',
                          width: 60,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(253, 143, 1, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  } else if (index == 1) {
                    return Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Image.asset('assets/images/beasiswa.png'),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(253, 143, 1, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  } else if (index == 2) {
                    return Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Image.asset('assets/images/konsultasi.png'),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(253, 143, 1, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  } else if (index == 3) {
                    return Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Image.asset('assets/images/achievement.png'),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(253, 143, 1, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  } else {
                    return Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Image.asset('assets/images/achievement.png'),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(253, 143, 1, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildConselee(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: const Text(
            'Conselee',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          margin: const EdgeInsets.only(left: 16),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 135,
          child: ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return Card(
                child: SizedBox(
                  width: 200,
                  // margin: const EdgeInsets.symmetric(horizontal: 16),
                  // padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            const Center(child: Text('{Anonymous Conselee}')),
                            const SizedBox(width: 4),
                            Image.asset(
                              'assets/images/redalert.png',
                              width: 12,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      buildTextChatConselee(context),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget buildTextChatConselee(BuildContext context) {
    return Column(
      children: [
        const Text('Owww ma gadd 🙂'),
        const SizedBox(height: 32),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 34,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(253, 143, 1, 1),
            ),
            child: const Center(
              child: Text(
                'Bantu',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildScholarshipNews(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: const Text(
            'Beasiswa Terbaru',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          margin: const EdgeInsets.only(left: 16),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              return Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/emotes/a1.png',
                        width: 32,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '{Nama Beasiswa}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 8),
                          Flexible(
                            child: Text(
                              'Lorem Ipsum Dolor sit Amet, this is\njust a dummy text',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.redAccent,
      child: const Icon(Icons.campaign_sharp),
    );
  }
}
