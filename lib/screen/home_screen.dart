import 'package:flutter/material.dart';
import 'package:itb_ganecare/repositories/app_data_repository.dart';
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
        body: buildHomeBody(context),
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
    return Stack(
      children: [
        _backgroundContainer(),
        SingleChildScrollView(
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
                margin: const EdgeInsets.only(left: 32, top: 32),
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
                          child: Image.asset('assets/icons/chat.png'),
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
                          child: Image.asset('assets/emotes/a1.png'),
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
                          child: Image.asset('assets/emotes/a2.png'),
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
                          child: Image.asset('assets/emotes/a3.png'),
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
                          child: Image.asset('assets/emotes/a4.png'),
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
        ),
      ],
    );
  }
  
  Widget buildFloatingActionButton() {
    return FloatingActionButton(onPressed: () {},
    child: const Icon(Icons.campaign_sharp),);
  }
}
