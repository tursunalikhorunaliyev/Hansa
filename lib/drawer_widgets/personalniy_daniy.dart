import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/model_personal.dart';
import 'package:hansa_app/blocs/bloc_personal.dart';
import 'package:hansa_app/drawer_widgets/popup_personal_doljnost.dart';
import 'package:hansa_app/drawer_widgets/popup_personal_gorod.dart';
import 'package:hansa_app/drawer_widgets/popup_personal_magazin.dart';
import 'package:hansa_app/drawer_widgets/referal_silka.dart';
import 'package:hansa_app/drawer_widgets/text_field_for_personal.dart';
import 'package:hansa_app/providers/provider_personal_textFields.dart';
import 'package:provider/provider.dart';

class PersonalniyDaniy extends StatefulWidget {
  const PersonalniyDaniy({Key? key}) : super(key: key);

  @override
  State<PersonalniyDaniy> createState() => _PersonalniyDaniyState();
}

class _PersonalniyDaniyState extends State<PersonalniyDaniy> {
  TextEditingController imyaController = TextEditingController();
  TextEditingController familyaController = TextEditingController();
  TextEditingController dataRojController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController magazinController = TextEditingController();
  TextEditingController doljnostController = TextEditingController();
  TextEditingController gorodController = TextEditingController();
  TextEditingController adresController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    final providerToken = Provider.of<String>(context);

    final blocPersonal = BlocPersonal();

    final personalInfoEditTextFieldsProvider =
        Provider.of<ProviderPersonalTextFields>(context);

    return Center(
      child: FutureBuilder<ModelPersonalMain>(
          future: blocPersonal.getData(providerToken),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              personalInfoEditTextFieldsProvider.imyaController.text =
                  snapshot.data!.modelPersonal1.firstname;
              personalInfoEditTextFieldsProvider.familiyaController.text =
                  snapshot.data!.modelPersonal1.lastname;
              personalInfoEditTextFieldsProvider.dataRojdeniyaController.text =
                  snapshot.data!.modelPersonal1.bornedAt;
              personalInfoEditTextFieldsProvider.gorodController.text =
                  snapshot.data!.modelPersonal1.cityId.name;
              personalInfoEditTextFieldsProvider.addressController.text =
                  snapshot.data!.modelPersonal1.shopAddress;
              personalInfoEditTextFieldsProvider.doljnostController.text =
                  snapshot.data!.modelPersonal1.job.name;
              personalInfoEditTextFieldsProvider.telefonController.text =
                  snapshot.data!.modelPersonal1.phone;
                  personalInfoEditTextFieldsProvider.storeName.text =
                  snapshot.data!.modelPersonal1.store.name;


              personalInfoEditTextFieldsProvider.country_typeId =
                  snapshot.data!.modelPersonal1.countryType.id.toString();

              personalInfoEditTextFieldsProvider.cityId =
                  snapshot.data!.modelPersonal1.cityId.id.toString();

              personalInfoEditTextFieldsProvider.jobId =
                  snapshot.data!.modelPersonal1.job.id.toString();

              personalInfoEditTextFieldsProvider.storeId =
                  snapshot.data!.modelPersonal1.store.id.toString();

              return Column(
                children: [
                  Image.asset(
                    "assets/user_icons.png",
                    height: isTablet ? 50 : 37,
                    width: isTablet ? 50 : 37,
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Персональные данные",
                    style: GoogleFonts.montserrat(
                        fontSize: isTablet ? 16 : 13,
                        color: const Color(0xFFffffff)),
                  ),
                  SizedBox(
                    height: isTablet ? 40 : 25,
                  ),
                  TextFieldForPersonal(
                      text: "Имя",
                      controller:
                          personalInfoEditTextFieldsProvider.imyaController),
                  SizedBox(
                    height: isTablet ? 15 : 8,
                  ),
                  TextFieldForPersonal(
                      text: "Фамилия",
                      controller: personalInfoEditTextFieldsProvider
                          .familiyaController),
                  SizedBox(
                    height: isTablet ? 15 : 8,
                  ),
                  TextFieldForPersonal(
                      text: "Дата рождения",
                      controller: personalInfoEditTextFieldsProvider
                          .dataRojdeniyaController),
                  SizedBox(
                    height: isTablet ? 15 : 8,
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: AbsorbPointer(
                      absorbing: true,
                      child: (
                         TextFieldForPersonal(
                            text: "E-mail",
                           
                            controller:
                                TextEditingController(text: snapshot.data!.modelPersonal1.email))
                      ),
                    ),
                  ),
                  SizedBox(
                    height: isTablet ? 15 : 8,
                  ),
                  TextFieldForPersonal(
                      text: "Телефон",
                      controller:
                          personalInfoEditTextFieldsProvider.telefonController),
                  SizedBox(
                    height: isTablet ? 15 : 8,
                  ),
                  PopupPersonalMagazin(
                    controller:
                        personalInfoEditTextFieldsProvider.storeName,
                  ),
                  SizedBox(
                    height: isTablet ? 15 : 8,
                  ),
                  PopupPersonalDoljnost(
                    controller:
                        personalInfoEditTextFieldsProvider.doljnostController,
                  ),
                  SizedBox(
                    height: isTablet ? 15 : 8,
                  ),
                  PopupPersonalGorod(
                      controller:
                          personalInfoEditTextFieldsProvider.gorodController),
                  SizedBox(
                    height: isTablet ? 15 : 8,
                  ),
                  TextFieldForPersonal(
                      text: "Адрес",
                      controller:
                          personalInfoEditTextFieldsProvider.addressController),
                  SizedBox(
                    height: isTablet ? 50 : 10,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: isTablet ? 40 : 10),
                    child: const ReferalSilka(),
                  ),
                ],
              );
            } else {
              return const Center(
                child: SpinKitPulse(
                  color: Colors.white,
                ),
              );
            }
          }),
    );
  }
}
