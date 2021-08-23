// import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_absensi_dosen/endpoint/dashboard.dart';
import 'package:flutter_absensi_dosen/endpoint/getabsensi.dart';
import 'package:flutter_absensi_dosen/endpoint/jadwalsaya.dart';
// import 'package:flutter_absensi_dosen/model/absensi.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiController {
//   String serverUrl = "http://10.0.2.2:8000/api";
  // String serverUrl = "http://192.168.43.32:8000/api";
//blk
  // String serverUrl = "http://192.168.100.199:8000/api";
  String serverUrl = "https://absensi.studionya.com/api";
  var status;
  var token;

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 1);

  Future<String> loginUser(LoginData loginData) async {
    try {
      print('Login Info');
      print('Name: ${loginData.name}');
      print('Password: ${loginData.password}');
      String myUrl = "$serverUrl/login";
      final response = await http.post(Uri.parse(myUrl), headers: {
        'Accept': 'application/json'
      }, body: {
        "email": '${loginData.name}',
        "password": "${loginData.password}"
      }).timeout(Duration(seconds: 120));
      status = response.body.contains('error');
      var data = json.decode(response.body);
      return Future(() {
        if (status) {
          print('data : ${data["error"]}');
          return 'Error : ${data["message"]}';
        }
        print('User Name : ${data["data"]["name"]}');
        _save('token', data["data"]["token"]);
        _save('name', data["data"]["name"]);
        _save('id', data["data"]["id"].toString());
        _save('email', data["data"]["email"]);
        return null;
      });
    } catch (e) {
      print('Error : $e');
      return 'Error : $e';
    }
  }

  Future dashboard() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.get('token') ?? 0;
      //   print('Dashboard token :' + token.toString());
      String myUrl = "$serverUrl/dashboard";
      final response = await http.get(Uri.parse(myUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        print('dashboard ' + response.statusCode.toString());
        // print(jsonDecode(response.body)['data']);
        return dasboardFromJson(response.body);
      }
    } catch (e) {
      print('Error dashboard :' + e.toString());
    }
  }

  Future jadwalsaya() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.get('token') ?? 0;
      //   print('Dashboard token :' + token);
      String myUrl = "$serverUrl/jadwalsaya";
      final response = await http.get(Uri.parse(myUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        print('jadwal saya ' + response.statusCode.toString());
        return jadwalSayaFromJson(response.body);
      }
    } catch (e) {
      print('Error :' + e.toString());
    }
  }

  Future getabsensi(int index) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.get('token') ?? 0;
      //   print('Dashboard token :' + token);
      String myUrl = "$serverUrl/absensi/$index";
      final response = await http.get(Uri.parse(myUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        print('absensi matkul ' + response.statusCode.toString());
        return absensiFromJson(response.body);
      }
    } catch (e) {
      print('Error :' + e.toString());
    }
  }

  Future absensimasuk(
    String tanggal,
    String metode,
    String ruangan,
    String pembahasan,
    int jadwalid,
    double latitude,
    double longitude,
    double jarak,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final value = prefs.get(key) ?? 0;
      String myUrl = "$serverUrl/absensi/masuk";
      var req = await http.post(Uri.parse(myUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value'
      }, body: {
        "tanggal": tanggal,
        "metode": metode,
        "ruangan": ruangan,
        "pembahasan": pembahasan,
        "jadwal_id": jadwalid.toString(),
        "lat_anda": latitude.toString(),
        "long_anda": longitude.toString(),
        "jarak": jarak.toString(),
      }).timeout(Duration(seconds: 30));
      print('Response status absensi masuk : ${req.body}');
      if (req.statusCode == 200) {
        return json.decode(req.body);
      } else {
        print('Response status absensi masuk : ${req.statusCode}');
        return json.decode(req.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future absensikeluar(
    int id,
    String tanggal,
    String metode,
    String ruangan,
    String pembahasan,
    int jadwalid,
    double latitude,
    double longitude,
    double jarak,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final value = prefs.get(key) ?? 0;

      String myUrl = "$serverUrl/absensi/keluar/$id";
      var req = await http.put(Uri.parse(myUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value'
      }, body: {
        "tanggal": tanggal,
        "metode": metode,
        "ruangan": ruangan,
        "pembahasan": pembahasan,
        "jadwal_id": jadwalid.toString(),
        "lat_anda": latitude.toString(),
        "long_anda": longitude.toString(),
        "jarak": jarak.toString(),
      }).timeout(Duration(seconds: 30));
      print('Response status absensi keluar : ${req.statusCode}');
      if (req.statusCode == 200) {
        return json.decode(req.body);
      } else {
        print('Response status absensi masuk : ${req.statusCode}');
        return json.decode(req.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future getlocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final value = prefs.get(key) ?? 0;

      String myUrl = "$serverUrl/location";
      var req = await http.get(Uri.parse(myUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value'
      }).timeout(Duration(seconds: 30));
      print('Response body xx: ' + req.body);
      return json.decode(req.body)['data'];
    } catch (e) {
      print(e);
    }
  }

  Future getRuangan(String kode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final value = prefs.get(key) ?? 0;

      String myUrl = "$serverUrl/ruangan?kode=$kode";
      var req = await http.get(Uri.parse(myUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value',
      }).timeout(Duration(seconds: 30));
      print('Respone get Ruangan: ' + req.body);
      return json.decode(req.body)['data'];
    } catch (e) {
      print(e);
    }
  }
//   Future<List<Product>> listProduct() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.get('token') ?? 0;

//     String myUrl = "$serverUrl/products/";
//     final response = await http.get(Uri.parse(myUrl), headers: {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token'
//     }).timeout(Duration(seconds: 30));
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       // print(json.decode(response.body)['data']);
//       return productFromJson(response.body);
//     } else {
//       throw Exception('Failed to load album');
//     }
//   }

//   Future<Product> showProduct(String id) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.get('token') ?? 0;

//     String myUrl = "$serverUrl/products/$id";
//     final response = await http.get(Uri.parse(myUrl), headers: {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token'
//     }).timeout(Duration(seconds: 30));
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print(json.decode(response.body)['data']);
//       return Product.fromJson(json.decode(response.body)['data']);
//     } else {
//       throw Exception('Failed to load album');
//     }
//   }

  void addProduct(String name, String detail) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final value = prefs.get(key) ?? 0;

      String myUrl = "$serverUrl/products";
      http.post(Uri.parse(myUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value'
      }, body: {
        "name": "$name",
        "detail": "$detail"
      }).then((response) {
        print('Response status : ${response.statusCode}');
        print('Response body : ${response.body}');
      }).timeout(Duration(seconds: 30));
    } catch (e) {
      print(e);
    }
  }

//   void deleteData(int id) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final key = 'token';
//       final value = prefs.get(key) ?? 0;

//       String myUrl = "$serverUrl/products/$id";
//       http.delete(Uri.parse(myUrl), headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $value'
//       }).then((response) {
//         print('Response status : ${response.statusCode}');
//         print('Response body : ${response.body}');
//       }).timeout(Duration(seconds: 30));
//     } catch (e) {
//       print(e);
//     }
//   }

//   void updateProduct(int id, String name, String detail) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final key = 'token';
//       final value = prefs.get(key) ?? 0;

//       String myUrl = "$serverUrl/products/$id";
//       http.put(Uri.parse(myUrl), headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $value',
//       }, body: {
//         "name": "$name",
//         "detail": "$detail",
//       }).then((response) {
//         print('Response status : ${response.statusCode}');
//         print('Response body : ${response.body}');
//       }).timeout(Duration(seconds: 30));
//     } catch (e) {
//       print(e);
//     }
//   }

  _save(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }
}
