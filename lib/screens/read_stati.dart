// ignore_for_file: must_be_immutable
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/read_stati_model.dart';
import 'package:hansa_app/blocs/read_stati_bloc.dart';
import 'package:hansa_app/read_statie_section/part_indicator.dart';
import 'package:hansa_app/read_statie_section/stati_comment.dart';
import 'package:hansa_app/read_statie_section/top_widget_stati.dart';
import 'package:provider/provider.dart';

class ReadStati extends StatelessWidget {
  ReadStati({Key? key}) : super(key: key);

  final ScrollController listViewController =
      ScrollController(keepScrollOffset: true);

  final Image iconImage = Image.asset(
    "assets/iconStati.png",
    width: 30.33333333333333,
    height: 30.33333333333333,
  );

  final Text toptext = Text(
    """Работая над новой линейкой стиральных машин, мы отталкивались от двух параметров – как сделать бытовую технику максимально функциональной и стильной и при этом доступной большому количеству покупателей? 

В процессе поиска ответа на этот вопрос было найдено оптимальное решение - сохранить самые необходимые характеристики базовых моделей и обновить дизайн. Так мы получили качественный продукт, который сочетает в себе все самое лучшее из стиральных машин Hansa и дизайн, отражающий последние тренды бытовой техники.""",
    style: GoogleFonts.montserrat(
      color: const Color(0xFF0e0b0b),
      fontSize: 12.33333333333333,
    ),
  );

  final Text bottomtext = Text(
    """Лаконичные линии, мягкая форма крышки люка и стильный интерфейс – все это делает линейку Ultimate по-настоящему универсальным вариантом для любого интерьера.

Но, конечно же, самое главное – внутри, а это: """,
    style: GoogleFonts.montserrat(
      color: const Color(0xFF0e0b0b),
      fontSize: 12.33333333333333,
    ),
  );

  final Text programmiyigirmauch = Text(
    """23 программы""",
    style: GoogleFonts.montserrat(
      color: const Color(0xFF0e0b0b),
      fontWeight: FontWeight.bold,
      fontSize: 16.66666666666667,
    ),
  );

  final Text textyigirmauchpasi = Text(
    """Работая над новой линейкой стиральных машин, мы отталкивались от двух параметров – как сделать бытовую технику максимально функциональной и стильной и при этом доступной большому количеству покупателей?

В процессе поиска ответа на этот вопрос было найдено оптимальное решение - сохранить самые необходимые характеристики базовых моделей и обновить дизайн. Так мы получили качественный продукт, который сочетает в себе все самое лучшее из стиральных машин Hansa и дизайн, отражающий последние тренды бытовой техники.""",
    style: GoogleFonts.montserrat(
      color: const Color(0xFF0e0b0b),
      fontSize: 12.33333333333333,
    ),
  );

  double positionDouble = 240.6666666666667;

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<String>(context);
    final url = Provider.of<dynamic>(context);
    final bloc = ReadStatiBLoC(token, url);
    return Expanded(
      child: Stack(
        children: [
          Column(
            children: [
              PartIndicator(icon: iconImage),
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5.333333333333333),
                      topRight: Radius.circular(5.333333333333333)),
                  child: Image.asset(
                    "assets/photoStati.png",
                  )),
            ],
          ),
          SingleChildScrollView(
            controller: listViewController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(
              left: 12.33333333333333,
              right: 12.33333333333333,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: positionDouble,
                  width: double.infinity,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(3),
                          topRight: Radius.circular(3)),
                      color: const Color(0xFFe9e9e9).withOpacity(.9)),
                  height: 7,
                  width: double.infinity,
                ),
                Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.333333333333333),
                            topRight: Radius.circular(5.333333333333333)),
                        color: Color(0xFFffffff)),
                    child: Wrap(
                      children: [
                        StreamBuilder<ReadStatiModel>(
                            stream: bloc.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return HtmlElementView(
                                    viewType: snapshot.data!.article.read.body);
                              } else {
                                bloc.eventSink.add(ReadStatiAction.show);
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            })
                        /* Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Flex(
                              direction: Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "5 новинок из линейки",
                                  style: GoogleFonts.montserrat(
                                      color: const Color(0xFF272624),
                                      fontSize: 20.66666666666667,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "стиральных машин Ultimate",
                                  style: GoogleFonts.montserrat(
                                      color: const Color(0xFF272624),
                                      fontSize: 20.66666666666667,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFffba00),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFffba00),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFffba00),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFffba00),
                                    ),
                                    Icon(
                                      Icons.star_border_purple500_sharp,
                                      color: Color(0xFFffba00),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Flex(
                                  direction: Axis.vertical,
                                  children: [
                                    toptext,
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Image.asset(
                                        "assets/RectangleImageStati.png"),
                                    bottomtext,
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: programmiyigirmauch),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    textyigirmauchpasi,
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 54.66666666666667,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFffffff),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(.3),
                                                blurRadius: 30,
                                                offset: const Offset(3, 7))
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height: 32.22333333333333,
                                            width: 82.40333333333333,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        11.66666666666667),
                                                color: const Color(0xFFe21a37)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "4.5",
                                                  style: GoogleFonts.montserrat(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  size: 14,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "Коментариев  929       |",
                                            style: GoogleFonts.montserrat(
                                              color: const Color(0xFF777777),
                                              fontSize: 13.81,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 46.03666666666667,
                                            width: 46.03666666666667,
                                            child: Image.asset(
                                              "assets/imageLAB.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 19.33333333333333,
                                    ),
                                    const StatiComment(),
                                    const SizedBox(
                                      height: 19.33333333333333,
                                    ),
                                    const StatiComment(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          Text(
                                            "#",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "Написать комментарий",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.66666666666667,
                                    ),
                                    Container(
                                      height: 138,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFffffff),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(.3),
                                                blurRadius: 7,
                                                offset: const Offset(0, 8))
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextField(
                                          maxLines: 7,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  "Интересно а почему именн...",
                                              hintStyle: GoogleFonts.montserrat(
                                                  fontSize: 12.66666666666667,
                                                  color:
                                                      const Color(0xFF919191))),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 300,
                                    )
                                  ],
                                ),
                              ]),
                        ), */
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
