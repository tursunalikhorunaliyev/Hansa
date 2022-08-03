import 'package:flutter/material.dart';
import 'package:hansa_app/api_models.dart/stati_model.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/blocs/stati_bloc.dart';
import 'package:hansa_app/extra/custom_clip_item.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:provider/provider.dart';

class Stati extends StatefulWidget {
  const Stati({Key? key}) : super(key: key);

  @override
  State<Stati> createState() => _StatiState();
}

class _StatiState extends State<Stati> {
  @override
  Widget build(BuildContext context) {
    final token = Provider.of<String>(context);
    final bloc = StatiBLoC(token);
    final statiBloCProvider = Provider.of<MenuEventsBloC>(context);
    return Expanded(
      child: Column(
        children: [
          const CustomTitle(
            imagePath: "assets/stati_title.png",
            title: "Статьи",
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: StreamBuilder<StatiModel>(
                  stream: bloc.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: List.generate(
                          snapshot.data!.list.list.length,
                          (index) => CustomClipItem(
                            backgroundColor: const Color(0xffffffff),
                            buttonTextColor: const Color(0xffffffff),
                            buttonColor: const Color(0xffe21a37),
                            titleColor: const Color(0xff272624),
                            title: snapshot.data!.list.list[index].title,
                            buttonText: "Читать",
                            onTap: () {
                              statiBloCProvider.eventSink
                                  .add(MenuActions.chitatStati);
                            },
                          ),
                        ),
                      );
                    } else {
                      bloc.eventSink.add(StatiAction.show);
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
