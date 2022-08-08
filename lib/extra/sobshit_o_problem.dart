import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/blocs/bloc_o_kompaniya_napisat.dart';
import 'package:hansa_app/enums/enum_action_view.dart';
import 'package:provider/provider.dart';

class SobshitOProblem extends StatelessWidget {
  const SobshitOProblem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerToken = Provider.of<String>(context);
    final blocOKompaniyaNapisat = BlocOKompaniyaNapisat(providerToken);
    final textFieldController = TextEditingController();

    return Scaffold(
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
                            Text(
                              "Задать вопрос",
                              style: GoogleFonts.montserrat(
                                  color: const Color(0xff444444), fontSize: 24),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: TextField(
                                controller: textFieldController,
                                maxLines: 5,
                                cursorColor: const Color(0xffa1b7c2),
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(bottom: 100),
                                    child: Image.asset(
                                      "assets/free-icon-maps-and-flags-446099.png",
                                      scale: 3,
                                    ),
                                  ),
                                  hintText: "Текст вашего сообщения",
                                  hintStyle: GoogleFonts.montserrat(
                                      color: const Color(0xffa1b7c2)),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xffa1b7c2),
                                    ),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xffa1b7c2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(64),
                                child: LayoutBuilder(
                                  builder: (contextShowD, constraints) =>
                                      GestureDetector(
                                    onTap: () {
                                      if (textFieldController.text.isNotEmpty) {
                                        blocOKompaniyaNapisat
                                            .setText(textFieldController.text);
                                        blocOKompaniyaNapisat.eventSink
                                            .add(EnumActionView.view);
                                      } else {
                                        ScaffoldMessenger.of(contextShowD)
                                            .showSnackBar(SnackBar(
                                                content: Text("Пустое поле")));
                                      }
                                    },
                                    child: Container(
                                      height: 47,
                                      color: const Color(0xff25b049),
                                      child: Center(
                                        child: Text(
                                          "Отправить сообщение",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 13,
                                            color: const Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
    );
  }
}
