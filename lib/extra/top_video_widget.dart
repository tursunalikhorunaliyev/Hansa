import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/blocs/bloc_play_video.dart';
import 'package:hansa_app/extra/black_custom_title.dart';
import 'package:hansa_app/extra/custom_black_appbar.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:hansa_app/training_section/custom_treningi_video.dart';
import 'package:provider/provider.dart';

class TopVideoWidget extends StatefulWidget {
  const TopVideoWidget({Key? key}) : super(key: key);

  @override
  State<TopVideoWidget> createState() => _TopVideoWidgetState();
}

class _TopVideoWidgetState extends State<TopVideoWidget> {
  @override
  Widget build(BuildContext context) {
    final playProvider = Provider.of<BlocPlayVideo>(context);
    return SafeArea(
      child: Stack(
        children: [
          Container(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(.9),
                  Colors.black.withOpacity(.9),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              playProvider.sink.add(false); 
            },
          ),
          Column(
            children: [
              const CustomBlackAppBar(),
              Row(
                children: const [
                  BlackCustomTitle(
                    imagePath: "assets/video_title.png",
                    title: "Видео",
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 32),
                        child: PhysicalModel(
                          shadowColor: Colors.grey.withOpacity(.5),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(64),
                          elevation: 5,
                          child: GestureDetector(
                            onTap: () {},
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(64),
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                constraints: const BoxConstraints(
                                  minWidth: 90,
                                ),
                                color: const Color(0xffff163e),
                                child: Center(
                                  child: Text(
                                    "Открыть раздел",
                                    style: GoogleFonts.montserrat(
                                      color: const Color(0xffffffff),
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                 const Padding(
                    padding:  EdgeInsets.only(top: 13),
                    child:  CustomTreningiVideo(),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
