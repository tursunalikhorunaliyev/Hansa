import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/classes/tap_favorite.dart';
import 'package:hansa_app/extra/exit_dialog.dart';
import 'package:hansa_app/extra/glavniy_menyu.dart';
import 'package:hansa_app/extra/hamburger.dart';
import 'package:hansa_app/extra/ui_changer.dart';
import 'package:hansa_app/providers/provider_personal_textFields.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    final providerScaffoldKey = Provider.of<GlobalKey<ScaffoldState>>(context);
    final menuProvider = Provider.of<MenuEventsBloC>(context);
    final providerTapFavorite = Provider.of<TapFavorite>(context);

    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) {
            return const ExitDialog();
          },
        );

        return false;
      },
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        resizeToAvoidBottomInset: false,
        drawer: MultiProvider(providers: [
          Provider(create: (context) => ProviderPersonalTextFields()),
          Provider(create: (context) => providerScaffoldKey)
        ], child: const GlavniyMenyu()),
        key: providerScaffoldKey,
        bottomNavigationBar: StreamBuilder<MenuActions>(
            initialData: MenuActions.welcome,
            stream: menuProvider.eventStream,
            builder: (context, snapshot) {
              return SizedBox(
                height: 58.h,
                child: Container(
                  color: const Color(0xffffffff),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          if (menuProvider.list.length > 1) {
                            menuProvider.eventSink.add(menuProvider.list
                                .elementAt(menuProvider.list.length - 2));
                            menuProvider.list.remove(menuProvider.list
                                .elementAt(menuProvider.list.length - 1));
                          }
                        },
                        child: Icon(
                          CupertinoIcons.chevron_left_circle,
                          size: isTablet ? 20.sp : 25.sp,
                          color: const Color(0xffa5a5ae),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          menuProvider.eventSink.add(MenuActions.welcome);
                        },
                        child: Icon(
                          CupertinoIcons.home,
                          size: isTablet ? 20.sp : 25.sp,
                          color: const Color(0xffa5a5ae),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          providerTapFavorite.setInt(1);
                          log("${providerTapFavorite.getInt} Welcome screen get bool");
                          providerScaffoldKey.currentState!.openDrawer();
                        },
                        child: Icon(
                          CupertinoIcons.heart,
                          size: isTablet ? 20.sp : 25.sp,
                          color: const Color(0xffa5a5ae),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          providerTapFavorite.setInt(2);
                          providerScaffoldKey.currentState!.openDrawer();
                        },
                        child: Icon(
                          CupertinoIcons.person,
                          size: isTablet ? 20.sp : 25.sp,
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
                              providerTapFavorite.setInt(0);
                              providerScaffoldKey.currentState!.openDrawer();
                            },
                            icon: const HamburgerIcon()),
                        InkWell(
                          onTap: () {
                            menuProvider.eventSink.add(MenuActions.welcome);
                          },
                          child: Image.asset(
                            'assets/tepaLogo.png',
                            height: isTablet ? 30.h : 25.h,
                            width: isTablet ? 230.w : 214.w,
                          ),
                        ),
                        Icon(
                          CupertinoIcons.search,
                          size: isTablet ? 19.sp : 21.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                Provider(
                    create: (context) => providerScaffoldKey,
                    child: const UIChanger()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
