class GetPrestasi {
  GetPrestasi({
    required this.status,
    required this.pesan,
    required this.data,
  });

  int status;
  String pesan;
  List<DataPrestasi> data;

  factory GetPrestasi.fromJson(Map<String, dynamic> json) => GetPrestasi(
        status: json["status"],
        pesan: json["pesan"],
        data: List<DataPrestasi>.from(json["data"].map((x) => DataPrestasi.fromJson(x))),
      );
}

class DataPrestasi {
  DataPrestasi({
    required this.idPenghargaan,
    required this.fotoKegiatan,
    required this.namaPenghargaan,
    required this.eventPenghargaan,
    required this.capaian,
    required this.tingkat,
    required this.lembaga,
    required this.tahunPerolehan,
    required this.statusIndividuKelompok,
    required this.nilai,
  });

  String idPenghargaan;
  String fotoKegiatan;
  String namaPenghargaan;
  String eventPenghargaan;
  String capaian;
  String tingkat;
  String lembaga;
  String tahunPerolehan;
  String statusIndividuKelompok;
  String nilai;

  factory DataPrestasi.fromJson(Map<String, dynamic> json) => DataPrestasi(
        idPenghargaan: json["id_penghargaan"],
        fotoKegiatan: json["foto_kegiatan"],
        namaPenghargaan: json["nama_penghargaan"],
        eventPenghargaan: json["EventPenghargaan"],
        capaian: json["capaian"],
        tingkat: json["tingkat"],
        lembaga: json["lembaga"],
        tahunPerolehan: json["tahun_perolehan"],
        statusIndividuKelompok: json["status_individu_kelompok"],
        nilai: json["nilai"],
      );
}
