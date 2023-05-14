import 'package:flutter/material.dart';
import 'package:itb_ganecare/screen/app/beasiswa/beasiswa_tersedia_screen.dart';
import 'package:itb_ganecare/screen/app/beasiswa/beasiswaku_screen.dart';
import 'package:itb_ganecare/screen/app/mainpage/custom_navigation_appbar.dart';

class MainPageBeasiswa extends StatefulWidget {
  final int initialPage;
  const MainPageBeasiswa({
    Key? key,
    required this.initialPage,
  }) : super(key: key);

  @override
  State<MainPageBeasiswa> createState() => _MainPageBeasiswaState();
}

class _MainPageBeasiswaState extends State<MainPageBeasiswa> {
  int _selectedPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedPage = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedPage = index;
                });
              },
              children: const [
                Center(
                  child: BeasiswaTersediaScreen(),
                ),
                Center(
                  child: BeasiswakuScreen(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                CustomAppbarNavigation(
                  selectedIndex: _selectedPage,
                  onTap: (index) {
                    setState(() {
                      _selectedPage = index;
                    });
                    _pageController.jumpToPage(_selectedPage);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
