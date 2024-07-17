import 'package:flutter/material.dart';

class IconRadio extends StatelessWidget {
  final Color? color;
  final IconData icon;
  final VoidCallback? ontap;
  const IconRadio({super.key, this.color, this.icon = Icons.check, this.ontap});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.grey,
        shadowColor: Colors.black,
        child: InkWell(
          // Color: Color.fromARGB(255, 249, 47, 74),
          onTap: ontap,
          child: SizedBox(
            width: 15,
            height: 15,
            child: Icon(icon, size: 8, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
