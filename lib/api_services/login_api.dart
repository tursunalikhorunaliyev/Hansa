import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginAction {
 String gate = "https://hansa-lab.ru/api/auth/login";
 final  String username;
 final  String password;
  LoginAction({required this.username, required this.password});
 
  
    Future<bool> sendRequest() async{
     http.Response response = await http.post(
        Uri.parse(gate), body: {"username": username, "password": password});
    Map<String, dynamic> responseMap = jsonDecode(response.body) as Map<String, dynamic>;
     print(response.body);
    if(responseMap["status"].toString().endsWith("true")){
      return true;
    }
    else{
      return false;
    }
   
  }
  
 
}