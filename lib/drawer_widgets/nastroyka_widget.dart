import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/nastroyka_model.dart';
import 'package:hansa_app/blocs/bloc_for_nastroyka.dart';
import 'package:hansa_app/drawer_widgets/text_icon.dart';
import 'package:hansa_app/drawer_widgets/toggle_switcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NastroykaWidget extends StatefulWidget {
  const NastroykaWidget({Key? key}) : super(key: key);

  @override
  State<NastroykaWidget> createState() => _NastroykaWidgetState();
}

class _NastroykaWidgetState extends State<NastroykaWidget> {
  Alignment align = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    final providerToken = Provider.of<String>(context);
    final blocForNastroyka = BlocForNastroyka(providerToken);
    blocForNastroyka.eventSink.add(Nastroyka.nastroyka);

    return Wrap(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 26),
          child: TextIcon(
            text: "Настройки",
            iconUrl: "assets/icon.png",
            colorIcon: Color(0xFFaaaaaa),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Divider(
          color: Color(0xFF444444),
          thickness: 2,
          indent: 26,
          endIndent: 26,
        ),
        const SizedBox(
          height: 43,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 37, right: 23),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Включить пуш уведомления",
                  style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: const Color(0xFFffffff),
                      fontWeight: FontWeight.w500)),
              MultiProvider(
                providers: [
                  Provider(
                    create: (context) => String,
                  ),
                  Provider(
                    create: (context) => TextEditingController(),
                  )
                ],
                child: ToggleSwitch(
                  colorCircle: const Color(0xFF25b049),
                  handlerWidth: 40,
                  handlerHeight: 12,
                  tickerSize: 21,
                  boxShadow: false,
                  colorContainer: const Color(0xFFdddddd),
                  onButton: () {},
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 38,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 37, right: 23),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Подписка на рассылку",
                  style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: const Color(0xFFffffff),
                      fontWeight: FontWeight.w500)),
              MultiProvider(
                  providers: [
                    Provider(
                      create: (context) => String,
                    ),
                    Provider(
                      create: (context) => TextEditingController(),
                    )
                  ],
                  child: Center(
                    child: SizedBox(
                      height: 21,
                      width: 40,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            align = align == Alignment.centerRight
                                ? Alignment.centerLeft
                                : Alignment.centerRight;
                          });
                          blocForNastroyka.postData(providerToken).then(
                              (value) => blocForNastroyka.eventSink
                                  .add(Nastroyka.nastroyka));
                          log("Salom");
                        },
                        child: FutureBuilder<NastroykaModel>(
                            future: blocForNastroyka.getData(providerToken),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: 12,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFdddddd),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    AnimatedAlign(
                                      alignment: align,
                                      duration:
                                          const Duration(milliseconds: 100),
                                      child: Container(
                                        width: 21,
                                        decoration: BoxDecoration(
                                            color:
                                                align == Alignment.centerRight
                                                    ? const Color(0xFF25b049)
                                                    : Colors.grey[350],
                                            borderRadius:
                                                BorderRadius.circular(25.r)),
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            }),
                      ),
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(
          height: 38,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 37, right: 23),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Оставаться в трее ",
                  style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: const Color(0xFFffffff),
                      fontWeight: FontWeight.w500)),
              MultiProvider(
                providers: [
                  Provider(
                    create: (context) => String,
                  ),
                  Provider(
                    create: (context) => TextEditingController(),
                  )
                ],
                child: ToggleSwitch(
                  colorCircle: const Color(0xFF25b049),
                  handlerWidth: 40,
                  handlerHeight: 12,
                  tickerSize: 21,
                  boxShadow: false,
                  colorContainer: const Color(0xFFdddddd),
                  onButton: () {},
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 186,
        ),
        const Divider(
          color: Color(0xFF444444),
          thickness: 2,
          indent: 26,
          endIndent: 26,
        ),
      ],
    );
  }
}
