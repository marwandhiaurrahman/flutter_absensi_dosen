import 'package:flutter/material.dart';
import 'package:flutter_absensi_dosen/controller/api_controller.dart';
import 'package:flutter_absensi_dosen/endpoint/dashboard.dart';
import 'package:responsive_size/responsive_size.dart';

class BackLayer extends StatefulWidget {
  @override
  _BackLayerState createState() => _BackLayerState();
}

class _BackLayerState extends State<BackLayer> {
  ApiController apiController = ApiController();

  @override
  void initState() {
    apiController.dashboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(
        designWidth: MediaQuery.of(context).size.width,
        designHeight: MediaQuery.of(context).size.height);
    return FutureBuilder(
        future: apiController.dashboard(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error : ' + snapshot.error.toString()),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            User user = snapshot.data.user;
            return Container(
              margin: EdgeInsets.all(spBlock * 0.5),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Selamat Datang di Aplikasi Absensi',
                      style: TextStyle(
                          fontSize: spBlock * 1.1, color: Colors.white),
                    ),
                    Text(
                      user.name.toString(),
                      style: TextStyle(
                          fontSize: spBlock * 1.1, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                        child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spBlock * 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Informasi Akun'),
                          Text('Nama : ' + user.name),
                          Text('No. Telp : ' + '089529909035'),
                          Text('Email : ' + user.email),
                          Text('Alamat : ' +
                              'Desa Leuweunggajah Kec. Ciledug Kab. Cirebon'),
                          Text('Jabatan : ' + 'Dosen Pengajar'),
                        ],
                      ),
                    )),
                    // Card(
                    //   child: ExpansionTile(
                    //     initiallyExpanded: true,
                    //     title: Text('Absensi Aktif'),
                    //     leading: Icon(Icons.menu),
                    //     children: jadwalaktif
                    //         .map((e) => Container(
                    //               child: Column(
                    //                 children: [
                    //                   ListTile(
                    //                     isThreeLine: true,
                    //                     title: Text(e.matkul.name),
                    //                     subtitle: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         Text(hari[int.parse(e.hari)] +
                    //                             ', ' +
                    //                             e.jamkul.masuk +
                    //                             ' - ' +
                    //                             e.jamkul.keluar),
                    //                         Text('Ruangan ' +
                    //                             e.ruangan.kode +
                    //                             ' Kelas ' +
                    //                             e.kelas.kode),
                    //                       ],
                    //                     ),
                    //                     leading: Icon(Icons.book),
                    //                     onTap: () {
                    //                       Navigator.push(
                    //                           context,
                    //                           MaterialPageRoute(
                    //                               builder: (context) =>
                    //                                   MatkulView(
                    //                                       jadwal: e,
                    //                                       index: e.id)));
                    //                     },
                    //                   ),
                    //                 ],
                    //               ),
                    //             ))
                    //         .toList(),
                    //   ),
                    // ),
                    // Card(
                    //   child: ExpansionTile(
                    //     initiallyExpanded: true,
                    //     title: Text('Jadwal Hari Ini'),
                    //     leading: Icon(Icons.menu),
                    //     children: jadwaltodays
                    //         .map((e) => Container(
                    //               child: Column(
                    //                 children: [
                    //                   ListTile(
                    //                     isThreeLine: true,
                    //                     title: Text(e.matkul.name),
                    //                     subtitle: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         Text(hari[int.parse(e.hari)] +
                    //                             ', ' +
                    //                             e.jamkul.masuk +
                    //                             ' - ' +
                    //                             e.jamkul.keluar),
                    //                         Text('Ruangan ' +
                    //                             e.ruangan.kode +
                    //                             ' Kelas ' +
                    //                             e.kelas.kode),
                    //                       ],
                    //                     ),
                    //                     leading: Icon(Icons.book),
                    //                     onTap: () {
                    //                       Navigator.push(
                    //                           context,
                    //                           MaterialPageRoute(
                    //                               builder: (context) =>
                    //                                   MatkulView(
                    //                                       jadwal: e,
                    //                                       index: e.id)));
                    //                     },
                    //                   ),
                    //                 ],
                    //               ),
                    //             ))
                    //         .toList(),
                    //   ),
                    // ),
                    // Card(
                    //   child: ListTile(
                    //     title: Text('Jadwal Mata Kuliah'),
                    //     leading: Icon(Icons.menu),
                    //     onTap: () {
                    //       Navigator.pushNamed(context, '/jadwal');
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
            // return

          }
        });
  }
}
