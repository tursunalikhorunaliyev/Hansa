import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hansa_app/screens/hansa_zagruzka.dart';
import 'package:hansa_app/screens/welcome_screen.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String username;
  late String password;
  late String token = "";
  bool isSaved = false;
  @override
  void initState() {
    changeSplash();

    super.initState();
  }

  changeSplash() {
    final box = Hive.box("savedUser");

    if (box.get("isSaved") as bool) {
      username = box.get("username").toString();
      password = box.get("password").toString();
      isSaved = true;
      Future.delayed(const Duration(seconds: 2)).then((value) async {
        await getToken();
        goToWelcome(token);
      });
      
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const HansaZagruzka()));
    }
  }

  getToken() async {
    String gate = "https://hansa-lab.ru/api/auth/login";
    http.Response response = await http.post(Uri.parse(gate),
        body: {"username": username, "password": password});
    token = jsonDecode(response.body)["data"]["token"].toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitWanderingCubes(
          color: Colors.red,
          duration: Duration(seconds: 2),
        ),
      ),
    );
  }

  goToWelcome(token) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Provider(
                create: (context) => token.toString(),
                child: const WelcomeScreen())));
  }
}
