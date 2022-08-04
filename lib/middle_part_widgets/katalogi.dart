import 'package:flutter/material.dart';
import 'package:hansa_app/api_models.dart/catalog_model.dart';
import 'package:hansa_app/api_services/catalog_api.dart';
import 'package:hansa_app/extra/custom_katalog_item_double.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:provider/provider.dart';
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
    final catalogBloc = CatalogBloc(token);
    catalogBloc.eventSink.add(CatalogAction.get);
    return Expanded(
      child: Column(
        children: [
          StreamBuilder<CatalogModel>(
              stream: catalogBloc.dataStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!.data;
                  return Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          StickyHeader(
                            header: const CustomTitle(
                              imagePath: "assets/katalogi_title.png",
                              title: "Каталоги",
                            ),
                            content: Column(
                              children: List.generate(data.guides.list.length,
                                  (index) {
                                return CustomKatalogItemDouble(
                                  imageUrl: data.guides.list[index].pictureLink,
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
                            content: Column(
                              children: List.generate(
                                  data.guidesArchive.list.length, (index) {
                                return CustomKatalogItemDouble(
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
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }
}
