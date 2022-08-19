import 'package:flutter/material.dart';
import 'package:hansa_app/api_models.dart/read_stati_model.dart';
import 'package:hansa_app/api_models.dart/stati_model.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/blocs/read_stati_bloc.dart';
import 'package:hansa_app/blocs/stati_bloc.dart';
import 'package:hansa_app/classes/send_link.dart';
import 'package:hansa_app/extra/custom_clip_item.dart';
import 'package:hansa_app/extra/custom_tablet_stati_item.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:hansa_app/providers/stati_id_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Stati extends StatefulWidget {
  const Stati({Key? key}) : super(key: key);

  @override
  State<Stati> createState() => _StatiState();
}

class _StatiState extends State<Stati> {
  ReadStatiBLoC readStati = ReadStatiBLoC();
  final bloc = StatiBLoC();
  @override
  void dispose() {
    readStati.controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerToken = Provider.of<String>(context);
    final isTablet = Provider.of<bool>(context);
    final providerReadStati = Provider.of<ReadStatiBLoC>(context);
    final statiBloCProvider = Provider.of<MenuEventsBloC>(context);
    final statiIdProvider = Provider.of<StatiIdProvider>(context);
    final providerSendLink = Provider.of<SendLink>(context);
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder<StatiModel>(
            future: bloc.getStati(providerToken),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return isTablet
                    ? Column(
                        children: [
                          const CustomTitle(
                            imagePath: "assets/stati_title.png",
                            title: "Статьи",
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 11.w),
                            child: GridView(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 10 / 3.3),
                              children: List.generate(
                                snapshot.data!.list.list.length,
                                (index) => CustomStatiTabletItem(
                                  backgroundColor: const Color(0xffffffff),
                                  buttonTextColor: const Color(0xffffffff),
                                  buttonColor: const Color(0xffe21a37),
                                  titleColor: const Color(0xff272624),
                                  title: snapshot.data!.list.list[index].title,
                                  buttonText: "Читать",
                                  onTap: () async {
                                    providerSendLink.setLink(
                                        snapshot.data!.list.list[index].link);
                                    statiBloCProvider.eventSink
                                        .add(MenuActions.chitatStati);
                                    /* statiBloCProvider.eventSink
                                      .add(MenuActions.chitatStati);
                                  ReadStatiModel model =
                                      await readStati.getReadStati(
                                          providerToken,
                                          snapshot.data!.list.list[index].link);

                                  providerReadStati.sink.add(model); */
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const CustomTitle(
                            imagePath: "assets/stati_title.png",
                            title: "Статьи",
                          ),
                          Column(
                            children: List.generate(
                              snapshot.data!.list.list.length,
                              (index) => CustomClipItem(
                                backgroundColor: const Color(0xffffffff),
                                buttonTextColor: const Color(0xffffffff),
                                buttonColor: const Color(0xffe21a37),
                                titleColor: const Color(0xff272624),
                                title: snapshot.data!.list.list[index].title,
                                buttonText: "Читать",
                                onTap: () async {
                                  providerSendLink.setLink(
                                      snapshot.data!.list.list[index].link);
                                  statiBloCProvider.eventSink
                                      .add(MenuActions.chitatStati);
                                  /* statiBloCProvider.eventSink
                                      .add(MenuActions.chitatStati);
                                  ReadStatiModel model =
                                      await readStati.getReadStati(
                                          providerToken,
                                          snapshot.data!.list.list[index].link);

                                  providerReadStati.sink.add(model); */
                                },
                              ),
                            ),
                          ),
                        ],
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
