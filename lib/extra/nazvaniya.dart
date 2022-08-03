import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/store_model.dart';
import 'package:hansa_app/api_services/store_service.dart';
import 'package:hansa_app/blocs/bloc_full_register.dart';
import 'package:provider/provider.dart';

class NazvaniyaWidget extends StatefulWidget {
  final TextEditingController text;

  const NazvaniyaWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<NazvaniyaWidget> createState() => _NazvaniyaWidgetState();
}

class _NazvaniyaWidgetState extends State<NazvaniyaWidget> {
  final bloc = StoreData();
  final TextEditingController tt = TextEditingController();
  @override
  void initState() {
    super.initState();
    bloc.eventSink.add(StoreEnum.store);
  }

  @override
  Widget build(BuildContext context) {
    final baloc = Provider.of<BlocFullRegister>(context);
    return SizedBox(
      width: 360,
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: tt,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0.9, color: Colors.grey),
                  borderRadius: BorderRadius.circular(54),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1.5),
                    borderRadius: BorderRadius.circular(54)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 13),
                hintStyle:
                    GoogleFonts.montserrat(color: const Color(0xFF444444)),
              ),
            ),
            Expanded(
              child: StreamBuilder<StoreModel>(
                  stream: bloc.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.data.list.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    widget.text.text = snapshot
                                        .data!.data.list[index].id
                                        .toString();
                                    tt.text = snapshot
                                        .data!.data.list[index].name
                                        .toString();
                                    baloc.ck.add(
                                        snapshot.data!.data.list[index].name);
                                    setState(() {});
                                  },
                                  child: Text(
                                      snapshot.data!.data.list[index].name)),
                              const Divider()
                            ],
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 50,
                  width: 340,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffe21a37),
                  ),
                  child: Text(
                    'OK',
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
