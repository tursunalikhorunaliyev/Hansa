import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/blocs/bloc_play_video.dart';
import 'package:provider/provider.dart';

class CustomVideoListItem extends StatelessWidget {
  const CustomVideoListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playProvider = Provider.of<BlocPlayVideo>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 12, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 155,
          color: Colors.white,
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  playProvider.sink.add(true);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/backgr.png",
                        height: 130,
                        width: 155,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: 130,
                        width: 155,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: const Opacity(
                          opacity: .5,
                          child: Icon(
                            CupertinoIcons.play_circle_fill,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(11),
                child: Text(
                  "Быстрый нагрев в \nиндукционных \nповерхностях Hansa",
                  style: GoogleFonts.montserrat(
                      fontSize: 10,
                      color: const Color(0xff4e5258),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
