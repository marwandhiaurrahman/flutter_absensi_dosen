import 'package:flutter/material.dart';
import 'package:flutter_absensi_dosen/controller/api_controller.dart';
import 'package:flutter_absensi_dosen/endpoint/dashboard.dart';
import 'package:flutter_absensi_dosen/model/hari.dart';
// import 'package:flutter_absensi_dosen/model/jadwal.dart';
import 'package:flutter_absensi_dosen/view/matkul/index.dart';
import 'package:grouped_list/grouped_list.dart';

class JadwalView extends StatefulWidget {
  @override
  _JadwalViewState createState() => _JadwalViewState();
}

class _JadwalViewState extends State<JadwalView> {
  ApiController apiController = ApiController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Mata Kuliah'),
      ),
      body: FutureBuilder(
        future: apiController.jadwalsaya(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error : ' + snapshot.error.toString()),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Jadwal> jadwals = snapshot.data.jadwals;
            print('jumlah jadwal ' + jadwals.length.toString());
            return GroupedListView<Jadwal, String>(
              elements: jadwals,
              groupBy: (element) => element.hari,
              // groupComparator: (value1, value2) => value2.compareTo(value1),
              // itemComparator: (item1, item2) =>
              //     item1['name'].compareTo(item2['name']),
              order: GroupedListOrder.ASC,
              // useStickyGroupSeparators: true,
              groupSeparatorBuilder: (value) {
                return Container(
                  color: Colors.grey.shade300,
                  padding: EdgeInsets.all(5),
                  child: Text(
                    hari[int.parse(value)],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
              itemBuilder: (context, element) {
                return ListTile(
                    title: Text(element.matkul.name),
                    isThreeLine: true,
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(hari[int.parse(element.hari)] +
                            ', ' +
                            element.jamkul.masuk +
                            ' - ' +
                            element.jamkul.keluar),
                        Text('Ruangan ' +
                            element.ruangan.kode +
                            ' Kelas ' +
                            element.kelas.kode),
                      ],
                    ),
                    leading: Icon(Icons.book),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MatkulView(
                                  jadwal: element, index: element.id)));
                      print(element.id);
                    });
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
