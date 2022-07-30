import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/obucheniya_model_api.dart';
import 'package:hansa_app/blocs/bloc_obucheniya.dart';
import 'package:hansa_app/extra/event_cards.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ObucheniyaWidget extends StatelessWidget {
  const ObucheniyaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);

    final token = Provider.of<String>(context);
    final bloc = BlocObucheniya(token);
    bloc.eventSink.add(ObucheniyaEnum.obucheniya);
    List<Widget> data() {
      List<Widget> list = [];
      for (int i = 0; i < 5; i++) {
        list.add(
          const EventCards(
            buttonColor: Color(0xffff163e),
            buttonText: 'smoterer',
            day: 'asdasd',
            month: '2',
            isDate: false,
            isFavourite: false,
            title: 'Обучающий материал для сотрудников Леруа Мерлен',
            url:
                'https://thumbs.dreamstime.com/b/happy-family-having-roast-chicken-dinner-table-18044089.jpg',
            isFavourite: false,
          ),
        ); //add any Widget in place of Text("Index $i")
      }
      return list; // all widget added now retrun the list here
    }

    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
            children: List.generate(
          1,
          (index) {
            return Column(
              children: [
                StickyHeader(
                  header: Container(
                    color: const Color(0xffeaeaea),
                    child: Padding(
                      padding: EdgeInsets.only(top: 9.h, bottom: 5.h),
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
                              'assets/Обучение.png',
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
                            'Обучающие материалы ',
                            style: GoogleFonts.montserrat(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff272624)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  content: isTablet
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Row(),
                                Column(
                                  children: data(),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(),
                                Column(
                                  children: data(),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Row(),
                            Column(children: [
                              StreamBuilder<ObucheniyaModel>(
                                  stream: bloc.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return EventCards(
                                        isFavourite: snapshot.data!.data
                                            .listGuides.list[index].isFavourite,
                                        buttonColor: Color(0xffff163e),
                                        buttonText: 'smoterer',
                                        day: 'asdasd',
                                        month: '2',
                                        isDate: false,
                                        title: snapshot.data!.data.listGuides
                                            .list[index].title,
                                        url: snapshot.data!.data.listGuides
                                            .list[index].picture_link,
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  }),
                            ]),
                          ],
                        ),
                ),
                StickyHeader(
                  header: Container(
                    color: const Color(0xffeaeaea),
                    child: Padding(
                      padding: EdgeInsets.only(top: 9.h, bottom: 5.h),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 70.w,
                            height: 42.h,
                            decoration: BoxDecoration(
                                color: const Color(0XFFff163e),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(21.sp),
                                    bottomRight: Radius.circular(21.sp))),
                            child: Image.asset(
                              'assets/Архив.png',
                              height: 30.h,
                              width: 30.w,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Text(
                              '#',
                              style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xffff163e)),
                            ),
                          ),
                          Text(
                            'Архив',
                            style: GoogleFonts.montserrat(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff272624)),
                          )
                        ],
                      ),
                    ),
                  ),
                  content: isTablet
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Row(),
                                Column(
                                  children: data(),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(),
                                Column(
                                  children: data(),
                                )
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Row(),
                            Column(
                              children: [
                                StreamBuilder<ObucheniyaModel>(
                                    stream: bloc.stream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return EventCards(
                                          isFavourite: snapshot
                                              .data!
                                              .data
                                              .listArchiveGuides
                                              .list[index]
                                              .isFavourite,
                                          buttonColor: const Color(0xffff163e),
                                          buttonText: 'smoterer',
                                          day: 'asdasd',
                                          month: '2',
                                          isDate: false,
                                          title: snapshot
                                              .data!
                                              .data
                                              .listArchiveGuides
                                              .list[index]
                                              .title,
                                          url: snapshot
                                              .data!
                                              .data
                                              .listArchiveGuides
                                              .list[index]
                                              .picture_link,
                                        );
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    })
                              ],
                            )
                          ],
                        ),
                ),
              ],
            );
          },
        )),
      ),
    );
  }
}
