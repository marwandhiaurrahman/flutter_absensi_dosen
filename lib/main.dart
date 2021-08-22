import 'package:flutter/material.dart';
import 'package:flutter_absensi_dosen/route/route.dart';
import 'package:flutter_absensi_dosen/view/auth/login.dart';
import 'package:flutter_absensi_dosen/view/dashboard/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    // home: MyApp(),
    initialRoute: '/',
    routes: myRoutes,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Widget> loadFromFuture() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    if (value == 0) {
      print('Not Has Token');
      return Future.value(LoginView());
    }
    if (value != 0) {
      print('Has Token');
      return Future.value(DashboardView());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        loadingText: Text('asdasd'),
        seconds: 3,
        // navigateAfterSeconds:  LoginScreen(),
        navigateAfterFuture: loadFromFuture(),
        title: Text(
          'Welcome In SplashScreen',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        // image:  Image.network('https://i.imgur.com/TyCSG9A.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: Colors.blue);
  }
}
