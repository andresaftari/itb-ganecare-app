import 'package:flutter/material.dart';
import 'package:itb_ganecare/screen/app/counceling/councelee/councelee_sebaya_screen.dart';
import 'package:itb_ganecare/screen/app/counceling/councelor/councelor_listview_screen.dart';
import 'package:itb_ganecare/screen/app/counceling/councelor/councelor_sebaya_screen.dart';
import 'package:itb_ganecare/screen/app/counceling/councelor_profile_screen.dart';
import 'package:itb_ganecare/screen/app/mainpage/custom_navigation_bottom_councelee.dart';
import 'package:itb_ganecare/screen/app/mainpage/custom_navigation_bottom_councelor.dart';

import '../counceling/councelee/councelee_listview_screen.dart';
import '../counceling/counceling_profile_screen.dart';

class MainPageCouncelor extends StatefulWidget {
  final int initialPage;
  const MainPageCouncelor({
    Key? key,
    required this.initialPage,
  }) : super(key: key);

  @override
  State<MainPageCouncelor> createState() => _MainPageCouncelorState();
}

class _MainPageCouncelorState extends State<MainPageCouncelor> {
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
                  child: CouncelorSebayaScreen(),
                ),
                Center(
                  child: CouncelorListViewScreen(),
                ),
                Center(
                  child: CouncelorProfileScreen(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigationCouncelor(
              selectedIndex: _selectedPage,
              onTap: (index) {
                setState(() {
                  _selectedPage = index;
                });
                _pageController.jumpToPage(_selectedPage);
              },
            ),
          ),
        ],
      ),
    );
  }
}
