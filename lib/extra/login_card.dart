import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_services/login_api.dart';
import 'package:hansa_app/blocs/bloc_empty_sobshit.dart';
import 'package:hansa_app/blocs/bloc_error_text.dart';
import 'package:hansa_app/blocs/navigator_bloc.dart';
import 'package:hansa_app/blocs/progress_button_animation_bloc.dart';
import 'package:hansa_app/drawer_widgets/toggle_switcher.dart';
import 'package:hansa_app/providers/provider_for_flipping/flip_login_provider.dart';
import 'package:hansa_app/providers/providers_for_login/password_visibility_provider.dart';
import 'package:hansa_app/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class LoginCard extends StatefulWidget {
  const LoginCard({Key? key}) : super(key: key);

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final usernameController =
      TextEditingController(text: "umarnematovv98@gmail.com");

  final passwordController = TextEditingController(text: "981755");
  final textFieldController = TextEditingController();
  final switchTextEditingController = TextEditingController();
  final pagerBloc = NavigatorBloC();
  final progressButtonBLoC = ProgressButtonAnmationBLoC();
  final blocText = BlocErrorText();
  @override
  void initState() {
    pagerBloc.stream.listen((event) {
      if (event[2]) {
        goToWelcome(event[3]);
        print("object");
      } else {
        showSnac();
        print("NO object");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final flipLoginProvider = Provider.of<FlipLoginProvider>(context);
    final isTablet = Provider.of<bool>(context);
    final flip = Provider.of<Map<String, FlipCardController>>(context);
    final blocEmptySobshit = BlocEmptySobshit();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Padding(
          padding: EdgeInsets.only(top: isTablet ? 103.h : 25.h),
          child: Center(
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.r)),
                  width: isTablet ? 230.w : 346.w,
                  height: isTablet ? 450.h : 432.h,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 7.h, right: 8.w),
                            child: InkWell(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                flipLoginProvider.changeIsClosed(false);
                                log(flipLoginProvider.getIsClosed.toString());
                                flip['login']!.toggleCard();
                              },
                              child: Icon(
                                Icons.close_rounded,
                                size: isTablet ? 18.sp : 24.sp,
                                color: const Color(0xff8c8c8b),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: Text('Вход в аккаунт',
                            style: GoogleFonts.montserrat(
                                fontSize: isTablet ? 18.sp : 24.sp,
                                fontWeight: FontWeight.w500)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: isTablet ? 16.w : 24.w,
                            right: isTablet ? 16.w : 24.w,
                            top: isTablet ? 25.h : 30.h),
                        child: TextField(
                          controller: usernameController,
                          style: TextStyle(fontSize: isTablet ? 18 : null),
                          decoration: InputDecoration(
                              hintText: 'Ваш e-mail',
                              hintStyle: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xffa1b7c2),
                              ),
                              suffixIcon: const Icon(
                                Icons.done,
                                color: Color(0xffa1b7c2),
                              ),
                              prefixIcon: const Icon(
                                CupertinoIcons.person_fill,
                                color: Color(0xffa2b8c3),
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: isTablet ? 16.w : 24.w,
                            left: isTablet ? 16.w : 24.w,
                            top: isTablet ? 20.h : 15.h),
                        child: Consumer<PasswordVisibilityProvider>(
                            builder: (context, value, child) {
                          return TextField(
                            controller: passwordController,
                            style: TextStyle(fontSize: isTablet ? 18 : null),
                            obscureText: (!value.getVisibility),
                            decoration: InputDecoration(
                                hintText: 'Ваш пароль',
                                hintStyle: GoogleFonts.montserrat(
                                  color: const Color(0xffa1b7c2),
                                  fontWeight: FontWeight.w500,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    value.changeVisibility();
                                  },
                                  child: Icon(
                                    !value.getVisibility
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: const Color(0xffa1b7c2),
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.key,
                                  color: Color(0xffa2b8c3),
                                )),
                          );
                        }),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: isTablet ? 20.w : 22.w),
                              child: Text(
                                ' Не выходить из приложения',
                                style: GoogleFonts.montserrat(
                                    color: const Color(0xffa1b7c2),
                                    fontWeight: FontWeight.w500,
                                    fontSize: isTablet ? 9.sp : 12.sp),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: isTablet ? 25.w : 70.w),
                                child: MultiProvider(
                                  providers: [
                                    Provider(create: (context) => ""),
                                    Provider(
                                        create: (context) =>
                                            switchTextEditingController),
                                  ],
                                  child: ToggleSwitch(
                                    colorContainer: Colors.grey[300],
                                    colorCircle: Colors.green[600],
                                    tickerSize: isTablet ? 15.sp : 21.sp,
                                    handlerWidth: isTablet ? 30.w : 40.w,
                                    handlerHeight: isTablet ? 12.h : 12.h,
                                    onButton: () {},
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                            bottom: isTablet ? 35.h : 23.h,
                          ),
                          child: StreamBuilder<bool>(
                            stream: progressButtonBLoC.stream,
                            initialData: false,
                            builder: (context, snapshot) {
                              return GestureDetector(
                                onTap: () async {
                                  bool netCheck = false;
                                  try {
                                    final response =
                                        await InternetAddress.lookup(
                                            'www.example.com');

                                    if (response.isNotEmpty) {
                                      setState(() {
                                        netCheck = true;
                                      });
                                    }
                                  } catch (xatoyuuu) {
                                    setState(() {
                                      netCheck = false;
                                    });
                                    if (kDebugMode) {
                                      print(xatoyuuu);
                                    }
                                  }

                                  if (netCheck) {
                                    log("sstatus 200");
                                    progressButtonBLoC.sink.add(true);
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    List isCorrectList = await LoginAction(
                                            username: usernameController.text,
                                            password: passwordController.text,
                                            isSaved: switchTextEditingController
                                                    .text ==
                                                "1")
                                        .sendRequest();

                                    pagerBloc.sink.add(isCorrectList);
                                  } else {
                                    log("status 400");
                                    const snackBar = SnackBar(
                                      content: Text('Yay! A SnackBar!'),
                                      backgroundColor: Colors.red,
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    progressButtonBLoC.sink.add(false);
                                  }
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  alignment: Alignment.center,
                                  width: isTablet
                                      ? 210.w
                                      : snapshot.data!
                                          ? 46.w
                                          : 318.w,
                                  height: isTablet ? 48.h : 46.h,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5.r,
                                          blurRadius: 7.r,
                                          offset: Offset(0.w,
                                              15.h), // changes position of shadow
                                        ),
                                      ],
                                      color: const Color(0xffe21a37),
                                      borderRadius:
                                          BorderRadius.circular(23.r)),
                                  child: snapshot.data!
                                      ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          'Войти',
                                          style: GoogleFonts.montserrat(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  isTablet ? 10.sp : 12.sp),
                                        ),
                                ),
                              );
                            },
                          )),
                      Padding(
                        padding: EdgeInsets.only(bottom: 36.h),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                textFieldController.text = "";
                                return Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.all(30),
                                      height: 330,
                                      width: 400,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFf2f2f2),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        children: [
                                          Image.asset("assets/tepaLogo.png"),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          StreamBuilder<bool>(
                                              initialData: false,
                                              stream:
                                                  blocEmptySobshit.dataStream,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Material(
                                                    child: SizedBox(
                                                      height: 40,
                                                      child: TextField(
                                                        onChanged: (value) {
                                                          blocEmptySobshit
                                                              .dataSink
                                                              .add(false);
                                                        },
                                                        controller:
                                                            textFieldController,
                                                        textAlign:
                                                            TextAlign.left,
                                                        decoration: InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    4),
                                                            hintText: "E-mail",
                                                            hintStyle: TextStyle(
                                                                color: Color(
                                                                    0xFFa0a0a0),
                                                                fontSize: 14),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: snapshot.data ==
                                                                            true
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .black)),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: snapshot.data ==
                                                                            true
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .black))),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return SizedBox();
                                                }
                                              }),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          StreamBuilder<String>(
                                              stream: blocText.dataStream,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Visibility(
                                                          visible: snapshot
                                                                  .data!
                                                                  .contains(
                                                                      "Письмо")
                                                              ? true
                                                              : false,
                                                          child: Icon(
                                                            Icons.check,
                                                            color: Color(
                                                                0xFF25b049),
                                                          )),
                                                      Text(
                                                        snapshot.data!,
                                                        style: TextStyle(
                                                            color: snapshot
                                                                    .data!
                                                                    .contains(
                                                                        "Письмо")
                                                                ? Color(
                                                                    0xFF25b049)
                                                                : Color(
                                                                    0xFFe21a37)),
                                                      ),
                                                    ],
                                                  );
                                                } else {
                                                  return SizedBox();
                                                }
                                              }),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (textFieldController
                                                  .text.isNotEmpty) {
                                                getData(textFieldController
                                                        .text)
                                                    .then((value) {
                                                  if (value["status"] == true) {
                                                    blocText.dataSink
                                                        .add(value["data"]);
                                                    print(value["data"]);
                                                  }
                                                  if (value["status"] ==
                                                      false) {
                                                    blocText.dataSink.add(
                                                        value["message"]
                                                            ["email"][0]);
                                                    print(value["message"]
                                                            ["email"][0] +
                                                        " bazaaaa");
                                                  }
                                                });
                                              }
                                              if (textFieldController
                                                  .text.isEmpty) {
                                                blocEmptySobshit.dataSink
                                                    .add(true);
                                              }
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              width: 250,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFfb002b),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                "Отправить",
                                                style: TextStyle(
                                                  color: Color(0xFFf2f2f2),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            "При возникновении проблем просьба обращаться в службу поддержки. Почта:",
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "support@hansa-lab.ru",
                                            style: TextStyle(
                                                color: Color(0xFFfb002b),
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            'Забыли пароль?',
                            style: GoogleFonts.montserrat(
                                fontSize: isTablet ? 10.sp : 12.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xffa1b7c2)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: isTablet ? -60.h : -60.h,
                  child: Image.asset(
                    isTablet ? 'assets/tabletTumLogo.png' : 'assets/Logo.png',
                    height: 134.h,
                    width: 134.w,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showSnac() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Неверный E-mail или пароль"),
      backgroundColor: Colors.red,
    ));
  }

  goToWelcome(token) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Provider<String>(
            create: (context) => token.toString(),
            child: const WelcomeScreen()),
      ),
    );
  }

  Future<Map<String, dynamic>> getData(String text) async {
    http.Response response = await http.post(
        Uri.parse("http://hansa-lab.ru/api/auth/reset-password"),
        body: {"email": text});
    print(response.statusCode);
    print(response.body);
    print("Bloc Zabili Parol Napisat ----------------------------------");

    return jsonDecode(response.body);
  }
}
