import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/prezintatsi_model.dart';
import 'package:hansa_app/api_services/welcome_api.dart';
import 'package:hansa_app/blocs/prezintatsia_bloc.dart';
import 'package:hansa_app/extra/archive_card.dart';
import 'package:hansa_app/extra/prezentatTabCard.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class PresentArchive extends StatefulWidget {
  const PresentArchive({Key? key}) : super(key: key);

  @override
  State<PresentArchive> createState() => _PresentArchiveState();
}

class _PresentArchiveState extends State<PresentArchive> {
  @override
  Widget build(BuildContext context) {
    print("ok qurildi");
    final token = Provider.of<String>(context);
    final bloc = PrezintatsiaBLoC(token);
    bloc.sinkAction.add(PrezintatsiaAction.show);

    final scroll = ScrollController();

    final welcomeApi = WelcomeApi(token);
    welcomeApi.eventSink.add(WelcomeApiAction.fetch);

    final isTablet = Provider.of<bool>(context);

    late dynamic response;
    Future<void>? launched;
    return Expanded(
      child: FutureBuilder<PrezintatsiaModel>(
          future: bloc.getPrezintatsiyaData(token),
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
                                      snapshot.data!.data.guides.dataGuides
                                          .length, (index) {
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: StackedStackPrezentatsiyaTab(
                                          buttonLink:
                                              snapshot
                                                          .data!
                                                          .data
                                                          .guides
                                                          .dataGuides[index]
                                                          .pdfUrl ==
                                                      ''
                                                  ? SizedBox()
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                          top: isTablet
                                                              ? 22.h
                                                              : 27.h),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            launched =
                                                                _launchInBrowser(
                                                                    Uri.parse(
                                                                        "http://${snapshot.data!.data.guides.dataGuides[index].pdfUrl}"));
                                                          });
                                                        },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: isTablet
                                                              ? 100
                                                              : 94,
                                                          height: isTablet
                                                              ? 28
                                                              : 25,
                                                          decoration: BoxDecoration(
                                                              color: const Color(
                                                                  0xff31353b),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          13.r)),
                                                          child: Text(
                                                            'Скачать',
                                                            style: GoogleFonts.montserrat(
                                                                fontSize:
                                                                    isTablet
                                                                        ? 12
                                                                        : 10,
                                                                color: const Color(
                                                                    0xffffffff),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                          isFavouriteURL: snapshot
                                              .data!
                                              .data
                                              .guides
                                              .dataGuides[index]
                                              .favourite_link,
                                          linkPDFSkachat: snapshot.data!.data
                                              .guides.dataGuides[index].pdfUrl,
                                          linkPDF: snapshot.data!.data.guides
                                              .dataGuides[index].link,
                                          buttonColor: const Color(0xffff163e),
                                          topButtonText: 'Скачать',
                                          bottomButtonText: 'Читать',
                                          isFavourite: snapshot
                                              .data!
                                              .data
                                              .guides
                                              .dataGuides[index]
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
                                                  color:
                                                      const Color(0xffffffff),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          title: snapshot.data!.data.guides
                                              .dataGuides[index].title,
                                          url: snapshot.data!.data.guides
                                              .dataGuides[index].picture_link,
                                        ) /* StackedStackPrezentatsiyaTab(
                                        isFavouriteURL: snapshot
                                            .data!
                                            .data
                                            .guides
                                            .dataGuides[index]
                                            .favourite_link,
                                        linkPDFSkachat: snapshot.data!.data
                                            .guides.dataGuides[index].pdfUrl,
                                        linkPDF: snapshot.data!.data.guides
                                            .dataGuides[index].link,
                                        buttonColor: const Color(0xffff163e),
                                        topButtonText: 'Скачать',
                                        bottomButtonText: 'Читать',
                                        isFavourite: snapshot.data!.data.guides
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
                                        title: snapshot.data!.data.guides
                                            .dataGuides[index].title,
                                        url: snapshot.data!.data.guides
                                            .dataGuides[index].picture_link,
                                      ), */
                                        );
                                  }),
                                ),
                              ))
                          : Column(
                              children: List.generate(
                              snapshot.data!.data.guides.dataGuides.length,
                              (index) {
                                return Column(
                                  children: [
                                    Row(),
                                    ArchiveCard(
                                      downloadButton: snapshot.data!.data.guides
                                                  .dataGuides[index].pdfUrl ==
                                              ''
                                          ? SizedBox()
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                  top: isTablet ? 22.h : 27.h),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    launched = _launchInBrowser(
                                                        Uri.parse(snapshot
                                                            .data!
                                                            .data
                                                            .guides
                                                            .dataGuides[index]
                                                            .link));
                                                  });
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: isTablet ? 100 : 94,
                                                  height: isTablet ? 28 : 25,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xff31353b),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              13.r)),
                                                  child: Text(
                                                    'Скачать',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: isTablet
                                                                ? 12
                                                                : 10,
                                                            color: const Color(
                                                                0xffffffff),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ),
                                              ),
                                            ),
                                      isFavouriteURL: snapshot.data!.data.guides
                                          .dataGuides[index].favourite_link,
                                      linkPDFSkachat: snapshot.data!.data.guides
                                          .dataGuides[index].pdfUrl,
                                      linkPDF: snapshot.data!.data.guides
                                          .dataGuides[index].link,
                                      buttonColor: const Color(0xffff163e),
                                      topButtonText: 'Скачать',
                                      bottomButtonText: 'Читать',
                                      isFavourite: snapshot.data!.data.guides
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
                                      title: snapshot.data!.data.guides
                                          .dataGuides[index].title,
                                      url: snapshot.data!.data.guides
                                          .dataGuides[index].picture_link,
                                    )
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
                                      snapshot.data!.data.guidesArchive
                                          .dataGuidesArchive.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: StackedStackPrezentatsiyaTab(
                                        buttonLink: snapshot
                                                    .data!
                                                    .data
                                                    .guidesArchive
                                                    .dataGuidesArchive[index]
                                                    .pdfUrl ==
                                                ''
                                            ? SizedBox()
                                            : Padding(
                                                padding: EdgeInsets.only(
                                                    top:
                                                        isTablet ? 22.h : 27.h),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      launched = _launchInBrowser(
                                                          Uri.parse(
                                                              "http://${snapshot.data!.data.guidesArchive.dataGuidesArchive[index].link}"));
                                                    });
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: isTablet ? 100 : 94,
                                                    height: isTablet ? 28 : 25,
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xff31353b),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    13.r)),
                                                    child: Text(
                                                      'Скачать',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: isTablet
                                                                  ? 12
                                                                  : 10,
                                                              color: const Color(
                                                                  0xffffffff),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        isFavouriteURL: snapshot
                                            .data!
                                            .data
                                            .guidesArchive
                                            .dataGuidesArchive[index]
                                            .favourite_link,
                                        linkPDFSkachat: snapshot
                                            .data!
                                            .data
                                            .guidesArchive
                                            .dataGuidesArchive[index]
                                            .pdfUrl,
                                        linkPDF: snapshot
                                            .data!
                                            .data
                                            .guidesArchive
                                            .dataGuidesArchive[index]
                                            .link,
                                        buttonColor: const Color(0xffff163e),
                                        topButtonText: 'Скачать',
                                        bottomButtonText: 'Читать',
                                        isFavourite: snapshot
                                            .data!
                                            .data
                                            .guidesArchive
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
                                        title: snapshot.data!.data.guidesArchive
                                            .dataGuidesArchive[index].title,
                                        url: snapshot
                                            .data!
                                            .data
                                            .guidesArchive
                                            .dataGuidesArchive[index]
                                            .picture_link,
                                      ),
                                    );
                                  }),
                                ),
                              ))
                          : Column(
                              children: List.generate(
                                  snapshot.data!.data.guidesArchive
                                      .dataGuidesArchive.length,
                                  (index) => Column(
                                        children: [
                                          Row(),
                                          ArchiveCard(
                                            downloadButton: snapshot
                                                        .data!
                                                        .data
                                                        .guidesArchive
                                                        .dataGuidesArchive[
                                                            index]
                                                        .pdfUrl ==
                                                    ''
                                                ? SizedBox()
                                                : Padding(
                                                    padding: EdgeInsets.only(
                                                        top: isTablet
                                                            ? 22.h
                                                            : 27.h),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          launched =
                                                              _launchInBrowser(
                                                                  Uri.parse(
                                                                      "${snapshot.data!.data.guidesArchive.dataGuidesArchive[index].link}"));
                                                        });
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width:
                                                            isTablet ? 100 : 94,
                                                        height:
                                                            isTablet ? 28 : 25,
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xff31353b),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        13.r)),
                                                        child: Text(
                                                          'Скачать',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      isTablet
                                                                          ? 12
                                                                          : 10,
                                                                  color: const Color(
                                                                      0xffffffff),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            isFavouriteURL: snapshot
                                                .data!
                                                .data
                                                .guidesArchive
                                                .dataGuidesArchive[index]
                                                .favourite_link,
                                            linkPDFSkachat: snapshot
                                                .data!
                                                .data
                                                .guidesArchive
                                                .dataGuidesArchive[index]
                                                .pdfUrl,
                                            buttonColor:
                                                const Color(0xffff163e),
                                            topButtonText: 'Скачать',
                                            bottomButtonText: 'Читать',
                                            linkPDF: snapshot
                                                .data!
                                                .data
                                                .guidesArchive
                                                .dataGuidesArchive[index]
                                                .link,
                                            isFavourite: snapshot
                                                .data!
                                                .data
                                                .guidesArchive
                                                .dataGuidesArchive[index]
                                                .isFavourite,
                                            skachat: Container(
                                              alignment: Alignment.center,
                                              width: 94,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff31353b),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          13)),
                                              child: Text(
                                                'skachat',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 10,
                                                    color:
                                                        const Color(0xffffffff),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            title: snapshot
                                                .data!
                                                .data
                                                .guidesArchive
                                                .dataGuidesArchive[index]
                                                .title,
                                            url: snapshot
                                                .data!
                                                .data
                                                .guidesArchive
                                                .dataGuidesArchive[index]
                                                .picture_link,
                                          )
                                        ],
                                      ))))
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

  _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
