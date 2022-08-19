import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  int a = 2;
  List list = [];

  final key = GlobalKey<AnimatedListState>();

  void addItem() {
    list.insert(0, "Item ${list.length + 1}");
    key.currentState!.insertItem(0, duration: const Duration(milliseconds: 500));
  }

  void remove(int index) {
    key.currentState!.removeItem(index, duration: const Duration(milliseconds: 500),
        (context, animation) {
      return SizeTransition(
        sizeFactor: animation,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: AnimatedList(
                scrollDirection: Axis.vertical,
                clipBehavior: Clip.hardEdge,
                key: key,
                initialItemCount: list.length,
                itemBuilder: (context, index, animation) {
                  return ScaleTransition(
                    key: UniqueKey(),
                    scale: animation,
                    child: InkWell(
                      onLongPress: () {
                        remove(index);
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: const BoxDecoration(color: Colors.amber),
                        child: Text(list[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
            MaterialButton(
              onPressed: () {
                addItem();
              },
              color: Colors.green,
              child: const Text("Add"),
            )
          ],
        ),
      ),
    );
  }
}
