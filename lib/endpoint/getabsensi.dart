// To parse this JSON data, do
//
//     final absensi = absensiFromJson(jsonString);

import 'package:flutter_absensi_dosen/model/absensi.dart';
import 'dart:convert';

Absensi absensiFromJson(String str) =>
    Absensi.fromJson(json.decode(str)['data']);

String absensiToJson(Absensi data) => json.encode(data.toJson());
