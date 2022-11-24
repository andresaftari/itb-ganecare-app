import 'package:flutter/material.dart';

class CouncelingChatScreen extends StatefulWidget {
  const CouncelingChatScreen({ Key? key }) : super(key: key);

  @override
  State<CouncelingChatScreen> createState() => _CouncelingChatScreenState();
}

class _CouncelingChatScreenState extends State<CouncelingChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.close, color: Colors.white),
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
            margin: const EdgeInsets.only(left: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        '#21345',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      margin: const EdgeInsets.only(top: 62, left: 24),
                    ),
                    Container(
                      child: const Text(
                        'Anonymous',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 24),
                    ),
                  ],
                ),
                Container(
                  width: 44,
                  margin: const EdgeInsets.only(right: 24, top: 42),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 8,
                        offset: const Offset(3, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset('assets/images/cat.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: const Center(
        child: Text('UI for Chat still in development',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
    );
  }

//   List<ChatMessage> basicSample = <ChatMessage>[
//   ChatMessage(
//     text: 'google.com hello you @Marc is it &you okay?',
//     user: user2,
//     createdAt: DateTime(2021, 01, 31, 16, 45),
//   ),
//   ChatMessage(
//     text: 'google.com',
//     user: user2,
//     createdAt: DateTime(2021, 01, 30, 16, 45),
//   ),
//   ChatMessage(
//     text: "Oh what's up guys?",
//     user: user2,
//     createdAt: DateTime(2021, 01, 30, 16, 45),
//   ),
//   ChatMessage(
//     text: 'How you doin?',
//     user: currentUser,
//     createdAt: DateTime(2021, 01, 30, 16, 34),
//   ),
//   ChatMessage(
//     text: 'Hey!',
//     user: currentUser,
//     createdAt: DateTime(2021, 01, 30, 15, 50),
//   ),
//   ChatMessage(
//     text: 'Hey!',
//     user: currentUser,
//     createdAt: DateTime(2021, 01, 28, 15, 50),
//   ),
//   ChatMessage(
//     text: 'Hey!',
//     user: currentUser,
//     createdAt: DateTime(2021, 01, 28, 15, 50),
//   ),
// ];
}

// ChatUser user2 = ChatUser(id: '2', firstName: 'Niki Lauda');
// ChatUser currentUser = ChatUser(id: '0');