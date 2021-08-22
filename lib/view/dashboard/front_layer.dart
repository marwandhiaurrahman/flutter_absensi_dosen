import 'package:flutter/material.dart';
import 'package:flutter_absensi_dosen/controller/api_controller.dart';
import 'package:flutter_absensi_dosen/endpoint/dashboard.dart';
import 'package:flutter_absensi_dosen/model/hari.dart';
// import 'package:flutter_absensi_dosen/model/jadwal.dart';
// import 'package:flutter_absensi_dosen/model/user.dart';
import 'package:flutter_absensi_dosen/view/matkul/index.dart';
import 'package:intl/intl.dart';
import 'package:responsive_size/responsive_size.dart';

class FrontLayer extends StatefulWidget {
  @override
  _FrontLayerState createState() => _FrontLayerState();
}

class _FrontLayerState extends State<FrontLayer> {
  ApiController apiController = ApiController();

  String _timeString = DateFormat('d MMMM yyyy').format(DateTime.now());

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
          } else if (snapshot.connectionState == ConnectionState.done) {
            User user = snapshot.data.user;
            List<Jadwal> jadwaltodays = snapshot.data.jadwaltodays;
            List<Jadwal> jadwalaktif = snapshot.data.jadwalaktif;
            return Container(
              margin: EdgeInsets.all(spBlock * 0.5),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      user.name.toString(),
                      style: TextStyle(fontSize: spBlock * 1.1),
                    ),
                    Card(
                        child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spBlock * 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Informasi'),
                          Text('Hari : ' +
                              hari[DateTime.now().weekday - 1] +
                              ' ,' +
                              _timeString),
                        ],
                      ),
                    )),
                    Card(
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        title: Text('Absensi Aktif'),
                        leading: Icon(Icons.menu),
                        children: jadwalaktif
                            .map((e) => Container(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        isThreeLine: true,
                                        title: Text(e.matkul.name),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(hari[int.parse(e.hari)] +
                                                ', ' +
                                                e.jamkul.masuk +
                                                ' - ' +
                                                e.jamkul.keluar),
                                            Text('Ruangan ' +
                                                e.ruangan.kode +
                                                ' Kelas ' +
                                                e.kelas.kode),
                                            Text('Mulai masuk ' +
                                                e.absensi[e.absensi.length - 1]
                                                    .masuk)
                                          ],
                                        ),
                                        leading: Icon(Icons.book),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MatkulView(
                                                        index: e.id,
                                                        jadwal: e,
                                                      )));
                                          print('Jadwal Id ' + e.id.toString());
                                        },
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    Card(
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        title: Text('Jadwal Hari Ini'),
                        leading: Icon(Icons.menu),
                        children: jadwaltodays
                            .map((e) => Container(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        isThreeLine: true,
                                        title: Text(e.matkul.name),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(hari[int.parse(e.hari)] +
                                                ', ' +
                                                e.jamkul.masuk +
                                                ' - ' +
                                                e.jamkul.keluar),
                                            Text('Ruangan ' +
                                                e.ruangan.kode +
                                                ' Kelas ' +
                                                e.kelas.kode),
                                          ],
                                        ),
                                        leading: Icon(Icons.book),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MatkulView(
                                                          jadwal: e,
                                                          index: e.id)));
                                        },
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text('Jadwal Mata Kuliah'),
                        leading: Icon(Icons.menu),
                        onTap: () {
                          Navigator.pushNamed(context, '/jadwal');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
            // return
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
