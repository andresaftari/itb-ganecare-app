class GetProfileV2 {
  GetProfileV2({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  Data data;

  factory GetProfileV2.fromJson(Map<String, dynamic> json) => GetProfileV2(
        statusCode: json["statusCode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    required this.conselee,
    required this.conselor,
  });

  Consel conselee;
  Conselor conselor;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        conselee: Consel.fromJson(json["conselee"]),
        conselor: Conselor.fromJson(json["conselor"]),
      );
}

class Consel {
  Consel({
    required this.registerId,
    required this.name,
    required this.nickname,
    required this.email,
    required this.role,
    required this.deviceId,
    required this.affiliation,
    required this.about,
    required this.profilepicImage,
    required this.jurusan,
    required this.angkatan,
    required this.gender,
    required this.nim,
    required this.kuota,
  });

  String registerId;
  String name;
  String nickname;
  String email;
  int role;
  String deviceId;
  String affiliation;
  String about;
  String profilepicImage;
  String jurusan;
  int angkatan;
  String gender;
  int nim;
  int kuota;

  factory Consel.fromJson(Map<String, dynamic> json) => Consel(
        registerId: json["register_id"],
        name: json["name"],
        nickname: json["nickname"],
        email: json["email"],
        role: json["role"],
        deviceId: json["device_id"],
        affiliation: json["affiliation"],
        about: json["about"],
        profilepicImage: json["profilepic_image"],
        jurusan: json["jurusan"],
        angkatan: json["angkatan"],
        gender: json["gender"],
        nim: json["nim"],
        kuota: json["kuota"],
      );
}

class Conselor {
  Conselor({
    required this.registerId,
    required this.name,
    required this.nickname,
    required this.email,
    required this.role,
    required this.deviceId,
    required this.affiliation,
    required this.about,
    required this.profilepicImage,
    required this.jurusan,
    required this.angkatan,
    required this.gender,
    required this.nim,
    required this.kuota,
  });

  String registerId;
  String name;
  String nickname;
  String email;
  int role;
  String deviceId;
  String affiliation;
  String about;
  String profilepicImage;
  String jurusan;
  int angkatan;
  String gender;
  int nim;
  int kuota;

  factory Conselor.fromJson(Map<String, dynamic> json) => Conselor(
        registerId: json["register_id"],
        name: json["name"],
        nickname: json["nickname"],
        email: json["email"],
        role: json["role"],
        deviceId: json["device_id"],
        affiliation: json["affiliation"],
        about: json["about"],
        profilepicImage: json["profilepic_image"],
        jurusan: json["jurusan"],
        angkatan: json["angkatan"],
        gender: json["gender"],
        nim: json["nim"],
        kuota: json["kuota"],
      );
}
