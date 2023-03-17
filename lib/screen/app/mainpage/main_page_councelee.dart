import 'package:flutter/material.dart';
import 'package:itb_ganecare/screen/app/counceling/councelee/councelee_sebaya_screen.dart';
import 'package:itb_ganecare/screen/app/mainpage/custom_navigation_bottom_councelee.dart';

import '../counceling/councelee/councelee_listview_screen.dart';
import '../counceling/counceling_profile_screen.dart';

class MainPageCouncelee extends StatefulWidget {
  final int initialPage;
  const MainPageCouncelee({
    Key? key,
    required this.initialPage,
  }) : super(key: key);

  @override
  State<MainPageCouncelee> createState() => _MainPageCounceleeState();
}

class _MainPageCounceleeState extends State<MainPageCouncelee> {
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
                  child: CounceleeSebayaViews(),
                ),
                Center(
                  child: CounceleeListViewScreen(),
                ),
                Center(
                  child: CouncelingProfileScreen(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigationCouncelee(
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
