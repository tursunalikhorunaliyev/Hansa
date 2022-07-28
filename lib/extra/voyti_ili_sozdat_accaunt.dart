import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/blocs/bloc_flip_login.dart';
import 'package:hansa_app/blocs/login_clicked_bloc.dart';
import 'package:hansa_app/screens/sozdat_accaunt.dart';
import 'package:provider/provider.dart';

class VoytiIliSozdatAccaunt extends StatelessWidget {
  const VoytiIliSozdatAccaunt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
/*     final provider = Provider.of<LoginClickedBloc>(context);
    final providerAnim = Provider.of<LoginAnimBloc>(context);
    final providerFlip = Provider.of<FlipCardController>(context);
 */

    final isTablet = Provider.of<bool>(context);
    final providerFlip = Provider.of<Map<String, FlipCardController>>(context);
    final provider = Provider.of<BlocFlipLogin>(context);
    final providerClicked = Provider.of<LoginClickedBloc>(context);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          spacing: isTablet ? -58.h : -50.h,
          children: [
            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
              onTap: (() {
                providerClicked.sink.add(LoginAction.signin);
                provider.sink.add(true);
                providerFlip['login']!.toggleCard();
              }),
              child: Container(
                height: isTablet ? 50.h : 46.66666666666667.h,
                width: isTablet ? 220.w : 320.3333333333333.w,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(23.33333333333333.r),
                    border:
                        Border.all(color: const Color(0xFFa1b7c2), width: 2.w)),
                child: Center(
                  child: Text(
                    "Создать аккаунт",
                    style: GoogleFonts.montserrat(
                        color: const Color(0xFFa1b7c2),
                        fontSize: isTablet ? 10.sp : 12.66666666666667.sp),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: isTablet ? 25.h : 27.66666666666667.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: isTablet ? 1.h : 1.5.h,
                    width: isTablet ? 96.w : 140.w,
                    color: const Color(0xFFa1b7c2),
                  ),
                  Text("ИЛИ",
                      style: GoogleFonts.montserrat(
                          color: const Color(0xFFa1b7c2),
                          fontSize: isTablet ? 9.sp : 10.sp)),
                  Container(
                    height: isTablet ? 1.h : 1.5.h,
                    width: isTablet ? 96.w : 140.w,
                    color: const Color(0xFFa1b7c2),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 27.66666666666667.h,
            ),
            GestureDetector(
              onTap: () {
                providerClicked.sink.add(LoginAction.login);
                provider.sink.add(true);
                providerFlip['login']!.toggleCard();
              },
              child: Container(
                height: isTablet ? 50.h : 46.66666666666667.h,
                width: isTablet ? 220.w : 320.3333333333333.w,
                decoration: BoxDecoration(
                    color: const Color(0xFFe21a37),
                    borderRadius: BorderRadius.circular(23.33333333333333.r)),
                child: Center(
                  child: Text(
                    "Войти",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: isTablet ? 10.sp : 12.66666666666667.sp),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
