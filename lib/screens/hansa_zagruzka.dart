import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hansa_app/blocs/bloc_flip_login.dart';
import 'package:hansa_app/blocs/login_anim_bloc.dart';
import 'package:hansa_app/blocs/login_clicked_bloc.dart';
import 'package:hansa_app/extra/full_registr.dart';
import 'package:hansa_app/extra/hansa_entry_widget.dart';
import 'package:hansa_app/extra/login_card.dart';
import 'package:hansa_app/extra/regis_widget.dart';
import 'package:provider/provider.dart';

class HansaZagruzka extends StatelessWidget {
  const HansaZagruzka({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    final loginAnimBloc = LoginAnimBloc();
    final flipBloc = BlocFlipLogin();
    final loginClickedBloc = Provider.of<LoginClickedBloc>(context);
    final flipCardController =
        Provider.of<Map<String, FlipCardController>>(context);
    final providerClicked = Provider.of<LoginClickedBloc>(context);
    return MultiProvider(
      providers: [
        Provider<LoginAnimBloc>(
          create: (context) => loginAnimBloc,
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xff31363c),
        body: Stack(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  isTablet ? "assets/tabletRasm.png" : "assets/Layer 1701.png",
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
                Container(
                  height: 2,
                  color: const Color(0xff31363c),
                ),
              ],
            ),
            StreamBuilder<bool>(
                stream: flipBloc.stream,
                initialData: false,
                builder: (context, snapshot) {
                  return AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: snapshot.data! ? 1 : 0,
                    curve: Curves.fastOutSlowIn,
                    child: Padding(
                      padding: EdgeInsets.only(top: 300.h),
                      child: Image.asset(
                        isTablet ? "assets/tabletBgRasm.png" : 'assets/bg.png',
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }),
            Provider.value(
              value: providerClicked,
              child: FlipCard(
                controller: flipCardController['login'],
                flipOnTouch: false,
                front: Align(
                  alignment: Alignment.bottomCenter,
                  child: Provider.value(
                    value: flipBloc,
                    child: const HansaEntry(),
                  ),
                ),
                back: StreamBuilder<LoginAction>(
                  stream: loginClickedBloc.stream,
                  initialData: LoginAction.signin,
                  builder: (context, snapshot) {
                    return Center(
                      child: snapshot.data == LoginAction.login
                          ? SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 200),
                                child: Provider.value(
                                  value: flipBloc,
                                  child: const LoginCard(),
                                ),
                              ),
                            )
                          : FlipCard(
                              controller: flipCardController['signin'],
                              flipOnTouch: false,
                              back: const CompleteRegistr(),
                              front: Provider.value(
                                value: flipBloc,
                                child: const FullRegistr(),
                              ),
                            ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
