import 'package:flutter/material.dart';
import 'package:flutter_despensa/api_service.dart';
import 'loginpage.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    if (kReleaseMode)
    exit(1);
  };

  final preferences = await SharedPreferences.getInstance();
  await preferences.setString('api_root', 'http://127.0.0.1:8000');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Despensa',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: <Widget>[
        Image.asset(
          'assets/images/hometopleft.png',
          height: 145,
          width: 145,
          alignment: Alignment.topLeft,
        ),
        const SizedBox(
          height: 30,
        ),
        InkWell(
          child: RichText(
              key: const Key("Initialize"),
              textAlign: TextAlign.center,
              text: const TextSpan(children: <TextSpan>[
                TextSpan(
                  text: "Des",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                    text: "pensa",
                    style: TextStyle(
                        color: Color.fromARGB(255, 241, 147, 58),
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold))
              ])),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginPage(title: 'Login UI')));
          },
        ),
        const SizedBox(
          height: 30,
        ),
        Image.asset(
          'assets/images/homebottomright.png',
          height: 175,
          width: 175,
          alignment: Alignment.bottomRight,
        ),
      ]),
    ));
  }
}

class LogInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
