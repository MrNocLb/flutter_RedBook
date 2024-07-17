import 'package:comlogin_sdk/util/padding_extension.dart';

import 'package:flutter/material.dart';

class DialogUtil {
  static Future<bool?> showsbluedialog(
    BuildContext context, {
    required String title,
    required Widget widget,
  }) {
    return showDialog(
        barrierDismissible: true, //点击灰色背景时候是否消失弹窗11
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyDialogWidget(
                widget: widget,
                title: title,
              ),
            ],
          );
        });
  }

  static Future<bool?> showdialog(
    BuildContext context, {
    required Widget widget,
  }) {
    return showDialog(
        barrierDismissible: true, //点击灰色背景时候是否消失弹窗11
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget,
            ],
          );
        });
  }
}

class MyDialogWidget extends StatelessWidget {
  final Widget widget;
  final String title;
  const MyDialogWidget({
    Key? key,
    required this.widget,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
          child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            15.paddingHeight,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    letterSpacing: 1,
                    fontSize: 16,
                    color: Color.fromARGB(255, 66, 63, 63),
                  ),
                )
              ],
            ),
            12.paddingHeight,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 1,
              child: const DecoratedBox(
                  decoration: BoxDecoration(color: Color(0xFFDDDDDD))),
            ),
            widget,
            22.paddingHeight
          ],
        ),
      )),
    );
  }
}
