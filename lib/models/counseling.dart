import 'dart:convert';

PostCounselee postCounseleeFromJson(String str) => PostCounselee.fromJson(json.decode(str));
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
        data: List<Counselee>.from(json['data'].map((x) => Counselee.fromJson(x))),
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
}
