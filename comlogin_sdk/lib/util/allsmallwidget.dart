import 'package:flutter/material.dart';

class AllsmallWidget {
  // 所有小型组件

  // 圆形图标--------------------------------------
  static Widget radiusIcons(IconData icon,
      {double size = 50, double iconsize = 30, VoidCallback? ontap}) {
    return ClipOval(
      child: Card(
        color: Colors.white,
        elevation: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          side: BorderSide(
              color: Color.fromARGB(255, 219, 217, 217), width: 1), // 灰色边框
        ),
        child: InkWell(
          onTap: ontap,
          child: Container(
              color: Colors.white,
              width: size,
              height: size,
              child: Icon(
                icon,
                size: iconsize,
              )),
        ),
      ),
    );
  }

  // 虚线-----------------------------------------
  static Widget soidwidgt(
      {required double h, required double w, Color? color}) {
    return SizedBox(
        width: w,
        height: h,
        child: DecoratedBox(
          decoration: BoxDecoration(color: color),
        ));
  }
}
