import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/model_prezent_otkrit.dart';
import 'package:hansa_app/api_models.dart/prezintatsi_model.dart';
import 'package:hansa_app/api_services/welcome_api.dart';
import 'package:hansa_app/blocs/bloc_prezent_otkrit.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/blocs/prezintatsia_bloc.dart';
import 'package:hansa_app/classes/sned_url_prezent_otkrit.dart';
import 'package:hansa_app/extra/archive_card.dart';
import 'package:hansa_app/extra/custom_prezent_card.dart';
import 'package:hansa_app/extra/prezentatTabCard.dart';
import 'package:hansa_app/middle_part_widgets/prezent_otkrit_tablet_card.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class PrezentOtkrit extends StatefulWidget {
  const PrezentOtkrit({Key? key}) : super(key: key);

  @override
  State<PrezentOtkrit> createState() => _PrezentOtkritState();
}

class _PrezentOtkritState extends State<PrezentOtkrit> {
  final sendUrlPrezentOtkrit = SendUrlPrezentOtkrit();
  @override
  Widget build(BuildContext context) {
    final providerMenuEventsBloc = Provider.of<MenuEventsBloC>(context);

    final token = Provider.of<String>(context);
    final providerSendUrlPrezentOtkrit =
        Provider.of<SendUrlPrezentOtkrit>(context);
    final blocPrezentOtkrit = BlocPrezentOtkrit();

    final scroll = ScrollController();

    final welcomeApi = WelcomeApi(token);
    welcomeApi.eventSink.add(WelcomeApiAction.fetch);

    final isTablet = Provider.of<bool>(context);

    late dynamic response;
    Future<void>? launched;
    return Expanded(
      child: FutureBuilder<ModelPrezentOtkritMain>(
          future: blocPrezentOtkrit.getData(token),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(children: [
                  StickyHeader(
                      header: Container(
                        color: const Color(0xffeaeaea),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: isTablet ? 20 : 9, bottom: isTablet ? 9 : 5),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: isTablet ? 55.w : 70.w,
                                height: isTablet ? 46.h : 42.h,
                                decoration: BoxDecoration(
                                    color: Color(0XFFff163e),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                            isTablet ? 45.r : 21.r),
                                        bottomRight: Radius.circular(
                                            isTablet ? 45.r : 21.r))),
                                child: Image.asset(
                                  'assets/free-icon-presentation-582644.png',
                                  height: isTablet ? 30.h : 30,
                                  width: isTablet ? 30.w : 30,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  '#',
                                  style: GoogleFonts.montserrat(
                                      fontSize: isTablet ? 22 : 20,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xffff163e)),
                                ),
                              ),
                              Text(
                                'Презентации ',
                                style: GoogleFonts.montserrat(
                                    fontSize: isTablet ? 25 : 20,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff272624)),
                              )
                            ],
                          ),
                        ),
                      ),
                      content: isTablet
                          ? NotificationListener(
                              onNotification: (value) {
                                welcomeApi.eventSink
                                    .add(WelcomeApiAction.fetch);
                                return false;
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: GridView(
                                  controller: scroll,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisExtent: 375),
                                  children: List.generate(
                                      snapshot.data!.modelPrezentOtkritList.list
                                          .length, (index) {
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: PrezentOtkritTabletCard(
                                            title: snapshot
                                                .data!
                                                .modelPrezentOtkritList
                                                .list[index]
                                                .title,
                                            url: snapshot
                                                .data!
                                                .modelPrezentOtkritList
                                                .list[index]
                                                .pictureLink));
                                  }),
                                ),
                              ))
                          : Column(
                              children: List.generate(
                              snapshot.data!.modelPrezentOtkritList.list.length,
                              (index) {
                                return Column(
                                  children: [
                                    Row(),
                                    CustomPrezentCard(
                                      onTap: () {
                                        providerMenuEventsBloc.eventSink
                                            .add(MenuActions.prezentFav);
                                        log(providerSendUrlPrezentOtkrit
                                            .getUrl);
                                        providerSendUrlPrezentOtkrit.setUrl(
                                            snapshot
                                                .data!
                                                .modelPrezentOtkritList
                                                .list[index]
                                                .link);
                                      },
                                      imageUrl: snapshot
                                          .data!
                                          .modelPrezentOtkritList
                                          .list[index]
                                          .pictureLink,
                                      title: snapshot
                                          .data!
                                          .modelPrezentOtkritList
                                          .list[index]
                                          .title,
                                    )
                                  ],
                                );
                              },
                            ))),
                ]),
              );
            } else {
              return Center(
                  child: Lottie.asset(
                'assets/pre.json',
                height: 70,
                width: 70,
              ));
            }
          }),
    );
  }
}