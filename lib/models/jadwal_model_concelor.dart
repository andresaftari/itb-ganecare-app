class GetJadwalConcelor {
  int statusCode;
  String message;
  DataJadwal data;

  GetJadwalConcelor({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GetJadwalConcelor.fromJson(Map<String, dynamic> json) =>
      GetJadwalConcelor(
        statusCode: json["statusCode"],
        message: json["message"],
        data: DataJadwal.fromJson(json["data"]),
      );
}

class DataJadwal {
  List<int> senin;
  List<int> selasa;
  List<int> rabu;
  List<int> kamis;
  List<int> jumat;
  List<int> sabtu;
  List<int> minggu;

  DataJadwal({
    required this.senin,
    required this.selasa,
    required this.rabu,
    required this.kamis,
    required this.jumat,
    required this.sabtu,
    required this.minggu,
  });

  factory DataJadwal.fromJson(Map<String, dynamic> json) => DataJadwal(
        senin: List<int>.from(json["Senin"].map((x) => x)),
        selasa: List<int>.from(json["Selasa"].map((x) => x)),
        rabu: List<int>.from(json["Rabu"].map((x) => x)),
        kamis: List<int>.from(json["Kamis"].map((x) => x)),
        jumat: List<int>.from(json["Jumat"].map((x) => x)),
        sabtu: List<int>.from(json["Sabtu"].map((x) => x)),
        minggu: List<int>.from(json["Minggu"].map((x) => x)),
      );
}
