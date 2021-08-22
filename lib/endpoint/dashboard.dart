// To parse this JSON data, do
//
//     final dasboard = dasboardFromJson(jsonString);

import 'dart:convert';

Dasboard dasboardFromJson(String str) =>
    Dasboard.fromJson(json.decode(str)['data']);

String dasboardToJson(Dasboard data) => json.encode(data.toJson());

class Dasboard {
  Dasboard({
    this.user,
    this.jadwaltodays,
    this.jadwalaktif,
  });

  User user;
  List<Jadwal> jadwaltodays;
  List<Jadwal> jadwalaktif;

  factory Dasboard.fromJson(Map<String, dynamic> json) => Dasboard(
        user: User.fromJson(json["user"]),
        jadwaltodays: List<Jadwal>.from(
            json["jadwaltodays"].map((x) => Jadwal.fromJson(x))),
        jadwalaktif: List<Jadwal>.from(
            json["jadwalaktif"].map((x) => Jadwal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "jadwaltodays": List<dynamic>.from(jadwaltodays.map((x) => x.toJson())),
        "jadwalaktif": List<dynamic>.from(jadwalaktif.map((x) => x.toJson())),
      };
}

class Jadwal {
  Jadwal({
    this.id,
    this.kode,
    this.hari,
    this.jam,
    this.matkulId,
    this.ruanganId,
    this.kelasId,
    this.createdAt,
    this.updatedAt,
    this.matkul,
    this.ruangan,
    this.kelas,
    this.jamkul,
    this.absensi,
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
  List<Absensi> absensi;

  factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
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
        absensi: json["absensi"] == null
            ? null
            : List<Absensi>.from(
                json["absensi"].map((x) => Absensi.fromJson(x))),
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
        "absensi": absensi == null
            ? null
            : List<dynamic>.from(absensi.map((x) => x.toJson())),
      };
}

class Absensi {
  Absensi({
    this.id,
    this.pertemuan,
    this.tanggal,
    this.metode,
    this.pembahasan,
    this.masuk,
    this.keluar,
    this.jarak,
    this.jadwalId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String pertemuan;
  DateTime tanggal;
  Metode metode;
  String pembahasan;
  String masuk;
  String keluar;
  double jarak;
  int jadwalId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Absensi.fromJson(Map<String, dynamic> json) => Absensi(
        id: json["id"],
        pertemuan: json["pertemuan"],
        tanggal: DateTime.parse(json["tanggal"]),
        metode: metodeValues.map[json["metode"]],
        pembahasan: json["pembahasan"],
        masuk: json["masuk"],
        keluar: json["keluar"] == null ? null : json["keluar"],
        jarak: json["jarak"].toDouble(),
        jadwalId: json["jadwal_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pertemuan": pertemuan,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "metode": metodeValues.reverse[metode],
        "pembahasan": pembahasan,
        "masuk": masuk,
        "keluar": keluar == null ? null : keluar,
        "jarak": jarak,
        "jadwal_id": jadwalId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum Metode { E_CLASS, TATAP_MUKA }

final metodeValues =
    EnumValues({"E-Class": Metode.E_CLASS, "Tatap Muka": Metode.TATAP_MUKA});

class Jamkul {
  Jamkul({
    this.id,
    this.masuk,
    this.keluar,
    this.sks,
    this.createdAt,
    this.updatedAt,
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
    this.id,
    this.name,
    this.kode,
    this.tahun,
    this.prodiId,
    this.createdAt,
    this.updatedAt,
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
    this.id,
    this.name,
    this.kode,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.dosen,
  });

  int id;
  String name;
  String kode;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  User dosen;

  factory Matkul.fromJson(Map<String, dynamic> json) => Matkul(
        id: json["id"],
        name: json["name"],
        kode: json["kode"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        dosen: User.fromJson(json["dosen"]),
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

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.foto,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  dynamic foto;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
    this.id,
    this.name,
    this.lantai,
    this.kode,
    this.gedungId,
    this.createdAt,
    this.updatedAt,
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

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
