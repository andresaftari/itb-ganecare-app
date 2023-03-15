
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:itb_ganecare/data/controllers/chat_controller.dart';
import 'package:itb_ganecare/data/sharedprefs.dart';
import 'package:itb_ganecare/data_provider/chat_room_utils.dart';
import 'package:itb_ganecare/models/chats.dart';
import 'package:itb_ganecare/screen/app/counceling/councelee/councelee_sebaya_screen.dart';

class CouncelingChatScreen extends StatefulWidget {
  final int conseleeId;
  final int conselorId;
  final String currentId;

  const CouncelingChatScreen({
    Key? key,
    required this.conseleeId,
    required this.conselorId,
    required this.currentId,
  }) : super(key: key);

  @override
  State<CouncelingChatScreen> createState() => _CouncelingChatScreenState();
}

class _CouncelingChatScreenState extends State<CouncelingChatScreen> {
  final SharedPrefUtils _sharedPreference = SharedPrefUtils();
  final FirestoreUtils _firestoreUtils = FirestoreUtils();

  final ChatController _chatController = Get.find();

  final _chatKey = GlobalKey<FormState>(debugLabel: 'chat');
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String roomId = _sharedPreference.getString('roomId').toString();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.h,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            // _firestoreUtils.getLiveChatRoom().listen((event) {
            //   for (final room in event) {
            //     if (room.idConselee == widget.conseleeId) {
            //       Future(
            //         () => _firestoreUtils.updateInRoom(
            //           roomId: roomId,
            //           isCounseleeInRoom: false,
            //         ),
            //       );
            //     } else if (room.idConselor == widget.conselorId) {
            //       Future(
            //         () => _firestoreUtils.updateInRoom(
            //           roomId: roomId,
            //           isCounselorInRoom: false,
            //         ),
            //       );
            //     }
            //   }
            // });

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
                  margin: EdgeInsets.only(top: 32.h, right: 16.w),
                  child: GestureDetector(
                    onTap: () async {
                      Get.snackbar('GaneCare', 'Mengakhiri Room');
                      await _firestoreUtils.updateRoom(roomId, 'ended');
                      await _endCurrentChat();

                      Get.off(() => const CounceleeSebayaScreen());
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Icon(
                        Icons.cancel_rounded,
                        size: 32.r,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: buildChat(),
    );
  }

  Widget buildChat() {
    String roomId = _sharedPreference.getString('roomId').toString();

    return Stack(
      children: [
        StreamBuilder<List<Chats>>(
          stream: _firestoreUtils.getLiveChat(roomId),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator.adaptive();
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data != null && snapshot.data.length > 0) {
                  List<Chats> chats = snapshot.data.toList();

                  // log(chats[0].message, name: 'chat-dataset');

                  return GroupedListView<Chats, String>(
                    elements: chats,
                    floatingHeader: true,
                    // reverse:,

                    groupBy: (check) {
                      DateTime timestamp = Timestamp(
                        check.dateTime.seconds,
                        check.dateTime.nanoseconds,
                      ).toDate();

                      return timestamp.toString().substring(0, 11);
                    },
                    groupSeparatorBuilder: (value) {
                      String group = '';

                      DateTime timestamp = Timestamp(
                        Timestamp.now().seconds,
                        Timestamp.now().nanoseconds,
                      ).toDate();

                      String today = DateFormat(
                        'd MMMM yyyy',
                      ).format(timestamp);

                      String yesterday = DateFormat(
                        'd MMMM yyyy',
                      ).format(
                        timestamp.subtract(
                          const Duration(days: 1),
                        ),
                      );

                      if (value == today) {
                        group = 'Today';
                      } else if (value == yesterday) {
                        group = 'Yesterday';
                      } else {
                        group = value;
                      }

                      return Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 200.w,
                          height: 30.h,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Text(
                            group,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                    indexedItemBuilder: (context, element, index) {
                      Chats chat = Chats(
                        dateTime: chats[index].dateTime,
                        idReceiver: chats[index].idReceiver,
                        idRoom: chats[index].idRoom,
                        idSender: chats[index].idSender,
                        isRead: chats[index].isRead,
                        message: chats[index].message,
                        type: chats[index].type,
                      );

                      return Container(
                        margin: EdgeInsets.only(
                          bottom: index == chats.length - 1 ? 100.h : 0.h,
                        ),
                        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 4.h),
                        child: buildChatWidget(chat),
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
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
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
                        int.parse(widget.currentId) == widget.conselorId
                            ? widget.conselorId
                            : widget.conseleeId,
                        int.parse(widget.currentId),
                        _messageController.value.text,
                        'text',
                      );

                      Get.snackbar('Message', 'Pesan terkirim');
                      _messageController.text = '';
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
        ),
      ],
    );
  }

  Widget buildChatWidget(Chats chat) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 8.h,
            bottom: 2.h,
          ),
          child: Align(
            alignment: (chat.idSender.toString() == widget.currentId
                ? Alignment.topRight
                : Alignment.topLeft),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: (chat.idSender.toString() == widget.currentId
                    ? Colors.blue[200]
                    : Colors.grey.shade200),
              ),
              padding: EdgeInsets.all(16.w),
              child: Text(
                chat.message,
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future _endCurrentChat() async {
    String roomId = _sharedPreference.getString('roomId').toString();

    _firestoreUtils.getLiveChat(roomId).listen((event) { 
      for (var element in event) {
        DateTime today = Timestamp(
          element.dateTime.seconds,
          element.dateTime.nanoseconds,
        ).toDate();

        _chatController.postEndChat(
          element.idRoom, 
          widget.conselorId, 
          widget.conseleeId, 
          today, 
          roomId, 
          event
        );
      }
    });
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
