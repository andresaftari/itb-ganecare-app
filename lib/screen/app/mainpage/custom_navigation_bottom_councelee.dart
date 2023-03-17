import 'package:flutter/material.dart';

class CustomBottomNavigationCouncelee extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;
  const CustomBottomNavigationCouncelee({
    Key? key,
    required this.onTap,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20, left: 18, right: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              onTap(0);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(
                    Icons.message,
                    color: ((selectedIndex == 0)) ? Colors.blue : Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                    'Pesan',
                    style: TextStyle(
                      fontSize: 10,
                      color: ((selectedIndex == 0)) ? Colors.blue : Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              onTap(1);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(
                    Icons.search,
                    color: ((selectedIndex == 1)) ? Colors.blue : Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Cari Concelor',
                    style: TextStyle(
                      fontSize: 10,
                      color: ((selectedIndex == 1)) ? Colors.blue : Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              onTap(2);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(
                    Icons.person,
                    color: ((selectedIndex == 2)) ? Colors.blue : Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 10,
                      color: ((selectedIndex == 2)) ? Colors.blue : Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
