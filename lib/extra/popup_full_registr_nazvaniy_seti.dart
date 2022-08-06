import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/store_model.dart';
import 'package:hansa_app/api_services/store_service.dart';
import 'package:hansa_app/blocs/bloc_popup_drawer.dart';
import 'package:provider/provider.dart';

class PopupFullRegistrNazvaniySeti extends StatefulWidget {
  PopupFullRegistrNazvaniySeti({Key? key}) : super(key: key);

  @override
  State<PopupFullRegistrNazvaniySeti> createState() =>
      _PopupFullRegistrNazvaniySetiState();
}

class _PopupFullRegistrNazvaniySetiState
    extends State<PopupFullRegistrNazvaniySeti> {
  final blocPopupDrawer = BlocPopupDrawer();
  double radius = 54;
  String text = "Названия сети";

  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);

    final blocStoreData = StoreData();

    blocStoreData.eventSink.add(StoreEnum.store);

    return StreamBuilder<double>(
        initialData: 38,
        stream: blocPopupDrawer.dataStream,
        builder: (context, snapshotSizeDrawer) {
          return InkWell(
            onTap: () {
              blocPopupDrawer.dataSink
                  .add(snapshotSizeDrawer.data! == 38 ? 250 : 38);
              radius = radius == 54 ? 10 : 54;
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 11, right: 9),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                height: isTablet ? 43 : snapshotSizeDrawer.data!,
                width: isTablet ? 350 : 360,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(width: 0.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 12),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 233),
                        child: Text(
                          text,
                          style: GoogleFonts.montserrat(
                              fontSize: isTablet ? 13 : 10,
                              color: const Color(0xFF444444)),
                        ),
                      ),
                      StreamBuilder<StoreModel>(
                          stream: blocStoreData.stream,
                          builder: (context, snapshotStore) {
                            if (snapshotStore.hasData) {
                              return Visibility(
                                visible: (radius > 50) ? false : true,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, top: 5),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(5),
                                              hintText: "Новый",
                                              hintStyle:
                                                  const TextStyle(fontSize: 13),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 97,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: ListView.builder(
                                          itemCount: snapshotStore
                                              .data!.data.list.length,
                                          padding: const EdgeInsets.all(0),
                                          itemBuilder: (context, index) {
                                            return TextButton(
                                              onPressed: () {
                                                text = snapshotStore.data!.data
                                                    .list[index].name;
                                                blocPopupDrawer.dataSink.add(
                                                    snapshotStore.data! == 38
                                                        ? 200
                                                        : 38);
                                                radius = radius == 54 ? 10 : 54;
                                              },
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  snapshotStore.data!.data
                                                      .list[index].name,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: MaterialButton(
                                        onPressed: () {},
                                        height: 30,
                                        minWidth: 300,
                                        color: const Color(0xFFe21a37),
                                        child: Text(
                                          "OK",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
