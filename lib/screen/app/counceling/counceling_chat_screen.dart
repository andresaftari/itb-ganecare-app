import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:itb_ganecare/models/dummy_chat.dart';

class CouncelingChatScreen extends StatefulWidget {
  const CouncelingChatScreen({Key? key}) : super(key: key);

  @override
  State<CouncelingChatScreen> createState() => _CouncelingChatScreenState();
}

class _CouncelingChatScreenState extends State<CouncelingChatScreen> {
  List<ChatMessage> messages = [
    ChatMessage(
      messageContent: "Halo salam kenal",
      messageType: "receiver",
    ),
    ChatMessage(
      messageContent: "Halo salam kenal juga",
      messageType: "sender",
    ),
    ChatMessage(
      messageContent: "You ok?",
      messageType: "sender",
    ),
    ChatMessage(
      messageContent: "ehhhh, doing OK.",
      messageType: "receiver",
    ),
    ChatMessage(
      messageContent: "Beneran?",
      messageType: "sender",
    ),
  ];

  List<ChatUsers> chatList = [
    ChatUsers(
      name: 'Jane Russel',
      messageText: 'Awesome Setup',
      time: 'Now',
    ),
    ChatUsers(
      name: 'Gladys Murphy',
      messageText: 'That\'s Great',
      time: 'Yesterday',
    ),
    ChatUsers(
      name: 'Jorge Henry',
      messageText: 'Hey where are you?',
      time: '31 Mar',
    ),
    ChatUsers(
      name: 'Philip Fox',
      messageText: 'Busy! Call me in 20 mins',
      time: '28 Mar',
    ),
    ChatUsers(
      name: 'Debra Hawkins',
      messageText: 'Thankyou, It\'s awesome',
      time: '23 Mar',
    ),
    ChatUsers(
      name: 'Jacob Pena',
      messageText: 'will update you in evening',
      time: '17 Mar',
    ),
    ChatUsers(
      name: 'Andrey Jones',
      messageText: 'Can you please share the file?',
      time: '24 Feb',
    ),
    ChatUsers(
      name: 'John Wick',
      messageText: 'How are you?',
      time: '18 Feb',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                        '#21345',
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
    var today = DateFormat('d MMMM yyyy', 'ID').format(DateTime.now());
    log(1.sh.toString());

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16.h),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                today,
                style: TextStyle(fontSize: 12.sp),
              ),
              ListView.builder(
                itemCount: messages.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 8.w, bottom: 8.h),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 8.h,
                      bottom: 8.h,
                    ),
                    child: Align(
                      alignment: (messages[index].messageType == "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messages[index].messageType == "receiver"
                              ? Colors.grey.shade200
                              : Colors.blue[200]),
                        ),
                        padding: EdgeInsets.all(16.w),
                        child: Text(
                          messages[index].messageContent,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),

          if (1.sh > 100 && 1.sh < 800)
            SizedBox(height: 1.sh - 0.81.sh)
          else if (1.sh >= 800)
            SizedBox(height: 1.sh - 0.75.sh),

          Container(
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
                  onPressed: () {},
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
