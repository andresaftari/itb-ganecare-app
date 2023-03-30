class DataBeasiswaKu {
  DataBeasiswaKu({
    required this.statusCode,
    required this.data,
  });

  int statusCode;
  List<Datum> data;

  factory DataBeasiswaKu.fromJson(Map<String, dynamic> json) => DataBeasiswaKu(
        statusCode: json["statusCode"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  Datum({
    required this.namaDonatur,
    required this.namaBeasiswa,
    required this.anggaran,
    required this.kuota,
    required this.idPermohonan,
    required this.useridPemohon,
    required this.noReg,
    required this.nim,
    required this.idBeasiswa,
    required this.tglInput,
    required this.awalPeriodePembiayaan,
    required this.akhirPeriodePembiayaan,
    required this.prioritasKe,
    required this.status,
    required this.idPeriode,
    required this.modifyDate,
    required this.cek,
    required this.statusName,
  });

  String namaDonatur;
  String namaBeasiswa;
  String anggaran;
  String kuota;
  String idPermohonan;
  String useridPemohon;
  String noReg;
  String nim;
  String idBeasiswa;
  String tglInput;
  String awalPeriodePembiayaan;
  String akhirPeriodePembiayaan;
  String prioritasKe;
  String status;
  String idPeriode;
  String modifyDate;
  String cek;
  String statusName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        namaDonatur: json["nama_donatur"],
        namaBeasiswa: json["nama_beasiswa"],
        anggaran: json["anggaran"],
        kuota: json["kuota"],
        idPermohonan: json["id_permohonan"],
        useridPemohon: json["userid_pemohon"],
        noReg: json["no_reg"],
        nim: json["nim"],
        idBeasiswa: json["id_beasiswa"],
        tglInput: json["tgl_input"],
        awalPeriodePembiayaan:
            json["awal_periode_pembiayaan"] == null ? '' : '',
        akhirPeriodePembiayaan:
            json["akhir_periode_pembiayaan"] == null ? '' : '',
        prioritasKe: json["prioritas_ke"],
        status: json["status"],
        idPeriode: json["id_periode"],
        modifyDate: json["modify_date"],
        cek: json["cek"],
        statusName: json["status_name"],
      );
}
