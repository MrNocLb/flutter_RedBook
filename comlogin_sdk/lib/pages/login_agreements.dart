// 相关协议的细则页面
import 'package:comlogin_sdk/util/padding_extension.dart';
import 'package:comlogin_sdk/widget/head_navgator.dart';
import 'package:comlogin_sdk/widget/textontap.dart';
import 'package:flutter/material.dart';
import 'package:comlogin_sdk/util/allsmallwidget.dart';

class AgreementsDetailPage extends StatelessWidget {
  const AgreementsDetailPage({super.key});

  get _text {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '账号找回失败？',
          style: TextStyle(
              color: Colors.grey[600], letterSpacing: 1, fontSize: 12),
        ),
        3.paddingWidth,
        TextOntap(
          content: '一键注册新账号',
          onPressed: () {},
          color: Color.fromARGB(255, 40, 65, 94),
          size: 12,
        )
      ],
    );
  }

  Widget _listview(
      String title, String explain, VoidCallback ontap, BuildContext context) {
    return Column(
      children: [
        AllsmallWidget.soidwidgt(
            h: 1,
            w: MediaQuery.of(context).size.width * 0.97,
            color: const Color.fromARGB(255, 232, 226, 226)),
        // 10.paddingHeight,
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 8, top: 10, bottom: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 16),
                      ),
                      5.paddingHeight,
                      Text(
                        explain,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      )
                    ],
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 26,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _body(BuildContext context) {
    return ListView(
      children: [
        _listview('手机号不用了，无法登录', '手机号不用了或停机，通过身份验证后登录', () {}, context),
        _listview('找回账号', '忘记之前登录的账号，通过昵称/小红书号、实名找回账号', () {}, context),
        _listview('忘记密码', '通过手机验证码设置新的登录密码', () {}, context),
        _listview('其他问题', '账号被盗等其他问题', () {}, context),
        AllsmallWidget.soidwidgt(
            h: 1,
            w: MediaQuery.of(context).size.width * 0.95,
            color: const Color.fromARGB(255, 232, 226, 226)),
        24.paddingHeight,
        _text
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return HeadNavgator(
      body: _body(context),
    );
  }
}
