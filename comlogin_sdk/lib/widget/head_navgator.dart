import 'package:comlogin_sdk/util/padding_extension.dart';
import 'package:flutter/material.dart';

class HeadNavgator extends StatelessWidget {
  final Widget body;
  final String? title;
  final IconData? iconright;
  final Color? iconcolor;
  final VoidCallback? iconrontap;

  const HeadNavgator({
    super.key,
    required this.body,
    this.title,
    this.iconright,
    this.iconrontap,
    this.iconcolor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                size: 30,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: Text(
              title ?? '',
              style: const TextStyle(
                  fontSize: 16,
                  letterSpacing: 1.3,
                  fontWeight: FontWeight.w500),
            ),
            actions: [
              if (iconright != null)
                InkWell(onTap: iconrontap ?? () {}, child: Icon(iconright)),
              20.paddingWidth
            ],
            iconTheme: IconThemeData(color: iconcolor, size: 30),
            backgroundColor: const Color.fromRGBO(255, 255, 255, 0.8),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255)),
                  )),
            )),
        body: body);
  }
}
