import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hansa_app/blocs/bloc_flip_login.dart';
import 'package:hansa_app/blocs/login_anim_bloc.dart';
import 'package:hansa_app/blocs/login_clicked_bloc.dart';
import 'package:hansa_app/extra/hansa_entry_widget.dart';
import 'package:hansa_app/extra/login_card.dart';
import 'package:provider/provider.dart';

class HansaZagruzka extends StatelessWidget {
  const HansaZagruzka({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = LoginClickedBloc();
    final isTablet = Provider.of<bool>(context);
    final loginAnimBloc = LoginAnimBloc();
    final flipBloc = BlocFlipLogin();
    GlobalKey<FlipCardState> key = GlobalKey<FlipCardState>();
    return MultiProvider(
      providers: [
        Provider<LoginClickedBloc>(create: (context) => bloc),
        Provider<LoginAnimBloc>(
          create: (context) => loginAnimBloc,
        ),
        Provider<GlobalKey<FlipCardState>>(
          create: (context) => key,
        ),
        Provider<BlocFlipLogin>(
          create: (context) => flipBloc,
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xff31363c),
        body: Stack(
          children: [
            Image.asset(
              isTablet ? "assets/tabletRasm.png" : "assets/Layer 1701.png",
              width: double.infinity,
              //height: 376.h,
              fit: BoxFit.cover,
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
                      padding: EdgeInsets.only(top: 298.h),
                      child: Image.asset(
                        isTablet ? "assets/tabletBgRasm.png" : 'assets/bg.png',
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }),
            FlipCard(
              key: key,
              flipOnTouch: false,
              front: const Align(
                alignment: Alignment.bottomCenter,
                child: HansaEntry(),
              ),
              back: const Center(
                child: SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.only(top: 206),
                  child: LoginCard(),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
