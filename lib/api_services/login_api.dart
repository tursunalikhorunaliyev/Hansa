import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class LoginAction {
 String gate = "https://hansa-lab.ru/api/auth/login";
 final  String username;
 final  String password;
 final bool isSaved;
  LoginAction({required this.username, required this.password, required this.isSaved});
 
  
    Future<List> sendRequest() async{
     http.Response response = await http.post(
        Uri.parse(gate), body: {"username": username, "password": password});
    Map<String, dynamic> responseMap = jsonDecode(response.body) as Map<String, dynamic>;
     print(response.body);
     
    if(responseMap["status"].toString().endsWith("true")){
      String token = responseMap["data"]["token"].toString();
      if(isSaved){
        
        final box = Hive.box("loginHansa");
        box.put("userToken", token);
        box.put("isSaved", isSaved);
  }
      return [isSaved, token, true];
    }
    else{
      return ["","",false];
    }
   
  }
  
 
}