import 'package:flutter/material.dart';
import 'package:hansa_app/blocs/bloc_sign.dart';

class SignScreen extends StatelessWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () async {
            print("Boshlandi");
            await BlocSignUp()
                .signUp(
                  'lastname',
                  'firstname',
                  'emailkwl@gmail.com',
                  '03.07.2007',
                  "2",
                  "13",
                  'shopnet',
                  'shopadress',
                  '+7 (223) 232-13-12',
                  "1",
                  "2",
                  "1",
                  "1",
                  "1",
                )
                .whenComplete(() => print("Tugadi"));
          },
          child: Ink(
            color: Colors.blue,
            height: 50,
            width: 150,
            child: const Center(
                child: Text(
              "Click me!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            )),
          ),
        ),
      ),
    );
  }
}
