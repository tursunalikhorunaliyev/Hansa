import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hansa_app/blocs/bloc_change_profile.dart';
import 'package:hansa_app/blocs/bloc_flip_login.dart';
import 'package:hansa_app/blocs/bloc_sign.dart';
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
    final bloc = LoginClickedBloc();
    final isTablet = Provider.of<bool>(context);
    final loginAnimBloc = LoginAnimBloc();
    final flipBloc = BlocFlipLogin();
    final flipCardController =
        Provider.of<Map<String, FlipCardController>>(context);
    return MultiProvider(
      providers: [
        Provider<LoginClickedBloc>(create: (context) => bloc),
        Provider<LoginAnimBloc>(
          create: (context) => loginAnimBloc,
        ),
        Provider<BlocFlipLogin>(
          create: (context) => flipBloc,
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
            FlipCard(
              controller: flipCardController['login'],
              flipOnTouch: false,
              front: const Align(
                alignment: Alignment.bottomCenter,
                child: HansaEntry(),
              ),
              back: StreamBuilder<LoginAction>(
                  stream: bloc.stream,
                  initialData: LoginAction.signin,
                  builder: (context, snapshot) {
                    return Center(
                      child: snapshot.data == LoginAction.login
                          ? const SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(top: 200),
                                child: LoginCard(),
                              ),
                            )
                          : FlipCard(
                              controller: flipCardController['signin'],
                              flipOnTouch: false,
                              back: const CompleteRegistr(),
                              front: const FullRegistr(),
                            ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
