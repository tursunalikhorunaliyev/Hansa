import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_services/login_api.dart';
import 'package:hansa_app/blocs/bloc.dart';
import 'package:hansa_app/blocs/bloc_flip_login.dart';
import 'package:hansa_app/blocs/navigator_bloc.dart';
import 'package:hansa_app/drawer_widgets/toggle_switcher.dart';
import 'package:hansa_app/screens/welcome_screen.dart';
import 'package:hansa_app/blocs/toggle_switcher_bloc.dart';
import 'package:provider/provider.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({Key? key}) : super(key: key);

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final usernameController =
      TextEditingController(text: "shahzodbekkomilov2005@gmail.com");

  final passwordController = TextEditingController(text: "809656");

  final pagerBloc = NavigatorBloC();
  @override
  void initState() {
    pagerBloc.stream.listen((event) {
      if (event[2]) {
        goToWelcome(event[1]);
      } else {
        showSnac();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    final flip = Provider.of<Map<String, FlipCardController>>(context);
    final bloc = BlocAnim();
    final provider = Provider.of<BlocFlipLogin>(context);
    final providerSwitcher = Provider.of<ToggleSwitcherBloc>(context);
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
                                provider.sink.add(false);
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
                        child: StreamBuilder<bool>(
                            stream: bloc.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return TextField(
                                  controller: passwordController,
                                  obscureText: (snapshot.data!),
                                  decoration: InputDecoration(
                                      hintText: 'Ваш пароль',
                                      hintStyle: GoogleFonts.montserrat(
                                        color: const Color(0xffa1b7c2),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          if (snapshot.data!) {
                                            bloc.sink.add(false);
                                          } else {
                                            bloc.sink.add(true);
                                          }
                                        },
                                        child: Icon(
                                          snapshot.data!
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
                              } else {
                                bloc.sink.add(true);
                                return const SizedBox();
                              }
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
                                child: ToggleSwitch(
                                  colorContainer: Colors.grey[300],
                                  colorCircle: Colors.green[600],
                                  tickerSize: isTablet ? 15.sp : 21.sp,
                                  handlerWidth: isTablet ? 30.w : 40.w,
                                  handlerHeight: isTablet ? 12.h : 12.h,
                                  onButton: () {},
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: isTablet ? 35.h : 23.h,
                        ),
                        child: StreamBuilder<bool>(
                            initialData: false,
                            stream: providerSwitcher.dataStream,
                            builder: (context, snapshot) {
                              return GestureDetector(
                                onTap: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  List isCorrectList = await LoginAction(
                                          username: usernameController.text,
                                          password: passwordController.text,
                                          isSaved: snapshot.data!)
                                      .sendRequest();

                                  pagerBloc.sink.add(isCorrectList);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: isTablet ? 210.w : 318.w,
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
                                  child: Text(
                                    'Войти',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: isTablet ? 10.sp : 12.sp),
                                  ),
                                ),
                              );
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 36.h),
                        child: Text(
                          'Забыли пароль?',
                          style: GoogleFonts.montserrat(
                              fontSize: isTablet ? 10.sp : 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffa1b7c2)),
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
}
