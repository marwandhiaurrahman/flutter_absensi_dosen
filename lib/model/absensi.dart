import 'package:flutter/material.dart';

class Absensi {
  Absensi({
    @required this.absensi,
    @required this.absensiAktif,
  });

  List<AbsensiElement> absensi;
  List<AbsensiElement> absensiAktif;

  factory Absensi.fromJson(Map<String, dynamic> json) => Absensi(
        absensi: List<AbsensiElement>.from(
            json["absensi"].map((x) => AbsensiElement.fromJson(x))),
        absensiAktif: List<AbsensiElement>.from(
            json["absensi_aktif"].map((x) => AbsensiElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "absensi": List<dynamic>.from(absensi.map((x) => x.toJson())),
        "absensi_aktif":
            List<dynamic>.from(absensiAktif.map((x) => x.toJson())),
      };
}

class AbsensiElement {
  AbsensiElement({
    @required this.id,
    @required this.pertemuan,
    @required this.tanggal,
    @required this.metode,
    @required this.ruangan,
    @required this.pembahasan,
    @required this.masuk,
    @required this.keluar,
    @required this.jarak,
    @required this.jadwalId,
    @required this.createdAt,
    @required this.updatedAt,
  });

  dynamic id;
  String pertemuan;
  DateTime tanggal;
  String metode;
  String ruangan;
  String pembahasan;
  String masuk;
  String keluar;
  dynamic jarak;
  dynamic jadwalId;
  DateTime createdAt;
  DateTime updatedAt;

  factory AbsensiElement.fromJson(Map<String, dynamic> json) => AbsensiElement(
        id: json["id"],
        pertemuan: json["pertemuan"],
        tanggal: DateTime.parse(json["tanggal"]),
        metode: json["metode"],
        ruangan: json["ruangan"],
        pembahasan: json["pembahasan"],
        masuk: json["masuk"],
        keluar: json["keluar"] == null ? null : json["keluar"],
        jarak: json["jarak"],
        jadwalId: json["jadwal_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pertemuan": pertemuan,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "metode": metode,
        "ruangan": ruangan,
        "pembahasan": pembahasan,
        "masuk": masuk,
        "keluar": keluar == null ? null : keluar,
        "jarak": jarak,
        "jadwal_id": jadwalId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
