import 'package:flutter/material.dart';

class JadwalModel {
  JadwalModel({
    @required this.id,
    @required this.kode,
    @required this.hari,
    @required this.jam,
    @required this.matkulId,
    @required this.ruanganId,
    @required this.kelasId,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.matkul,
    @required this.ruangan,
    @required this.kelas,
    @required this.jamkul,
  });

  int id;
  String kode;
  String hari;
  String jam;
  int matkulId;
  int ruanganId;
  int kelasId;
  DateTime createdAt;
  DateTime updatedAt;
  Matkul matkul;
  Ruangan ruangan;
  Kelas kelas;
  Jamkul jamkul;

  factory JadwalModel.fromJson(Map<String, dynamic> json) => JadwalModel(
        id: json["id"],
        kode: json["kode"],
        hari: json["hari"],
        jam: json["jam"],
        matkulId: json["matkul_id"],
        ruanganId: json["ruangan_id"],
        kelasId: json["kelas_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        matkul: Matkul.fromJson(json["matkul"]),
        ruangan: Ruangan.fromJson(json["ruangan"]),
        kelas: Kelas.fromJson(json["kelas"]),
        jamkul: Jamkul.fromJson(json["jamkul"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "hari": hari,
        "jam": jam,
        "matkul_id": matkulId,
        "ruangan_id": ruanganId,
        "kelas_id": kelasId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "matkul": matkul.toJson(),
        "ruangan": ruangan.toJson(),
        "kelas": kelas.toJson(),
        "jamkul": jamkul.toJson(),
      };
}

class Jamkul {
  Jamkul({
    @required this.id,
    @required this.masuk,
    @required this.keluar,
    @required this.sks,
    @required this.createdAt,
    @required this.updatedAt,
  });

  int id;
  String masuk;
  String keluar;
  int sks;
  DateTime createdAt;
  DateTime updatedAt;

  factory Jamkul.fromJson(Map<String, dynamic> json) => Jamkul(
        id: json["id"],
        masuk: json["masuk"],
        keluar: json["keluar"],
        sks: json["sks"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "masuk": masuk,
        "keluar": keluar,
        "sks": sks,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Kelas {
  Kelas({
    @required this.id,
    @required this.name,
    @required this.kode,
    @required this.tahun,
    @required this.prodiId,
    @required this.createdAt,
    @required this.updatedAt,
  });

  int id;
  String name;
  String kode;
  String tahun;
  int prodiId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Kelas.fromJson(Map<String, dynamic> json) => Kelas(
        id: json["id"],
        name: json["name"],
        kode: json["kode"],
        tahun: json["tahun"],
        prodiId: json["prodi_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "kode": kode,
        "tahun": tahun,
        "prodi_id": prodiId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Matkul {
  Matkul({
    @required this.id,
    @required this.name,
    @required this.kode,
    @required this.userId,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.dosen,
  });

  int id;
  String name;
  String kode;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  Dosen dosen;

  factory Matkul.fromJson(Map<String, dynamic> json) => Matkul(
        id: json["id"],
        name: json["name"],
        kode: json["kode"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        dosen: Dosen.fromJson(json["dosen"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "kode": kode,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "dosen": dosen.toJson(),
      };
}

class Dosen {
  Dosen({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.emailVerifiedAt,
    @required this.foto,
    @required this.createdAt,
    @required this.updatedAt,
  });

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  dynamic foto;
  DateTime createdAt;
  DateTime updatedAt;

  factory Dosen.fromJson(Map<String, dynamic> json) => Dosen(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        foto: json["foto"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "foto": foto,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Ruangan {
  Ruangan({
    @required this.id,
    @required this.name,
    @required this.lantai,
    @required this.kode,
    @required this.gedungId,
    @required this.createdAt,
    @required this.updatedAt,
  });

  int id;
  String name;
  int lantai;
  String kode;
  int gedungId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Ruangan.fromJson(Map<String, dynamic> json) => Ruangan(
        id: json["id"],
        name: json["name"],
        lantai: json["lantai"],
        kode: json["kode"],
        gedungId: json["gedung_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lantai": lantai,
        "kode": kode,
        "gedung_id": gedungId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
