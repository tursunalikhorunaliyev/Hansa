import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/model_personal.dart';
import 'package:hansa_app/blocs/bloc_personal.dart';
import 'package:hansa_app/drawer_widgets/popup_personal.dart';
import 'package:hansa_app/drawer_widgets/referal_silka.dart';
import 'package:hansa_app/drawer_widgets/text_field_for_personal.dart';
import 'package:hansa_app/enums/enum_action_view.dart';
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
    final blocPersonal = BlocPersonal(providerToken);
    blocPersonal.eventSink.add(EnumActionView.view);
    return Center(
      child: StreamBuilder<ModelPersonalMain>(
          stream: blocPersonal.dataStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
                      controller: TextEditingController(
                          text: snapshot.data!.modelPersonal1.firstname)),
                  SizedBox(
                    height: isTablet ? 15 : 8,
                  ),
                  TextFieldForPersonal(
                      text: "Фамилия",
                      controller: TextEditingController(
                          text: snapshot.data!.modelPersonal1.lastname)),
                  SizedBox(
                    height: isTablet ? 15 : 8,
                  ),
                  TextFieldForPersonal(
                      text: "Дата рождения",
                      controller: TextEditingController(
                          text: snapshot.data!.modelPersonal1.bornedAt)),
                  SizedBox(
                    height: isTablet ? 15 : 8,
                  ),
                  TextFieldForPersonal(
                      text: "E-mail",
                      controller: TextEditingController(
                          text: snapshot.data!.modelPersonal1.email)),
                  SizedBox(
                    height: isTablet ? 15 : 8,
                  ),
                  TextFieldForPersonal(
                      text: "Телефон",
                      controller: TextEditingController(
                          text: snapshot.data!.modelPersonal1.phone)),
                  SizedBox(
                    height: isTablet ? 15 : 8,
                  ),
                  InkWell(
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return Container(
                              width: 360,
                              height: 400,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text("123"),
                            );
                          },
                        );
                      },
                      child: PopupPersonal(
                          controller: TextEditingController(
                              text:
                                  snapshot.data!.modelPersonal1.shopAddress))),
                  SizedBox(
                    height: isTablet ? 15 : 8,
                  ),
                  /* TextFieldForPersonal(
                      text: "Должность",
                      controller: TextEditingController(
                          text:
                              snapshot.data!.modelPersonal1.jobId.toString())), */
                  PopupPersonal(
                      controller: TextEditingController(
                          text:
                              snapshot.data!.modelPersonal1.jobId.toString())),
                  SizedBox(
                    height: isTablet ? 15 : 8,
                  ),
                  TextFieldForPersonal(
                      text: "Город",
                      controller: TextEditingController(
                          text:
                              snapshot.data!.modelPersonal1.cityId.toString())),
                  SizedBox(
                    height: isTablet ? 15 : 8,
                  ),
                  TextFieldForPersonal(
                      text: "Адрес",
                      controller: TextEditingController(
                          text: snapshot.data!.modelPersonal1.countryType
                              .toString())),
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
                child: SpinKitWanderingCubes(
                  color: Colors.red,
                ),
              );
            }
          }),
    );
  }
}
