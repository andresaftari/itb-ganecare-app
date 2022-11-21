import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CounceleeListViewScreen extends StatefulWidget {
  const CounceleeListViewScreen({Key? key}) : super(key: key);

  @override
  State<CounceleeListViewScreen> createState() =>
      _CounceleeListViewScreenState();
}

class _CounceleeListViewScreenState extends State<CounceleeListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      child: Column(
        children: [
          buildHeader(context),
          buildCouncelee(context),
          const SizedBox(height: 16),
          buildPendingRequestList(context),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 52,
      color: const Color.fromRGBO(253, 143, 1, 1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Pilih Pendamping Sebaya',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(CupertinoIcons.sort_down, size: 24),
          ],
        ),
      ),
    );
  }

  Widget buildCouncelee(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 260,
      child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset('assets/images/cat.png'),
                  ),
                  const SizedBox(width: 4),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          '#21345',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: const [
                          Icon(
                            Icons.male,
                            color: Colors.blueAccent,
                          ),
                          Text(
                            'Anonymous',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Saya seorang yang hiya hiya hiya',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            '2017',
                            style: TextStyle(
                              backgroundColor: Colors.grey.withOpacity(0.4),
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Beda Jurusan',
                            style: TextStyle(
                              backgroundColor: Colors.grey.withOpacity(0.4),
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_right_alt_rounded,
                        color: Colors.black,
                        size: 28,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildPendingRequestList(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 260,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Pending Request',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Icon(CupertinoIcons.sort_down, size: 24),
              ],
            ),
          ),
          ListView.builder(
            itemCount: 2,
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              return Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset('assets/images/cat.png'),
                      ),
                      const SizedBox(width: 4),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              '#21345',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: const [
                              Icon(
                                Icons.female,
                                color: Colors.pinkAccent,
                              ),
                              Text(
                                'Anonymous',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: true,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Saya seorang yang hiya hiya hiya',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                '2017',
                                style: TextStyle(
                                  backgroundColor: Colors.grey.withOpacity(0.4),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Beda Jurusan',
                                style: TextStyle(
                                  backgroundColor: Colors.grey.withOpacity(0.4),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
