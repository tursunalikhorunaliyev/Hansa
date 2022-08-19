import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BottomRefresh extends StatefulWidget {
  const BottomRefresh({Key? key}) : super(key: key);

  @override
  State<BottomRefresh> createState() => _BottomRefreshState();
}

class _BottomRefreshState extends State<BottomRefresh> {
  int length = 30;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  onLoading() async {
    await Future.delayed(const Duration(seconds: 1));
    length += 30;
    setState(() {});
  }

  onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        footer: CustomFooter(
          builder: (context, mode) {
            if (mode == LoadStatus.loading) {
              return Container(
                alignment: Alignment.center,
                child: const Text("Loading"),
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: const Text("Loaded"),
              );
            }
          },
        ),
        onLoading: onLoading,
        onRefresh: onRefresh,
        controller: refreshController,
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              length,
              (index) {
                return SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(index.toString()),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
