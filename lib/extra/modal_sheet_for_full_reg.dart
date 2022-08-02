import 'package:filter_list/filter_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hansa_app/api_models.dart/country_model.dart';
import 'package:hansa_app/api_models.dart/job_model.dart';
import 'package:hansa_app/blocs/bloc_full_register.dart';
import 'package:hansa_app/blocs/hansa_country_api.dart';
import 'package:hansa_app/blocs/hansa_job_api.dart';
import 'package:hansa_app/enums/full_reg_enum.dart';
import 'package:hansa_app/extra/nazvaniya.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ModalForFullReg extends StatefulWidget {
  final FullRegEnum regEnum;
  final String text;
  final double width;
  final double height;
  final double size;
  final FontWeight fontWeight;

  const ModalForFullReg(
      {Key? key,
      required this.regEnum,
      required this.text,
      required this.fontWeight,
      required this.size,
      required this.height,
      required this.width})
      : super(key: key);

  @override
  State<ModalForFullReg> createState() => _ModalForFullRegState();
}

class _ModalForFullRegState extends State<ModalForFullReg> {
  String dataRojdeniya = "";
  String selectedText = "Salom";

  final blocJob = BlocJob();
  final blocCity = HansaCountryBloC(1);
  @override
  void initState() {
    super.initState();
    blocJob.eventSink.add(JobEnum.job);
    blocCity.eventSink.add(CityEnum.city);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          left: 11,
          right: 9,
        ),
        child: StreamBuilder<CountryModel>(
            stream: blocCity.stream,
            builder: (context, snapshot1) {
              return StreamBuilder<JobModel>(
                  stream: blocJob.stream,
                  builder: (context, snapshot) {
                    if (snapshot1.hasData && snapshot.hasData) {
                      return GestureDetector(
                        onTap: () {
                          print(snapshot1.hasData ? "borrrr" : "yoqqqq");
                          if (widget.regEnum == FullRegEnum.dataRojdeniya) {
                            final dateRangeController =
                                Provider.of<DateRangePickerController>(context,
                                    listen: false);
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return Container(
                                      width: 360,
                                      height: 400,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SfDateRangePicker(
                                        controller: dateRangeController,
                                        selectionColor: Colors.pink[600],
                                        todayHighlightColor: Colors.pink[600],
                                        onSelectionChanged: (a) {
                                          String day = dateRangeController
                                                      .selectedDate!.day
                                                      .toString()
                                                      .length ==
                                                  1
                                              ? "0" +
                                                  dateRangeController
                                                      .selectedDate!.day
                                                      .toString()
                                              : dateRangeController
                                                  .selectedDate!.day
                                                  .toString();
                                          String month = dateRangeController
                                                      .selectedDate!.month
                                                      .toString()
                                                      .length ==
                                                  1
                                              ? "0" +
                                                  dateRangeController
                                                      .selectedDate!.month
                                                      .toString()
                                              : dateRangeController
                                                  .selectedDate!.month
                                                  .toString();
                                          String year = dateRangeController
                                              .selectedDate!.year
                                              .toString();
                                          setState(() {
                                            dataRojdeniya =
                                                day + "." + month + "." + year;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ));
                                });
                          } else if (widget.regEnum == FullRegEnum.doljnost) {
                            final doljnost = Provider.of<TextEditingController>(
                                context,
                                listen: false);
                            final bloc = Provider.of<BlocFullRegister>(context,
                                listen: false);
                            List<String> listValues = [];
                            List<int> listLKeys = [];
                            for (var element
                                in snapshot.data!.data.jobModelData) {
                              listLKeys.add(element.id);
                              listValues.add(element.name);
                            }
                            FilterListDialog.display<String>(
                                enableOnlySingleSelection: true,
                                selectedListData: [selectedText],
                                context,
                                listData: listValues,
                                choiceChipLabel: (a) => a,
                                validateSelectedItem: (list, val) =>
                                    list!.contains(val),
                                onItemSearch: (item, query) {
                                  return item
                                      .toLowerCase()
                                      .contains(query.toLowerCase());
                                },
                                onApplyButtonClick: (list1) {
                                  doljnost.text = list1!.first;
                                  bloc.ak.add(doljnost.text);
                                  Navigator.pop(context);
                                });
                          } else if (widget.regEnum ==
                              FullRegEnum.vibiriteGorod) {
                            final gorod = Provider.of<TextEditingController>(
                                context,
                                listen: false);
                            final bloc = Provider.of<BlocFullRegister>(context,
                                listen: false);
                            List<String> listValues1 = [];
                            List<int> listLKeys1 = [];
                            for (dynamic element in snapshot1.hasData
                                ? snapshot1.data!.data.list
                                : []) {
                              listLKeys1.add(element.id);
                              listValues1.add(element.name);
                            }
                            FilterListDialog.display<String>(
                                enableOnlySingleSelection: true,
                                selectedListData: [selectedText],
                                context,
                                listData: listValues1,
                                choiceChipLabel: (a) => a,
                                validateSelectedItem: (list, val) =>
                                    list!.contains(val),
                                onItemSearch: (item, query) {
                                  return item
                                      .toLowerCase()
                                      .contains(query.toLowerCase());
                                },
                                onApplyButtonClick: (list1) {
                                  gorod.text = list1!.first;
                                  bloc.bk.add(gorod.text);
                                  Navigator.pop(context);
                                });
                          } else if (widget.regEnum ==
                              FullRegEnum.nazvaniyaSeti) {
                            final nazvaniya =
                                Provider.of<TextEditingController>(context,
                                    listen: false);
                            final bloc = Provider.of<BlocFullRegister>(context,
                                listen: false);
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Material(
                                          child: Provider(
                                        create: (context) => bloc,
                                        child: NazvaniyaWidget(
                                          text: nazvaniya,
                                        ),
                                      )));
                                });
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: widget.height,
                              width: widget.width,
                              decoration: BoxDecoration(
                                color: const Color(0xFFffffff),
                                borderRadius: BorderRadius.circular(54),
                                border: Border.all(width: 0.1),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 13, top: 13),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: dataRojdeniya.isEmpty
                                            ? widget.text
                                            : dataRojdeniya,
                                        style: GoogleFonts.montserrat(
                                            fontWeight: widget.fontWeight,
                                            fontSize: widget.size,
                                            color: const Color(0xFF444444))),
                                  ]),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  });
            }));
  }
}
