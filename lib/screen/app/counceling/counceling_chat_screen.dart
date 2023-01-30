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

  final _chatKey = GlobalKey<FormState>(debugLabel: 'chat');
  final TextEditingController _messageController = TextEditingController();

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
      body: buildChatUI(),
    );
  }

  Widget buildChatUI() {
    String roomId = _sharedPreference.getString('roomId').toString();
    Set<String> setDate = <String>{};

    log(1.sh.toString());

    log(
        Timestamp(
          Timestamp.now().seconds,
          Timestamp.now().nanoseconds,
        ).toDate().toLocal().toString(),
        name: 'get-timestamp');

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16.h),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          StreamBuilder<List<Chats>>(
            stream: _firestoreUtils.getLiveChat(roomId),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator.adaptive();
                } else if (snapshot.connectionState == ConnectionState.active) {
                  var textMessages = snapshot.data;

                  return ListView.builder(
                    itemCount: textMessages.length,
                    shrinkWrap: true,
                    reverse: true,
                    padding: EdgeInsets.only(top: 8.w, bottom: 8.h),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      DateTime timestamp = Timestamp(
                        textMessages[index].dateTime.seconds,
                        textMessages[index].dateTime.nanoseconds,
                      ).toDate();

                      String date = DateFormat(
                        'd MMMM yyyy',
                        'ID',
                      ).format(timestamp);


                      setDate.add(date);

                      // int count1 = 0;
                      // int count2 = 0;
                      // int count3 = 0;
                      // int count4 = 0;
                      // var tempMessages = [];

                      // for (var i = 0; i < textMessages.length; i++) {
                      //   if (setDate.elementAt(0) == date) {
                      //     count1++;
                      //   }
                      //   if (setDate.elementAt(1) == date) {
                      //     count2++;
                      //   }
                      //   if (setDate.elementAt(2) == date) {
                      //     count3++;
                      //   }
                      //   if (setDate.elementAt(3) == date) {
                      //     count4++;
                      //   }
                      // }

                      // log('$count1 $count2 $count3 $count4', name: 'counter');

                      return Column(
                        children: [
                          if (setDate.isNotEmpty)
                            for (int i = 0; i < setDate.length; i++)
                              if (date == setDate.elementAt(i))
                                Text(
                                  setDate.elementAt(i),
                                  style: TextStyle(fontSize: 12.sp),
                                )
                              else
                                Container(),
                          Container(
                            padding: EdgeInsets.only(
                              left: 16.w,
                              right: 16.w,
                              top: 8.h,
                              bottom: 8.h,
                            ),
                            child: Align(
                              alignment: (textMessages[index].idReceiver ==
                                      widget.conseleeId
                                  ? Alignment.topLeft
                                  : Alignment.topRight),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (textMessages[index].idReceiver ==
                                          widget.conseleeId
                                      ? Colors.grey.shade200
                                      : Colors.blue[200]),
                                ),
                                padding: EdgeInsets.all(16.w),
                                child: Text(
                                  textMessages[index].message,
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: const Text('No chat history'),
                    ),
                  );
                }
              } else {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: const Text('No chat history'),
                  ),
                );
              }
            },
          ),
          if (1.sh > 100 && 1.sh < 800)
            SizedBox(height: 1.sh - 0.6.sh)
          else if (1.sh >= 800)
            SizedBox(height: 1.sh - 0.8.sh),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(left: 8.w, bottom: 8.w, top: 8.h),
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
                Expanded(
                  child: Form(
                    key: _chatKey,
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                FloatingActionButton(
                  onPressed: () async {
                    if (_messageController.value.text != '') {
                      await _firestoreUtils.postLiveChat(
                        roomId,
                        DateTime.now(),
                        widget.conselorId,
                        widget.conseleeId,
                        _messageController.value.text,
                        'text',
                      );

                      Get.snackbar('Message', 'Pesan terkirim');
                    } else {
                      Get.snackbar('Message', 'Anda belum menuliskan pesan');
                    }
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
