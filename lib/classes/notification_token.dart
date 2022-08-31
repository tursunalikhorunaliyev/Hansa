import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';

class NotificationToken {
  Future<String> Function() get getMessagingToken => getToken;
  Future<String> getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    Map<String, String> body = {"token": fcmToken.toString()};
    await post(
      Uri.parse("https://hansa-lab.ru/api/auth/register-token"),
      body: body,
    );
    log(fcmToken.toString());
    return fcmToken!;
  }
}
