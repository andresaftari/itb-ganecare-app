import 'dart:convert';

String beasiswaToJson(Beasiswa data) => json.encode(data.toJson());

class Beasiswa {
  Beasiswa({
    required this.status,
    required this.content,
  });

  int status;
  List<BeasiswaData> content;

  factory Beasiswa.fromJson(Map<String, dynamic> json) => Beasiswa(
        status: json['status'],
        content: List<BeasiswaData>.from(json['content'].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'content': List<BeasiswaData>.from(content.map((x) => x)),
      };
}

class BeasiswaData {
  BeasiswaData({
    required this.idPeriode,
    required this.namaDonatur,
    required this.idBeasiswa,
    required this.tglInput,
    required this.idDonatur,
    required this.idJenisBeasiswa,
    required this.namaBeasiswa,
    required this.awalPeriodeBeasiswa,
    required this.akhirPeriodeBeasiswa,
    required this.awalPeriodePembiayaan,
    required this.akhirPeriodePembiayaan,
    required this.kuota,
    required this.anggaran,
    required this.deskripsi,
    required this.isAktif,
    required this.isValid,
    required this.modifyDate,
    required this.cek,
    required this.idBeasiswaFasilitas,
    required this.biayaHidup,
    required this.ukt,
    required this.ta,
    required this.fasilitasLainnya,
    required this.syaratLainnya,
  });

  String idPeriode;
  String namaDonatur;
  String idBeasiswa;
  DateTime tglInput;
  String idDonatur;
  String idJenisBeasiswa;
  String namaBeasiswa;
  DateTime awalPeriodeBeasiswa;
  DateTime akhirPeriodeBeasiswa;
  DateTime awalPeriodePembiayaan;
  DateTime akhirPeriodePembiayaan;
  String kuota;
  String anggaran;
  String deskripsi;
  String isAktif;
  String isValid;
  DateTime modifyDate;
  String cek;
  String idBeasiswaFasilitas;
  String biayaHidup;
  String ukt;
  String ta;
  String fasilitasLainnya;
  String syaratLainnya;

  factory BeasiswaData.fromJson(Map<String, dynamic> json) => BeasiswaData(
        idPeriode: json['id_periode'],
        namaDonatur: json['nama_donatur'],
        idBeasiswa: json['id_beasiswa'],
        tglInput: DateTime.parse(json['tgl_input']),
        idDonatur: json['id_donatur'],
        idJenisBeasiswa: json['id_jenis_beasiswa'],
        namaBeasiswa: json['nama_beasiswa'],
        awalPeriodeBeasiswa: DateTime.parse(json['awal_periode_beasiswa']),
        akhirPeriodeBeasiswa: DateTime.parse(json['akhir_periode_beasiswa']),
        awalPeriodePembiayaan: DateTime.parse(json['awal_periode_pembiayaan']),
        akhirPeriodePembiayaan:
            DateTime.parse(json['akhir_periode_pembiayaan']),
        kuota: json['kuota'],
        anggaran: json['anggaran'],
        deskripsi: json['deskripsi'],
        isAktif: json['is_aktif'],
        isValid: json['is_valid'],
        modifyDate: DateTime.parse(json['modify_date']),
        cek: json['cek'],
        idBeasiswaFasilitas: json['id_beasiswa_fasilitas'],
        biayaHidup: json['biaya_hidup'],
        ukt: json['ukt'],
        ta: json['ta'],
        fasilitasLainnya: json['fasilitas_lainnya'],
        syaratLainnya: json['syarat_lainnya'],
      );

  Map<String, dynamic> toJson() => {
        'id_periode': idPeriode,
        'nama_donatur': namaDonatur,
        'id_beasiswa': idBeasiswa,
        'tgl_input': tglInput.toIso8601String(),
        'id_donatur': idDonatur,
        'id_jenis_beasiswa': idJenisBeasiswa,
        'nama_beasiswa': namaBeasiswa,
        'awal_periode_beasiswa':
            '${awalPeriodeBeasiswa.year.toString().padLeft(4, '0')}-${awalPeriodeBeasiswa.month.toString().padLeft(2, '0')}-${awalPeriodeBeasiswa.day.toString().padLeft(2, '0')}',
        'akhir_periode_beasiswa':
            '${akhirPeriodeBeasiswa.year.toString().padLeft(4, '0')}-${akhirPeriodeBeasiswa.month.toString().padLeft(2, '0')}-${akhirPeriodeBeasiswa.day.toString().padLeft(2, '0')}',
        'awal_periode_pembiayaan':
            '${awalPeriodePembiayaan.year.toString().padLeft(4, '0')}-${awalPeriodePembiayaan.month.toString().padLeft(2, '0')}-${awalPeriodePembiayaan.day.toString().padLeft(2, '0')}',
        'akhir_periode_pembiayaan':
            '${akhirPeriodePembiayaan.year.toString().padLeft(4, '0')}-${akhirPeriodePembiayaan.month.toString().padLeft(2, '0')}-${akhirPeriodePembiayaan.day.toString().padLeft(2, '0')}',
        'kuota': kuota,
        'anggaran': anggaran,
        'deskripsi': deskripsi,
        'is_aktif': isAktif,
        'is_valid': isValid,
        'modify_date': modifyDate.toIso8601String(),
        'cek': cek,
        'id_beasiswa_fasilitas': idBeasiswaFasilitas,
        'biaya_hidup': biayaHidup,
        'ukt': ukt,
        'ta': ta,
        'fasilitas_lainnya': fasilitasLainnya,
        'syarat_lainnya': syaratLainnya,
      };
}
