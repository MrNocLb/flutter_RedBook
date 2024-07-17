import 'package:flutter/material.dart';

// 文字点击函数
class TextOntap extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;
  final VoidCallback? onlongtap;
  final Color? color;
  final double? size;
  final double? letters;
  final FontWeight? weight;
  const TextOntap(
      {super.key,
      required this.content,
      required this.onPressed,
      this.color,
      this.size,
      this.onlongtap,
      this.weight,
      this.letters});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onPressed != null) onPressed!();
      },
      onLongPress: onlongtap,
      child: Text(
        content,
        maxLines: 1,
        style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: weight,
            letterSpacing: letters),
      ),
    );
  }
}
