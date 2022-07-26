import 'package:flutter/material.dart';
import 'package:hansa_app/blocs/bloc_change_title.dart';
import 'package:hansa_app/extra/custom_okompanii_item.dart';
import 'package:hansa_app/extra/custom_title.dart';
import 'package:provider/provider.dart';

class OKompanii extends StatelessWidget {
  const OKompanii({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocChangeTitleProvider = Provider.of<BlocChangeTitle>(context);
    return Expanded(
      child: Column(
        children: [
           StreamBuilder<String>(
             stream: blocChangeTitleProvider.titleStream,
             initialData: "",
             builder: (context, snapshot) {
               return CustomTitle(imagePath: "assets/Lab.png", title: snapshot.data!);
             }
           ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: List.generate(
                  15,
                  (index) => const CustomOKompaniiItem(
                    imageUrl: "assets/backgr.png",
                    title:
                        "Быстрый нагрев \nв индукционных \nповерхностях Hansa",
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
