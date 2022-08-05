import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/country_model.dart';
import 'package:hansa_app/api_models.dart/job_model.dart';
import 'package:hansa_app/api_models.dart/model_doljnost.dart';
import 'package:hansa_app/blocs/bloc_doljnost.dart';
import 'package:hansa_app/blocs/bloc_popup_drawer.dart';
import 'package:hansa_app/blocs/hansa_country_api.dart';
import 'package:hansa_app/blocs/hansa_job_api.dart';
import 'package:hansa_app/enums/enum_action_view.dart';
import 'package:provider/provider.dart';

class PopupFullRegistrDoljnost extends StatefulWidget {
  PopupFullRegistrDoljnost({Key? key}) : super(key: key);

  @override
  State<PopupFullRegistrDoljnost> createState() =>
      _PopupFullRegistrDoljnostState();
}

class _PopupFullRegistrDoljnostState extends State<PopupFullRegistrDoljnost> {
  final blocPopupDrawer = BlocPopupDrawer();
  double radius = 54;
  String text = "Должность";

  @override
  Widget build(BuildContext context) {
    final isTablet = Provider.of<bool>(context);

    final blocJob = BlocJob();

    blocJob.eventSink.add(JobEnum.job);

    return StreamBuilder<double>(
        initialData: 38,
        stream: blocPopupDrawer.dataStream,
        builder: (context, snapshotSizeDrawer) {
          return InkWell(
            onTap: () {
              blocPopupDrawer.dataSink
                  .add(snapshotSizeDrawer.data! == 38 ? 200 : 38);
              radius = radius == 54 ? 10 : 54;
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 11, right: 9),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                height: isTablet ? 43 : snapshotSizeDrawer.data!,
                width: isTablet ? 350 : 360,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(width: 0.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 12),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 250),
                        child: Text(
                          text,
                          style: GoogleFonts.montserrat(
                              fontSize: isTablet ? 13 : 10,
                              color: const Color(0xFF444444)),
                        ),
                      ),
                      StreamBuilder<JobModel>(
                          stream: blocJob.stream,
                          builder: (context, snapshotJob) {
                            if (snapshotJob.hasData) {
                              return Expanded(
                                child: Visibility(
                                  visible: radius == 54 ? false : true,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(0),
                                    itemCount: snapshotJob
                                        .data!.data.jobModelData.length,
                                    itemBuilder: (context, index) {
                                      return TextButton(
                                        onPressed: () {
                                          text = snapshotJob.data!.data
                                              .jobModelData[index].name;
                                          blocPopupDrawer.dataSink.add(
                                              snapshotJob.data! == 38
                                                  ? 200
                                                  : 38);
                                          radius = radius == 54 ? 10 : 54;
                                        },
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            snapshotJob.data!.data
                                                .jobModelData[index].name,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
