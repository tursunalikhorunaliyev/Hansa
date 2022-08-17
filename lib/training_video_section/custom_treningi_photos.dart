import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/treningi_photos_model.dart';
import 'package:hansa_app/api_services/treningi_photos_api.dart';
import 'package:hansa_app/providers/treningi_photos_provider.dart';
import 'package:provider/provider.dart';

class CustomTreningiPhotos extends StatelessWidget {
  const CustomTreningiPhotos({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final page = PageController(initialPage: 0);
    final token = Provider.of<String>(context);
    final treningiPhotos = Provider.of<TreningiPhotosProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: SizedBox(
        height: 325,
        width: 345,
        child: FutureBuilder<TreningiPhotosModel>(
            future: TreningiPhotosApi.getdata(treningiPhotos.getUrl, token),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxHeight: 220,
                                    maxWidth: 325,
                                  ),
                                  child: PageView.builder(
                                    allowImplicitScrolling: true,
                                    physics: const BouncingScrollPhysics(),
                                    controller: page,
                                    itemCount:
                                        snapshot.data!.data.data.list.length,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        height: 220,
                                        width: 325,
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot.data!.data.data
                                              .list[index].picture_link,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  height: 220,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (page.hasClients &&
                                        page.offset <
                                            snapshot.data!.data.data.list
                                                    .length *
                                                325) {
                                      page.previousPage(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 27,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        topLeft: Radius.circular(16),
                                        bottomLeft: Radius.circular(16),
                                      ),
                                      color: Color(0xffff163e),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/back.png",
                                        height: 20,
                                        width: 20,
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
                                    height: 35,
                                    width: 27,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topRight: Radius.circular(16),
                                        bottomRight: Radius.circular(16),
                                      ),
                                      color: Color(0xffff163e),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/forward.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 11,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            height: 90,
                            width: 325,
                            color: const Color(0xffffffff),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    "Иммерсивное шоу\n\"Увидимся на кухне\"г.\nЕкатеринбург:     18.04.2019",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: GestureDetector(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(64),
                                      child: Container(
                                        height: 25,
                                        width: 95,
                                        color: const Color(0xffff163e),
                                        child: Center(
                                          child: Text(
                                            "Скачать",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 10,
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
                      ],
                    ),
                    Positioned(
                      top: 197,
                      right: 40,
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: const BoxDecoration(
                          color: Color(0xfff1f1f1),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.favorite,
                            color: Color(0xffed3851),
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return SizedBox();
              }
            }),
      ),
    );
  }
}
