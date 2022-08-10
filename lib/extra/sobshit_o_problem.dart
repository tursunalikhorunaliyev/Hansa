import 'dart:convert';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/model_o_kompaniya_napisat.dart';
import 'package:hansa_app/blocs/bloc_empty_sobshit.dart';
import 'package:hansa_app/extra/sobshit_o_problem_success.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SobshitOProblem extends StatelessWidget {
  const SobshitOProblem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerToken = Provider.of<String>(context);
    final textFieldController = TextEditingController();
  final blocEmptySobshit = BlocEmptySobshit();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

    return FlipCard(
      key: cardKey,
      flipOnTouch: false,
      front: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * .135),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 57.5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          color: Colors.white,
                          width: 350,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        size: 22,
                                        color: Color(0xff8c8c8b),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 45,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Задать вопрос",
                                    style: GoogleFonts.montserrat(
                                        color: const Color(0xff444444),
                                        fontSize: 24),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  StreamBuilder<bool>(
                                      initialData: false,
                                      stream: blocEmptySobshit.dataStream,
                                      builder: (context, snapshot) {
                                        return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24),
                                            child: TextField(
                                              controller: textFieldController,
                                              maxLines: 5,
                                              cursorColor:
                                                  const Color(0xffa1b7c2),
                                              decoration: InputDecoration(
                                                prefixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 100),
                                                  child: Image.asset(
                                                    "assets/free-icon-maps-and-flags-446099.png",
                                                    scale: 3,
                                                    color: snapshot.data!
                                                        ? const Color(
                                                            0xFFff163e)
                                                        : const Color(
                                                            0xffa1b7c2),
                                                  ),
                                                ),
                                                hintText:
                                                    "Текст вашего сообщения",
                                                hintStyle:
                                                    GoogleFonts.montserrat(
                                                        color: snapshot.data!
                                                            ? const Color(
                                                                0xFFff163e)
                                                            : const Color(
                                                                0xffa1b7c2)),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: snapshot.data!
                                                        ? const Color(
                                                            0xFFff163e)
                                                        : Color(0xffa1b7c2),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: snapshot.data!
                                                        ? const Color(
                                                            0xFFff163e)
                                                        : const Color(
                                                            0xffa1b7c2),
                                                  ),
                                                ),
                                              ),
                                            ));
                                      }),
                                  const SizedBox(
                                    height: 45,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(64),
                                        child: StreamBuilder<bool>(
                                            initialData: false,
                                            stream: blocEmptySobshit.dataStream,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    if (textFieldController
                                                        .text.isNotEmpty) {
                                                      getData(
                                                              providerToken,
                                                              textFieldController
                                                                  .text)
                                                          .then((value) {
                                                        if (value.status) {
                                                          cardKey.currentState!
                                                              .toggleCard();
                                                        }
                                                      });

                                                      blocEmptySobshit.dataSink
                                                          .add(false);
                                                    } else {
                                                      blocEmptySobshit.dataSink
                                                          .add(true);
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 47,
                                                    color:
                                                        const Color(0xff25b049),
                                                    child: Center(
                                                      child: Text(
                                                        "Отправить сообщение",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 13,
                                                          color: const Color(
                                                              0xffffffff),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Text("Ошибка простояta",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 20));
                                              }
                                            })),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 45,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/LAB1.png",
                      height: 125,
                      width: 125,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      back: SobshitOProblemSuccess(),
    );


  }


   Future<ModelOKompaniyaNapisatMain> getData(String token, String text) async {
    http.Response response = await http.post(
        Uri.parse("http://hansa-lab.ru/api/site/add-problem"),
        headers: {"token": token},
        body: {"text": text});
    print(response.statusCode);
    print(response.body);
    print("Bloc O Kompaniya Napisat ----------------------------------");

    return ModelOKompaniyaNapisatMain.fromMap(jsonDecode(response.body));
  }

}