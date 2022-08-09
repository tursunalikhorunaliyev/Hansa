import 'package:flutter/material.dart';

class ProviderPersonalTextFields{
  final imyaController = TextEditingController();
  final familiyaController = TextEditingController();
  final dataRojdeniyaController = TextEditingController();
  final emailController = TextEditingController();
  final telefonController = TextEditingController();
  final magazinController = TextEditingController();
  final doljnostController = TextEditingController();
  final gorodController = TextEditingController();
  final addressController = TextEditingController();

  TextEditingController get getImyaController => imyaController;
  TextEditingController get getFamiliyaController => familiyaController;
  TextEditingController get getDataRojdeniyaController => dataRojdeniyaController;
  TextEditingController get getEmailController => emailController;
  TextEditingController get getTelefonController => telefonController;
  TextEditingController get getMagazinController => magazinController;
  TextEditingController get getDoljnostController => doljnostController;
  TextEditingController get getGorodController => gorodController;
  TextEditingController get getAddressController => addressController;

   

}