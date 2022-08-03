import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hansa_app/screens/hansa_zagruzka.dart';
import 'package:hansa_app/screens/welcome_screen.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = Hive.box("savedUser");

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  checkUser() async {
    if (box.get("isSaved") != null && box.get("isSaved")! as bool) {
      Map<String, dynamic> map = await login(box.get("username"), box.get("password"));
      await Future.delayed(const Duration(seconds: 1));
      goToHome(await map["data"]["token"]);
    } else {
      await Future.delayed(const Duration(seconds: 0));
      goToHansaZagruzka();
    }
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    String gate = "https://hansa-lab.ru/api/auth/login";
    http.Response response = await http.post(Uri.parse(gate),
        body: {"username": username, "password": password});
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: SpinKitWanderingCubes(
        color: Colors.red,
      )),
    );
  }

  goToHome(token){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Provider(
          create: (context) => token.toString(),
          child: const WelcomeScreen())));
  }

  goToHansaZagruzka() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const HansaZagruzka()));
  }
}
