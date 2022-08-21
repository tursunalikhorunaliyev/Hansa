import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/treningi_photos_model.dart';
import 'package:hansa_app/api_services/treningi_photos_api.dart';
import 'package:hansa_app/providers/treningi_photos_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class TabletPhotosItem extends StatelessWidget {
  const TabletPhotosItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final page = PageController(initialPage: 0);
    final token = Provider.of<String>(context);
    final treningiPhotos = Provider.of<TreningiPhotosProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 11, left: 25, right: 25),
      child: SizedBox(
        width: double.infinity,
        child: FutureBuilder<TreningiPhotosModel>(
            future: TreningiPhotosApi.getdata(treningiPhotos.getUrl, token),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxHeight: 520, maxWidth: double.infinity),
                                child: PageView.builder(
                                  allowImplicitScrolling: true,
                                  physics: const BouncingScrollPhysics(),
                                  controller: page,
                                  itemCount:
                                      snapshot.data!.data.data.list.length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                      child: SizedBox(
                                        height: 450,
                                        width: double.infinity,
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot.data!.data.data
                                              .list[index].pictureLink,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 225),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (page.hasClients &&
                                      page.offset <
                                          snapshot.data!.data.data.list.length *
                                              325) {
                                    page.previousPage(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.ease,
                                    );
                                  }
                                },
                                child: Container(
                                  height: 80,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(23),
                                      bottomRight: Radius.circular(23),
                                      topLeft: Radius.circular(35),
                                      bottomLeft: Radius.circular(35),
                                    ),
                                    color: Color(0xffff163e),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/back.png",
                                      height: 45,
                                      width: 45,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  if (page.hasClients) {
                                    page.nextPage(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.ease,
                                    );
                                  }
                                },
                                child: Container(
                                  height: 80,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(23),
                                      bottomLeft: Radius.circular(23),
                                      topRight: Radius.circular(35),
                                      bottomRight: Radius.circular(35),
                                    ),
                                    color: Color(0xffff163e),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/forward.png",
                                      height: 45,
                                      width: 45,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 150,
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          width: double.infinity,
                          color: const Color(0xffffffff),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 10, bottom: 8),
                                child: SizedBox(
                                  width: 550,
                                  child: Text(
                                    snapshot.data!.data.data.list[0].title,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 35),
                                child: GestureDetector(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(64),
                                    child: Container(
                                      height: 35,
                                      width: 130,
                                      color: const Color(0xffff163e),
                                      child: Center(
                                        child: Text(
                                          "Скачать",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            color: const Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Padding(
                  padding: EdgeInsets.only(
                      top: (MediaQuery.of(context).size.height / 2) - 8),
                  child: Center(
                    child: Lottie.asset(
                      'assets/pre.json',
                      height: 70,
                      width: 70,
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
