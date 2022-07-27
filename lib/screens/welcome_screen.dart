import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/blocs/bloc_play_video.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/extra/glavniy_menyu.dart';
import 'package:hansa_app/extra/top_video_widget.dart';
import 'package:hansa_app/extra/ui_changer.dart';
import 'package:hansa_app/providers/stack_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Salom");
    final playProvider = Provider.of<BlocPlayVideo>(context);
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    final isTablet = Provider.of<bool>(context);
    final menuProvider = Provider.of<MenuEventsBloC>(context);
    final stackProvider  = Provider.of<StackProvider>(context);
    return Provider(
      create: (context) => scaffoldKey,
      child: WillPopScope(
          onWillPop: () async {
            menuProvider.eventSink.add(stackProvider.list.last);
            stackProvider.removeStack();
            return false;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: const GlavniyMenyu(),
            key: scaffoldKey,
            bottomNavigationBar: StreamBuilder<MenuActions>(
                initialData: MenuActions.welcome,
                stream: menuProvider.eventStream,
                builder: (context, snapshot) {
                  return (snapshot.data! == MenuActions.chitatStati)
                      ? const SizedBox()
                      : SizedBox(
                          height: 70.h,
                          child: Container(
                            color: const Color(0xffffffff),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  CupertinoIcons.chevron_left_circle,
                                  size: isTablet ? 13.sp : 25.sp,
                                  color: const Color(0xffa5a5ae),
                                ),
                                Icon(
                                  CupertinoIcons.search,
                                  size: isTablet ? 13.sp : 25.sp,
                                  color: const Color(0xffa5a5ae),
                                ),
                                Icon(
                                  CupertinoIcons.heart,
                                  size: isTablet ? 13.sp : 25.sp,
                                  color: const Color(0xffa5a5ae),
                                ),
                                Icon(
                                  CupertinoIcons.person,
                                  size: isTablet ? 13.sp : 25.sp,
                                  color: const Color(0xffa5a5ae),
                                ),
                                Icon(
                                  CupertinoIcons.home,
                                  size: isTablet ? 13.sp : 25.sp,
                                  color: const Color(0xffa5a5ae),
                                ),
                              ],
                            ),
                          ),
                        );
                }),
            backgroundColor: const Color(0xffeaeaea),
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      color: const Color(0xffffffff),
                      width: 395.w,
                      height: 100.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              scaffoldKey.currentState!.openDrawer();
                            },
                            child: Icon(
                              Icons.menu,
                              color: const Color(0xff444444),
                              size: isTablet ? 13.sp : 21.sp,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: Image.asset(
                                  'assets/tepaLogo.png',
                                  height: 25.h,
                                  width: 214.w,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h),
                                child: Row(
                                  children: [
                                    Text(
                                      '#Увидимся',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'нa',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'кухне',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Icon(
                            CupertinoIcons.search,
                            size: isTablet ? 13.sp : 21.sp,
                          ),
                        ],
                      ),
                    ),
                    const UIChanger(),
                  ],
                ),
                StreamBuilder<bool>(
                  stream: playProvider.stream,
                  initialData: false,
                  builder: (context, snapshot) {
                    return AnimatedScale(
                      duration: const Duration(milliseconds: 300),
                      scale: snapshot.data! ? 1 : 0,
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: TopVideoWidget(
                        videoController: VideoPlayerController.network(
                          "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }
}
