import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itb_ganecare/data/sharedprefs.dart';
import 'package:itb_ganecare/data_provider/chat_room_utils.dart';
import 'package:itb_ganecare/models/chats.dart';

class CouncelingChatScreen extends StatefulWidget {
  final int conseleeId;
  final int conselorId;

  const CouncelingChatScreen({
    Key? key,
    required this.conseleeId,
    required this.conselorId,
  }) : super(key: key);

  @override
  State<CouncelingChatScreen> createState() => _CouncelingChatScreenState();
}

class _CouncelingChatScreenState extends State<CouncelingChatScreen> {
  final SharedPrefUtils _sharedPreference = SharedPrefUtils();
  final FirestoreUtils _firestoreUtils = FirestoreUtils();

  RxBool isSent = false.obs;
  RxBool isReceived = false.obs;

  @override
  Widget build(BuildContext context) {
    String roomId = _sharedPreference.getString('roomId').toString();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70.h,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
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
          child: Container(
            margin: EdgeInsets.only(left: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        '#$roomId',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      margin: EdgeInsets.only(top: 35.h, left: 24.w),
                    ),
                    Container(
                      child: Text(
                        'Anonymous',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      margin: EdgeInsets.only(left: 24.w),
                    ),
                  ],
                ),
                Container(
                  width: 44.w,
                  margin: EdgeInsets.only(right: 24.w, top: 28.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 8.r,
                        offset: const Offset(3, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Image.asset('assets/images/cat.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(
        () =>
            isSent.value || isReceived.value ? refreshChatUI() : buildChatUI(),
      ),
    );
  }

  Widget refreshChatUI() {
    isSent.value = false;
    isReceived.value = false;

    return buildChatUI();
  }

  Widget buildChatUI() {
    String roomId = _sharedPreference.getString('roomId').toString();
    log(
        Timestamp(
          Timestamp.now().seconds,
          Timestamp.now().nanoseconds,
        ).toDate().toLocal().toString(),
        name: 'get-timestamp');

    return FutureBuilder<dynamic>(
      future: _firestoreUtils.getLiveChat(roomId),
      builder: (context, snapshot) {
        RxList<Chats> dataset = <Chats>[].obs;

        if (_firestoreUtils.chats.isNotEmpty) {
          dataset = _firestoreUtils.chats;
          log('data ${_firestoreUtils.chats}', name: 'log-chat');
        } else {
          log('no data', name: 'log-chat');
        }

        return Obx(
          () => _firestoreUtils.chats.isNotEmpty
              ? SingleChildScrollView(
                  padding: EdgeInsets.only(top: 16.h),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: _firestoreUtils.chats.length,
                        shrinkWrap: true,
                        reverse: true,
                        padding: EdgeInsets.only(top: 8.w, bottom: 8.h),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          DateTime timestamp = Timestamp(
                            _firestoreUtils.chats[index].dateTime.seconds,
                            _firestoreUtils.chats[index].dateTime.nanoseconds,
                          ).toDate();

                          String today = DateFormat(
                            'd MMMM yyyy',
                            'ID',
                          ).format(timestamp);

                          return Column(
                            children: [
                              Text(
                                today,
                                style: TextStyle(fontSize: 12.sp),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 16.w,
                                  right: 16.w,
                                  top: 8.h,
                                  bottom: 8.h,
                                ),
                                child: Align(
                                  alignment: (dataset[index].idReceiver ==
                                          widget.conseleeId
                                      ? Alignment.topLeft
                                      : Alignment.topRight),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: (dataset[index].idReceiver ==
                                              widget.conseleeId
                                          ? Colors.grey.shade200
                                          : Colors.blue[200]),
                                    ),
                                    padding: EdgeInsets.all(16.w),
                                    child: Text(
                                      dataset[index].message,
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      if (1.sh > 100 && 1.sh < 800)
                        SizedBox(height: 1.sh - 0.6.sh)
                      else if (1.sh >= 800)
                        SizedBox(height: 1.sh - 0.6.sh),
                      Container(
                        alignment: Alignment.bottomCenter,
                        padding:
                            EdgeInsets.only(left: 8.w, bottom: 8.w, top: 8.h),
                        height: 50.h,
                        color: Colors.white,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 30.w,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 22.w,
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            const Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Write message...",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            FloatingActionButton(
                              onPressed: () async {
                                Get.snackbar('Test Send', 'Coba');

                                _firestoreUtils.postLiveChat(
                                  roomId,
                                  DateTime.now(),
                                  widget.conselorId,
                                  widget.conseleeId,
                                  'test lg',
                                  'text',
                                );

                                isSent.value = true;
                              },
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 16.w,
                              ),
                              backgroundColor: Colors.blue,
                              elevation: 0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: const Text('No chat history'),
                  ),
                ),
        );
      },
    );
  }
}

class ConversationList extends StatefulWidget {
  final String name;
  final String messageText;
  final String time;
  final bool isMessageRead;

  const ConversationList({
    Key? key,
    required this.name,
    required this.messageText,
    required this.time,
    required this.isMessageRead,
  }) : super(key: key);

  @override
  State<ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 8.h,
          bottom: 8.h,
        ),
      ),
    );
  }
}
