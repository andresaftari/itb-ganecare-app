class GetJadwal {
  GetJadwal({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  List<DatumJadwal> data;

  factory GetJadwal.fromJson(Map<String, dynamic> json) => GetJadwal(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<DatumJadwal>.from(
            json["data"].map((x) => DatumJadwal.fromJson(x))),
      );
}

class DatumJadwal {
  DatumJadwal({
    required this.namaKonselor,
    required this.spesialis,
    required this.profilePic,
    required this.tanggal,
    required this.jamMulai,
    required this.jamAkhir,
    required this.isBooked,
  });

  String namaKonselor;
  String spesialis;
  String profilePic;
  DateTime tanggal;
  String jamMulai;
  String jamAkhir;
  String isBooked;

  factory DatumJadwal.fromJson(Map<String, dynamic> json) => DatumJadwal(
        namaKonselor: json["nama_konselor"],
        spesialis: json["spesialis"],
        profilePic: json["profile_pic"] ?? '',
        tanggal: DateTime.parse(json["tanggal"]),
        jamMulai: json["jam_mulai"],
        jamAkhir: json["jam_akhir"],
        isBooked: json["is_booked"],
      );
}
