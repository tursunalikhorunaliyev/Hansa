import 'package:flutter/cupertino.dart';
import 'package:hansa_app/blocs/bloc_change_profile.dart';
import 'package:hansa_app/drawer_widgets/referal_silka.dart';
import 'package:hansa_app/drawer_widgets/rekvizit.dart';
import 'package:hansa_app/drawer_widgets/text_icon.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({Key? key}) : super(key: key);

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  @override
  Widget build(BuildContext context) {
    final blocChangeProfileProvider = Provider.of<BlocChangeProfile>(context);
    return Wrap(
      children: [
        StreamBuilder<ActionChange>(
          initialData: ActionChange.personRekvizit,
          stream: blocChangeProfileProvider.dataStream,
          builder: (context, snapshot) {
            if (snapshot.data == ActionChange.rekvizit) {
              return const Rekvizit();
            } else {
              return Padding(
                padding:  EdgeInsets.only(left: 39.w),
                child: Column(
                  children: [
                     SizedBox(
                      height: 15.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        blocChangeProfileProvider.dataSink
                            .add(ActionChange.personal);
                      },
                      child: TextIcon(
                          text: "Персональные данные",
                          iconUrl: "assets/user_icons.png",
                          rang: const Color(0xFFff0025)),
                    ),
                     SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        blocChangeProfileProvider.dataSink
                            .add(ActionChange.rekvizit);
                      },
                      child: TextIcon(
                        text: "Мои реквизиты",
                        iconUrl: "assets/free-icon-personal-data-3740813.png",
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
         SizedBox(
          height: 230.h,
        ),
        const ReferalSilka(),
      ],
    );
  }
}
