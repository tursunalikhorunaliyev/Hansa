import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/search_model.dart';
import 'package:hansa_app/api_services/search_api.dart';
import 'package:hansa_app/enums/search_action.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Map<String, dynamic>? globalData;
  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    final token = Provider.of<String>(context);
    SearchApi searchApi = SearchApi(token, search.text);
    searchApi.eventSink.add(SearchAction.search);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: .85.sw,
                  child: TextField(
                    controller: search,
                    onChanged: (value) {
                      value = search.text;
                      setState(() {});
                    },
                    cursorColor: const Color(0xFF272624),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF272624),
                        ),
                      ),
                      hintText: "Поиск",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF272624),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (search.text.length > 2) {
                      log("Search button clicked...");
                      setState(() {});
                    }
                  },
                  child: const Icon(Icons.search),
                )
              ],
            ),
          ),
          StreamBuilder<SearchModel>(
              stream: searchApi.dataStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!.data.data;
                  log("Length of data ${data.length}");
                  return Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                      children: List.generate(data.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 20),
                          child: SizedBox(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: SizedBox(
                                        height: 65,
                                        width: 120,
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: data[index].picturelink,
                                          height: isTablet
                                              ? 110
                                              : 66.66666666666667,
                                          width: isTablet
                                              ? 150
                                              : 101.6666666666667,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 11,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 240,
                                          child: Text(
                                            data[index].title,
                                            softWrap: true,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.montserrat(
                                                color: const Color(0xFF272624),
                                                fontSize: isTablet
                                                    ? 14
                                                    : 9.666666666666667,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: isTablet ? 240 : 90,
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: isTablet ? 22 : 21,
                                                width: isTablet ? 74 : 63,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.5),
                                                  color:
                                                      const Color(0xFF313131),
                                                ),
                                                child: Text(
                                                  "Показать",
                                                  style: GoogleFonts.montserrat(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const Divider(
                                  color: Color(0xFF8c8c8b),
                                  thickness: 1,
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    )
                        // : const Text("There is nothing"),
                        ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }
}
