import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/store_model.dart';
import 'package:hansa_app/api_services/store_service.dart';

class NazvaniyaWidget extends StatefulWidget {
  const NazvaniyaWidget({Key? key}) : super(key: key);

  @override
  State<NazvaniyaWidget> createState() => _NazvaniyaWidgetState();
}

class _NazvaniyaWidgetState extends State<NazvaniyaWidget> {
  final bloc = StoreData();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.eventSink.add(StoreEnum.store);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 360,
          height: 400,
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7), topRight: Radius.circular(7))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.9, color: Colors.grey),
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
                            itemCount: 15,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Text(snapshot.data!.data.list[index].name),
                                  Divider()
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
                Container(
                    height: 50,
                    width: 340,
                    alignment: Alignment.center,
                    child: Text(
                      'OK',
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffe21a37),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
