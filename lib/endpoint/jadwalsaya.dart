// To parse this JSON data, do
//
//     final jadwalSaya = jadwalSayaFromJson(jsonString);

import 'package:flutter_absensi_dosen/endpoint/dashboard.dart';
// import 'package:flutter_absensi_dosen/model/jadwal.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

JadwalSaya jadwalSayaFromJson(String str) =>
    JadwalSaya.fromJson(json.decode(str)['data']);

String jadwalSayaToJson(JadwalSaya data) => json.encode(data.toJson());

class JadwalSaya {
  JadwalSaya({
    @required this.jadwals,
  });

  List<Jadwal> jadwals;

  factory JadwalSaya.fromJson(Map<String, dynamic> json) => JadwalSaya(
        jadwals:
            List<Jadwal>.from(json["jadwals"].map((x) => Jadwal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jadwals": List<dynamic>.from(jadwals.map((x) => x.toJson())),
      };
}
