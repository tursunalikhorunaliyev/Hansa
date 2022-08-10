import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/catalog_model.dart';
import 'package:hansa_app/api_services/catalog_api.dart';
import 'package:hansa_app/api_services/welcome_api.dart';
import 'package:hansa_app/extra/custom_katalog_item_double.dart';
import 'package:hansa_app/extra/custom_tablet_katalog_item.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/prezintatsi_model.dart';
import 'package:hansa_app/api_services/welcome_api.dart';
import 'package:hansa_app/blocs/prezintatsia_bloc.dart';
import 'package:hansa_app/extra/archive_card.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sticky_headers/sticky_headers.dart';

class Katalogi extends StatefulWidget {
  const Katalogi({Key? key}) : super(key: key);

  @override
  State<Katalogi> createState() => _KatalogiState();
}

class _KatalogiState extends State<Katalogi> {
  @override
  Widget build(BuildContext context) {
    final token = Provider.of<String>(context);
    final isTablet = Provider.of<bool>(context);
    final catalogBloc = CatalogBloc(token);

    final scroll = ScrollController();
    final welcomeApi = WelcomeApi(token);
    welcomeApi.eventSink.add(WelcomeApiAction.fetch);
    catalogBloc.eventSink.add(CatalogAction.get);
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: StreamBuilder<CatalogModel>(
            stream: catalogBloc.dataStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!.data;
                return Expanded(
                  child: Column(
                    children: [
                      StickyHeader(
                        header: Expanded(
                          child: const CustomTitle(
                            imagePath: "assets/katalogi_title.png",
                            title: "Каталоги",
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35),
                                  child: GridView(
                                    controller: scroll,
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 30,
                                            childAspectRatio: 1.130),
                                    children: List.generate(
                                        data.guides.list.length, (index) {
                                      return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: TabletKatalogItem(
                                            linkPDFSkachat: snapshot.data!.data
                                                .guides.list[index].link,
                                            linkPDF: snapshot.data!.data.guides
                                                .list[index].pdfUrl,
                                            imageUrl: data
                                                .guides.list[index].pictureLink,
                                            backgroundColor:
                                                const Color(0xff000004),
                                            buttonTextColor:
                                                const Color(0xffffffff),
                                            buttonColor:
                                                const Color(0xffff163e),
                                            titleColor: const Color(0xffffffff),
                                            title:
                                                data.guides.list[index].title,
                                            stbuttonText: "Скачать",
                                            ndbuttonText: "Читать",
                                          ));
                                    }),
                                  ),
                                ))
                            : Column(
                                children: List.generate(data.guides.list.length,
                                    (index) {
                                  return CustomKatalogItemDouble(
                                    linkPDFSkachat: snapshot
                                        .data!.data.guides.list[index].link,
                                    linkPDF: snapshot
                                        .data!.data.guides.list[index].pdfUrl,
                                    imageUrl:
                                        data.guides.list[index].pictureLink,
                                    backgroundColor: const Color(0xff000004),
                                    buttonTextColor: const Color(0xffffffff),
                                    buttonColor: const Color(0xffff163e),
                                    titleColor: const Color(0xffffffff),
                                    title: data.guides.list[index].title,
                                    stbuttonText: "Скачать",
                                    ndbuttonText: "Читать",
                                  );
                                }),
                              ),
                      ),
                      StickyHeader(
                        header: const CustomTitle(
                          imagePath: "assets/katalogi_title.png",
                          title: "Архив",
                        ),
                        content: isTablet
                            ? NotificationListener(
                                onNotification: (value) {
                                  welcomeApi.eventSink
                                      .add(WelcomeApiAction.fetch);
                                  return false;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35),
                                  child: GridView(
                                    controller: scroll,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 30,
                                            childAspectRatio: 1.1),
                                    children: List.generate(
                                        snapshot.data!.data.guidesArchive.list
                                            .length, (index) {
                                      return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: TabletKatalogItem(
                                            linkPDFSkachat: snapshot.data!.data
                                                .guidesArchive.list[index].link,
                                            linkPDF: snapshot
                                                .data!
                                                .data
                                                .guidesArchive
                                                .list[index]
                                                .pdfUrl,
                                            imageUrl: data.guidesArchive
                                                .list[index].pictureLink,
                                            backgroundColor:
                                                const Color(0xff000004),
                                            buttonTextColor:
                                                const Color(0xffffffff),
                                            buttonColor:
                                                const Color(0xffff163e),
                                            titleColor: const Color(0xffffffff),
                                            title: data.guidesArchive
                                                .list[index].title,
                                            stbuttonText: "Скачать",
                                            ndbuttonText: "Читать",
                                          ));
                                    }),
                                  ),
                                ))
                            : Column(
                                children: List.generate(
                                    data.guidesArchive.list.length, (index) {
                                  return CustomKatalogItemDouble(
                                    linkPDFSkachat: snapshot.data!.data
                                        .guidesArchive.list[index].link,
                                    linkPDF: snapshot.data!.data.guidesArchive
                                        .list[index].pdfUrl,
                                    imageUrl: data
                                        .guidesArchive.list[index].pictureLink,
                                    backgroundColor: const Color(0xff000004),
                                    buttonTextColor: const Color(0xffffffff),
                                    buttonColor: const Color(0xffff163e),
                                    titleColor: const Color(0xffffffff),
                                    title: data.guidesArchive.list[index].title,
                                    stbuttonText: "Скачать",
                                    ndbuttonText: "Читать",
                                  );
                                }),
                              ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                    child: Padding(
                  padding: EdgeInsets.only(
                      top: (MediaQuery.of(context).size.height / 2) - 135),
                  child: Lottie.asset(
                    'assets/pre.json',
                    height: 70,
                    width: 70,
                  ),
                ));
              }
            }),
      ),
    );
  }
}
