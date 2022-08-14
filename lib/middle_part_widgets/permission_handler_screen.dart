import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hansa_app/screens/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerScreen extends StatefulWidget {
  const PermissionHandlerScreen({Key? key}) : super(key: key);

  @override
  State<PermissionHandlerScreen> createState() => _PermissionHandlerScreenState();
}

class _PermissionHandlerScreenState extends State<PermissionHandlerScreen> {
  @override
  void initState() {
    getPermission().then((value) {
      if (value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SplashScreen()));
      }
    });
    super.initState();
  }

  Future<bool> getPermission() async {
    var permission = await Permission.storage.request();
    if (permission.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
