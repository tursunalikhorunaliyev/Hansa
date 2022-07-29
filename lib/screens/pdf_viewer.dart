import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/blocs/menu_events_bloc.dart';
import 'package:hansa_app/classes/pdf_bloc.dart';
import 'package:pdfx/pdfx.dart';
import 'package:internet_file/internet_file.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PDFView extends StatefulWidget {
  const PDFView({Key? key}) : super(key: key);

  @override
  State<PDFView> createState() => _PDFViewState();
}

class _PDFViewState extends State<PDFView> {
  final bloc = PDFBLoC();

  @override
  void initState() {
    super.initState();
    bloc.sinkAction.add(ActionBloc.show);
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);
    final menuProvider = Provider.of<MenuEventsBloC>(context);
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

    return Scaffold(
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
        body: SafeArea(
            child: Column(
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
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'нa',
                              style: GoogleFonts.montserrat(
                                  fontSize: 15.sp, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'кухне',
                              style: GoogleFonts.montserrat(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
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
            Padding(
              padding: const EdgeInsets.only(top: 9, bottom: 18),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 70.w,
                    height: 42.h,
                    decoration: const BoxDecoration(
                        color: Color(0XFFff163e),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(21),
                            bottomRight: Radius.circular(21))),
                    child: Image.asset(
                      'assets/pdfIcon.png',
                      height: 30.h,
                      width: 30.w,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text('#',
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xffff163e),
                        )),
                  ),
                  Text(
                    'Презентация',
                    style: GoogleFonts.montserrat(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff272624)),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                height: 562,
                width: 325.6666666666667,
                child: StreamBuilder<String>(
                    stream: bloc.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final document = PdfDocument.openData(
                            InternetFile.get(snapshot.data!));
                        final controller = PdfController(document: document);
                        return Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: PdfView(
                            physics: const BouncingScrollPhysics(),
                            controller: controller,
                            scrollDirection: Axis.vertical,
                            backgroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.333333),
                                border: Border.all(
                                    color: Colors.red,
                                    width: 5,
                                    style: BorderStyle.none)),
                          ),
                        );
                      } else {
                        bloc.sinkAction.add(ActionBloc.show);
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
          ],
        )));
  }
}
