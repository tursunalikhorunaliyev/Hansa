import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/prezintatsi_model.dart';
import 'package:hansa_app/api_services/welcome_api.dart';
import 'package:hansa_app/blocs/prezintatsia_bloc.dart';
import 'package:hansa_app/extra/archive_card.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PresentArchive extends StatefulWidget {
  const PresentArchive({Key? key}) : super(key: key);

  @override
  State<PresentArchive> createState() => _PresentArchiveState();
}

class _PresentArchiveState extends State<PresentArchive> {
  @override
  Widget build(BuildContext context) {
    final token = Provider.of<String>(context);
    final bloc = PrezintatsiaBLoC(token);
    bloc.sinkAction.add(PrezintatsiaAction.show);

    final scroll = ScrollController();

    final welcomeApi = WelcomeApi(token);
    welcomeApi.eventSink.add(WelcomeApiAction.fetch);

    final isTablet = Provider.of<bool>(context);

    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: StreamBuilder<PrezintatsiaModel>(
            stream: bloc.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
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
                                    const EdgeInsets.symmetric(horizontal: 35),
                                child: GridView(
                                  controller: scroll,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 30,
                                          childAspectRatio: 10 / 8),
                                  children: List.generate(
                                      snapshot.data!.data.data.dataGuides
                                          .length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: ArchiveCard(
                                        linkPDF: snapshot.data!.data.data
                                            .dataGuides[index].pdfUrl,
                                        buttonColor: const Color(0xffff163e),
                                        topButtonText: 'Скачать',
                                        bottomButtonText: 'Читать',
                                        isFavourite: snapshot.data!.data.data
                                            .dataGuides[index].isFavourite,
                                        skachat: Container(
                                          alignment: Alignment.center,
                                          width: 94,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff31353b),
                                              borderRadius:
                                                  BorderRadius.circular(13)),
                                          child: Text(
                                            'skachat',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        title: snapshot.data!.data.data
                                            .dataGuides[index].title,
                                        url: snapshot.data!.data.data
                                            .dataGuides[index].picture_link,
                                      ),
                                    );
                                  }),
                                ),
                              ))
                          : Column(
                              children: List.generate(
                              snapshot.data!.data.data.dataGuides.length,
                              (index) {
                                return Column(
                                  children: [
                                    Row(),
                                    Column(children: [
                                      ArchiveCard(
                                        linkPDF: snapshot.data!.data.data
                                            .dataGuides[index].pdfUrl,
                                        buttonColor: const Color(0xffff163e),
                                        topButtonText: 'Скачать',
                                        bottomButtonText: 'Читать',
                                        isFavourite: snapshot.data!.data.data
                                            .dataGuides[index].isFavourite,
                                        skachat: Container(
                                          alignment: Alignment.center,
                                          width: 94,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff31353b),
                                              borderRadius:
                                                  BorderRadius.circular(13)),
                                          child: Text(
                                            'skachat',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        title: snapshot.data!.data.data
                                            .dataGuides[index].title,
                                        url: snapshot.data!.data.data
                                            .dataGuides[index].picture_link,
                                      ),
                                    ])
                                  ],
                                );
                              },
                            ))),
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
                                  'assets/Архив.png',
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
                                'Архив',
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
                                padding: const EdgeInsets.only(
                                  left: 35,
                                  right: 35,
                                ),
                                child: GridView(
                                  controller: scroll,

                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  //      physics: const BouncingScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 30,
                                          childAspectRatio: 10 / 8),
                                  children: List.generate(
                                      snapshot.data!.data.data.dataGuidesArchive
                                          .length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: ArchiveCard(
                                        linkPDF: snapshot.data!.data.data
                                            .dataGuidesArchive[index].pdfUrl,
                                        buttonColor: const Color(0xffff163e),
                                        topButtonText: 'Скачать',
                                        bottomButtonText: 'Читать',
                                        isFavourite: snapshot
                                            .data!
                                            .data
                                            .data
                                            .dataGuidesArchive[index]
                                            .isFavourite,
                                        skachat: Container(
                                          alignment: Alignment.center,
                                          width: 94,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff31353b),
                                              borderRadius:
                                                  BorderRadius.circular(13)),
                                          child: Text(
                                            'skachat',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        title: snapshot.data!.data.data
                                            .dataGuidesArchive[index].title,
                                        url: snapshot
                                            .data!
                                            .data
                                            .data
                                            .dataGuidesArchive[index]
                                            .picture_link,
                                      ),
                                    );
                                  }),
                                ),
                              ))
                          : Expanded(
                              child: Column(
                                  children: List.generate(
                                      snapshot.data!.data.data.dataGuidesArchive
                                          .length,
                                      (index) => Column(
                                            children: [
                                              Row(),
                                              Column(
                                                children: [
                                                  ArchiveCard(
                                                    buttonColor:
                                                        const Color(0xffff163e),
                                                    topButtonText: 'Скачать',
                                                    bottomButtonText: 'Читать',
                                                    linkPDF: snapshot
                                                        .data!
                                                        .data
                                                        .data
                                                        .dataGuidesArchive[
                                                            index]
                                                        .pdfUrl,
                                                    isFavourite: snapshot
                                                        .data!
                                                        .data
                                                        .data
                                                        .dataGuidesArchive[
                                                            index]
                                                        .isFavourite,
                                                    skachat: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 94,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xff31353b),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      13)),
                                                      child: Text(
                                                        'skachat',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 10,
                                                                color: const Color(
                                                                    0xffffffff),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                    title: snapshot
                                                        .data!
                                                        .data
                                                        .data
                                                        .dataGuidesArchive[
                                                            index]
                                                        .title,
                                                    url: snapshot
                                                        .data!
                                                        .data
                                                        .data
                                                        .dataGuidesArchive[
                                                            index]
                                                        .picture_link,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ))),
                            ))
                ]);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
