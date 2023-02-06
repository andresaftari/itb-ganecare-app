import 'dart:convert';

String postCounseleeToJson(PostCounselee data) => json.encode(data.toJson());

class PostCounselee {
  PostCounselee({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Counselee> data;

  factory PostCounselee.fromJson(Map<String, dynamic> json) => PostCounselee(
        status: json['status'],
        message: json['message'],
        data: List<Counselee>.from(
            json['data'].map((x) => Counselee.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Counselee {
  Counselee({
    required this.counseleeId,
    required this.counseleeName,
    required this.nim,
    required this.kuota,
    required this.jurusan,
    required this.gender,
    required this.angkatan,
  });

  int counseleeId;
  String counseleeName;
  int nim;
  int kuota;
  String jurusan;
  String gender;
  int angkatan;

  factory Counselee.fromJson(Map<String, dynamic> json) => Counselee(
        counseleeId: json['counselee_id'],
        counseleeName: json['counselee_name'],
        nim: json['nim'],
        kuota: json['kuota'],
        jurusan: json['jurusan'],
        gender: json['gender'],
        angkatan: json['angkatan'],
      );

  Map<String, dynamic> toJson() => {
        'counselee_id': counseleeId,
        'counselee_name': counseleeName,
        'nim': nim,
        'kuota': kuota,
        'jurusan': jurusan,
        'gender': gender,
        'angkatan': angkatan,
      };

  @override
  String toString() =>
      'Counselee(id: $counseleeId, name: $counseleeName, jurusan: $jurusan)';
}

PostCounselor postCounselorFromJson(String str) =>
    PostCounselor.fromJson(json.decode(str));
String postCounselorToJson(PostCounselor data) => json.encode(data.toJson());

class PostCounselor {
  PostCounselor({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Counselor> data;

  factory PostCounselor.fromJson(Map<String, dynamic> json) => PostCounselor(
        status: json['status'],
        message: json['message'],
        data: List<Counselor>.from(
          json['data'].map(
            (x) => Counselor.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Counselor {
  Counselor({
    required this.counselorId,
    required this.counselorName,
    required this.nim,
    required this.kuota,
    required this.jurusan,
    required this.gender,
    required this.angkatan,
  });

  int counselorId;
  String counselorName;
  int nim;
  int kuota;
  String jurusan;
  String gender;
  int angkatan;

  factory Counselor.fromJson(Map<String, dynamic> json) => Counselor(
        counselorId: json['counselor_id'],
        counselorName: json['counselor_name'],
        nim: json['nim'],
        kuota: json['kuota'],
        jurusan: json['jurusan'],
        gender: json['gender'],
        angkatan: json['angkatan'],
      );

  Map<String, dynamic> toJson() => {
        'counselor_id': counselorId,
        'counselor_name': counselorName,
        'nim': nim,
        'kuota': kuota,
        'jurusan': jurusan,
        'gender': gender,
        'angkatan': angkatan,
      };
}
