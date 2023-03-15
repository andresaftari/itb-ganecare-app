import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailPrestasi extends StatefulWidget {
  const DetailPrestasi({Key? key}) : super(key: key);

  @override
  State<DetailPrestasi> createState() => _DetailPrestasiState();
}

class _DetailPrestasiState extends State<DetailPrestasi> {
  Widget contentOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        const Text(
          'Nama prestasi',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          height: 250.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    );
  }

  Widget contentTwo() {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(
              width: 150,
              height: 20,
              child: Text('Lingkup/Tingkat'),
            ),
            Expanded(
              child: SizedBox(
                height: 20,
                child: Text(': Internasional'),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: const [
            SizedBox(
              width: 150,
              height: 20,
              child: Text('Tanggal'),
            ),
            Expanded(
              child: SizedBox(
                height: 20,
                child: Text(': 2020-12-11 sd 2021-10-12'),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: const [
            SizedBox(
              width: 150,
              height: 20,
              child: Text('Penyelenggara'),
            ),
            Expanded(
              child: SizedBox(
                height: 20,
                child: Text(': Ristek Dikti'),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }

  Widget contenThree() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3.5,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: const [
            Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Detail Prestasi')),
        actions: const [
          SizedBox(
            width: 35,
            height: 20,
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              contentOne(),
              contentTwo(),
              contenThree(),
            ],
          ),
        ),
      ),
    );
  }
}
