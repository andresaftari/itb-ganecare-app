import 'package:flutter/material.dart';

class CouncelingProfileScreen extends StatefulWidget {
  const CouncelingProfileScreen({ Key? key }) : super(key: key);

  @override
  State<CouncelingProfileScreen> createState() => _CouncelingProfileScreenState();
}

class _CouncelingProfileScreenState extends State<CouncelingProfileScreen> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 46, top: 68),
                child: const Text(
                    'Profile',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ),
              SizedBox(height: 16)
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          buildHeader(),
          buildProfileFace(),
        ],
      ),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Widget buildHeader() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: Color.fromRGBO(255, 195, 70, 1)),
          width: MediaQuery.of(context).size.width,
          height: 110,
        ),
        const SizedBox(height: 165),
        Container(
          decoration: BoxDecoration(color: Color.fromRGBO(255, 195, 70, 1)),
          width: MediaQuery.of(context).size.width,
          height: 40,
        ),
        Container(
          decoration: BoxDecoration(color: Color.fromRGBO(3, 160, 217, 1)),
          width: MediaQuery.of(context).size.width,
          height: 360,
        ),
      ],
    );
  }

  Widget buildProfileFace() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: 125,
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
        ),
        const SizedBox(height: 16),
        const Text(
          'Anonymous', 
          style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                '2018',
                style: TextStyle(
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Satu Jurusan',
                style: TextStyle(
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'BIO Example Text...', 
          style: TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(height: 44),
        const Text(
          'Jan 2022', 
          style: TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget buildFloatingActionButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              elevation: 1,
              backgroundColor: Colors.orange,
              content: Text('This feature still in development', 
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black, 
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add_circle_rounded, 
          color: Color.fromRGBO(3, 160, 217, 1),
          size: 44,
        ),
      ),
    );
  }
}