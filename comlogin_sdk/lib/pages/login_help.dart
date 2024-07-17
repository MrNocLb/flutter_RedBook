// 登录的帮助界面

import 'package:comlogin_sdk/util/padding_extension.dart';
import 'package:comlogin_sdk/widget/head_navgator.dart';
import 'package:flutter/material.dart';

class AgreementPage extends StatefulWidget {
  final String url;
  const AgreementPage({super.key, required this.url});

  @override
  State<AgreementPage> createState() => _AgreementPageState();
}

class _AgreementPageState extends State<AgreementPage> {
  // url需要widget才能调用

  // final String title;
  // 后续换成接口的 model 模型
  // 0 1 是标题 2 是正文 文本样式
  static const List<TextStyle> textStyle = [
    TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    TextStyle(
        fontSize: 14, color: Colors.black, letterSpacing: 0.5, height: 1.8)
  ];
  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.paddingHeight,
          Center(
            child: Text(
              urltotitle(widget.url),
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
            ),
          ),
          15.paddingHeight,
          Text(
            '更新日期:2023年07月15日',
            style: textStyle[0],
          ),
          10.paddingHeight,
          Text('生效日期:2023年07月22日', style: textStyle[1]),
          10.paddingHeight,
          Text(
            '特别提示',
            style: textStyle[0],
          ),
          10.paddingHeight,
          RichText(
              text: TextSpan(
                  text:
                      '        欢迎使用小红书公司为您提供的小红书平台。请您务必审慎阅读、充分理解以下内容，特别是免除或者限制小红书公司责任的条款、对用户权利进行限制的条款、约定法律适用与管辖的条款等。限制、免责条款或者其他涉及您重大权益的条款可能以加粗等形式提示您重点注意。',
                  style: textStyle[2]))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return HeadNavgator(
      body: _body(context),
      title: urltotitle(widget.url),
    );
  }

  //  没有接口时 临时转换用
  String urltotitle(String url) {
    var t;
    if (url == 'user') {
      t = '小红书用户服务协议';
    } else if (url == 'message') {
      t = '《隐私政策》';
    } else if (url == 'child') {
      t = '《儿童/青少年信息保护规则》';
    } else {
      t = '';
    }
    return t;
  }
}
