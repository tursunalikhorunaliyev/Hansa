import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hansa_app/blocs/bloc_play_video.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/extra/glavniy_menyu.dart';
import 'package:hansa_app/extra/hamburger.dart';
import 'package:hansa_app/extra/top_video_widget.dart';
import 'package:hansa_app/extra/ui_changer.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final playProvider = Provider.of<BlocPlayVideo>(context);
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    final isTablet = Provider.of<bool>(context);
    final menuProvider = Provider.of<MenuEventsBloC>(context);
    return WillPopScope(
      onWillPop: () async {
        if (menuProvider.list.length > 1) {
          menuProvider.eventSink
              .add(menuProvider.list.elementAt(menuProvider.list.length - 2));
          menuProvider.list.remove(
              menuProvider.list.elementAt(menuProvider.list.length - 1));
        }
        return false;
      },
      child: Provider(
        create: (context) => scaffoldKey,
        child: Scaffold(
          drawerEnableOpenDragGesture: false,
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
                              InkWell(
                                onTap: () {
                                  if (menuProvider.list.length > 1) {
                                    menuProvider.eventSink.add(menuProvider.list
                                        .elementAt(
                                            menuProvider.list.length - 2));
                                    menuProvider.list.remove(menuProvider.list
                                        .elementAt(
                                            menuProvider.list.length - 1));
                                  }
                                },
                                child: Icon(
                                  CupertinoIcons.chevron_left_circle,
                                  size: isTablet ? 13.sp : 25.sp,
                                  color: const Color(0xffa5a5ae),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  menuProvider.eventSink
                                      .add(MenuActions.welcome);
                                },
                                child: Icon(
                                  CupertinoIcons.home,
                                  size: isTablet ? 13.sp : 25.sp,
                                  color: const Color(0xffa5a5ae),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  scaffoldKey.currentState!.openDrawer();
                                },
                                child: Icon(
                                  CupertinoIcons.heart,
                                  size: isTablet ? 13.sp : 25.sp,
                                  color: const Color(0xffa5a5ae),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  scaffoldKey.currentState!.openDrawer();
                                },
                                child: Icon(
                                  CupertinoIcons.person,
                                  size: isTablet ? 13.sp : 25.sp,
                                  color: const Color(0xffa5a5ae),
                                ),
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
                    child: Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                scaffoldKey.currentState!.openDrawer();
                              },
                              icon: const HamburgerIcon()),
                          InkWell(
                            onTap: () {
                              menuProvider.eventSink.add(MenuActions.welcome);
                            },
                            child: Image.asset(
                              'assets/tepaLogo.png',
                              height: 25.h,
                              width: 214.w,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.search,
                            size: isTablet ? 13.sp : 21.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const UIChanger(),
                ],
              ),
              StreamBuilder<List>(
                stream: playProvider.stream,
                initialData: const [false, "", "", false],
                builder: (context, snapshot) {
                  print(snapshot.data!);
                  if (snapshot.data![1].toString().isEmpty) {
                    return const SizedBox();
                  } else {
                    return AnimatedScale(
                      duration: const Duration(milliseconds: 300),
                      scale: snapshot.data![0] ? 1 : 0,
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: TopVideoWidget(
                        url: snapshot.data![1],
                        title: snapshot.data![2],
                        visible: snapshot.data!.last,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
