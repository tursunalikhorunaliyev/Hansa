import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/welcome_model.dart';
import 'package:hansa_app/api_services/welcome_api.dart';
import 'package:hansa_app/extra/event_cards.dart';
import 'package:provider/provider.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();
    final isTablet = Provider.of<bool>(context);
    final token = Provider.of<String>(context);
    final welcomeApi = WelcomeApi(token);
    welcomeApi.eventSink.add(WelcomeApiAction.fetch);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
        
          children: [
            Padding(
              padding: EdgeInsets.only(top: isTablet ? 20 : 9),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: isTablet ? 120 : 70,
                    height: isTablet ? 70 : 42,
                    decoration: BoxDecoration(
                        color: const Color(0XFFff163e),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(isTablet ? 40 : 21),
                            bottomRight: Radius.circular(isTablet ? 40 : 21))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Image.asset(
                        'assets/Lab.png',
                        height: isTablet ? 50 : 12,
                        width: isTablet ? 70 : 42,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '#',
                      style: GoogleFonts.montserrat(
                          fontSize: isTablet ? 25 : 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xffff163e)),
                    ),
                  ),
                  Text(
                    'Добро пожаловать',
                    style: GoogleFonts.montserrat(
                        fontSize: isTablet ? 30 : 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff272624)),
                  ),
                ],
              ),
            ),
            StreamBuilder<List<WelcomeModelData>>(
                stream: welcomeApi.dataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.requireData;
                    return SizedBox(
                      height: isTablet ? 877 : 566,
                      width: isTablet ? 800 : 330,
                      child: isTablet
                          ? SingleChildScrollView(
                              controller: scroll,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      "assets/dobriy.png",
                                      width: 900,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Column(
                                    children: List.generate(
                                        20,
                                        (index) => Row(
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5.0),
                                                    child: EventCards(
                                                      buttonColor: const Color(
                                                          0xffff163e),
                                                      buttonText: 'Смотреть',
                                                      isDate: true,
                                                      month: "июля",
                                                      day: "8",
                                                      title: data[index].title,
                                                      url: data[index]
                                                          .pictureLink,
                                                      isFavourite: data[index]
                                                          .isFavorite,
                                                    )),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5.0),
                                                    child: EventCards(
                                                      buttonColor: const Color(
                                                          0xffff163e),
                                                      buttonText: 'Смотреть',
                                                      isDate: true,
                                                      month: "июля",
                                                      day: "8",
                                                      title: data[index].title,
                                                      url: data[index]
                                                          .pictureLink,
                                                      isFavourite: data[index]
                                                          .isFavorite,
                                                    )),
                                              ],
                                            )),
                                  ),
                                ],
                              ),
                            )
                          : SingleChildScrollView(
                              controller: scroll,
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: List.generate(
                                  data.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: EventCards(
                                      buttonColor: const Color(0xffff163e),
                                      buttonText: 'Смотреть',
                                      isDate: true,
                                      month: "июля",
                                      day: "8",
                                      title: data[index].title,
                                      url: data[index].pictureLink,
                                      isFavourite: data[index].isFavorite,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    );
                  } else {
                    welcomeApi.eventSink.add(WelcomeApiAction.fetch);
                    return const  Center(child: SpinKitWanderingCubes(color: Colors.red,));
                  }
                }),
          ],
        ),
      ],
    );
  }
}
