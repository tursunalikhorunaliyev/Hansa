import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/model_magazin.dart';
import 'package:hansa_app/blocs/bloc_magazin.dart';
import 'package:hansa_app/blocs/bloc_popup_drawer.dart';
import 'package:hansa_app/enums/enum_action_view.dart';
import 'package:provider/provider.dart';

class PopupPersonalMagazin extends StatefulWidget {
  final TextEditingController controller;
 const PopupPersonalMagazin({Key? key, required this.controller}) : super(key: key);

  @override
  State<PopupPersonalMagazin> createState() => _PopupPersonalMagazinState();
}

class _PopupPersonalMagazinState extends State<PopupPersonalMagazin> {
  final blocPopupDrawer = BlocPopupDrawer();

  double radius = 54;
  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    final providerToken = Provider.of<String>(context);

    final blocMagazin = BlocMagazin(providerToken);

    blocMagazin.eventSink.add(EnumActionView.view);

    return StreamBuilder<double>(
        initialData: 36,
        stream: blocPopupDrawer.dataStream,
        builder: (context, snapshot) {
          return InkWell(
            onTap: () {
              blocPopupDrawer.dataSink.add(snapshot.data! == 36 ? 200 : 36);
              radius = radius == 54 ? 10 : 54;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: isTablet ? 45 : snapshot.data!,
              width: isTablet ? 350 : 269,
              decoration: BoxDecoration(
                  color: const Color(0xFF000000),
                  borderRadius: BorderRadius.circular(radius)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Магазин",
                            style: GoogleFonts.montserrat(
                                fontSize: isTablet ? 13 : 10,
                                color: const Color(0xFF767676)),
                          ),
                          Text(
                            widget.controller.text,
                            style: GoogleFonts.montserrat(
                                color: const Color(0xFFffffff), fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    StreamBuilder<ModelMagazinMain>(
                        stream: blocMagazin.dataStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Expanded(
                              child: Visibility(
                                visible: radius == 54 ? false : true,
                                child: ListView.builder(
                                  itemCount:
                                      snapshot.data!.modelMagazin2.list.length,
                                  itemBuilder: (context, index) {
                                    return MaterialButton(
                                      onPressed: () {
                                        widget.controller.text = snapshot.data!
                                            .modelMagazin2.list[index].name;
                                        blocPopupDrawer.dataSink.add(
                                            snapshot.data! == 36 ? 200 : 36);
                                        radius = radius == 54 ? 10 : 54;
                                      },
                                      height: 30,
                                      minWidth: 10,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          snapshot.data!.modelMagazin2
                                              .list[index].name,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        ),
                                      ),
                                    );
                                  },
                                ),
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
          );
        });
  }
}