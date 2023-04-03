import 'package:flutter/material.dart';

class CustomAppbarNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;
  const CustomAppbarNavigation({
    Key? key,
    required this.onTap,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height / 8,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 55,
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    height: 55,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(
                      height: 55,
                      child: Center(
                        child: Text(
                          'Beasiswa',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                    height: 55,
                  ),
                ],
              ),
            ),
            Row(
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
                          Icons.bookmark,
                          color: ((selectedIndex == 0))
                              ? Colors.white
                              : Colors.grey.shade400,
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          'Daftar Beasiswa',
                          style: TextStyle(
                            fontSize: 10,
                            color: ((selectedIndex == 0))
                                ? Colors.white
                                : Colors.grey.shade400,
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
                          Icons.bookmark_add,
                          color: ((selectedIndex == 1))
                              ? Colors.white
                              : Colors.grey.shade400,
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          'Beasiswaku',
                          style: TextStyle(
                            fontSize: 10,
                            color: ((selectedIndex == 1))
                                ? Colors.white
                                : Colors.grey.shade400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
