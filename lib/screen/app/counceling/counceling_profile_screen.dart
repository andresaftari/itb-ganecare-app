import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        toolbarHeight: 80.h,
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
                margin: EdgeInsets.only(left: 46.w, top: 68.h),
                child: Text(
                    'Profile',
                    style: TextStyle(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ),
              SizedBox(height: 16.h)
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
          decoration: const BoxDecoration(color: Color.fromRGBO(255, 195, 70, 1)),
          width: 1.sw,
          height: 110.h,
        ),
        SizedBox(height: 165.h),
        Container(
          decoration: const BoxDecoration(color: Color.fromRGBO(255, 195, 70, 1)),
          width: 1.sw,
          height: 40.h,
        ),
        Container(
          decoration: const BoxDecoration(color: Color.fromRGBO(3, 160, 217, 1)),
          width: 1.sw,
          height: 360.h,
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
            width: 125.w,
            margin: EdgeInsets.only(right: 24.w, top: 42.h),
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
        ),
        SizedBox(height: 16.h),
        Text(
          'Anonymous', 
          style: TextStyle(
            fontSize: 20.sp, 
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Text(
                '2018',
                style: TextStyle(
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Text(
                'Satu Jurusan',
                style: TextStyle(
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          'BIO Example Text...', 
          style: TextStyle(
            fontSize: 14.sp, 
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(height: 44.h),
        Text(
          'Jan 2022', 
          style: TextStyle(
            fontSize: 14.sp, 
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