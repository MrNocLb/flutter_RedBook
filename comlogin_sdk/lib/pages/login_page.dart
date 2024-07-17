import 'package:comlogin_sdk/comlogin_sdk.dart';
import 'package:comlogin_sdk/models/agreement_model.dart';
import 'package:comlogin_sdk/util/dialog_util.dart';
import 'package:comlogin_sdk/util/padding_extension.dart';
import 'package:comlogin_sdk/widget/textontap.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../util/allsmallwidget.dart';
import '../util/navigator_util.dart';
import 'login_agreements.dart';
import 'login_help.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _enable = false; //是否勾选协议
  bool logined = false; //是否上次登录过
  TapGestureRecognizer _textjeep = new TapGestureRecognizer();
  List<AgreementModel> agreements = [
    AgreementModel(agreement: '《用户协议》', url: 'user'),
    AgreementModel(agreement: '《隐私政策》', url: 'message'),
    AgreementModel(agreement: '《儿童/青少年信息保护规则》', url: 'child')
  ];
  List<TextSpan> textSpans = [];

  get _bakcground {
    return Positioned.fill(
        top: 30,
        child: Image.asset(
          'assets/images/open1.jpg',
          fit: BoxFit.cover,
        )
        // Image.network() 后续替换
        );
  }

  get _content {
    return Positioned.fill(
        left: 35,
        right: 35,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (MediaQuery.of(context).size.height * 3.2 / 5).paddingHeight,
            _loginbtn,
            15.paddingHeight,
            _otherlogin,
            70.paddingHeight,
            _agreement
          ],
        ));
  }

  get _agreement {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Material(
              elevation: 8,
              color:
                  _enable ? const Color.fromRGBO(255, 34, 68, 1) : Colors.grey,
              child: InkWell(
                  onTap: () {
                    setState(() {
                      _enable = !_enable;
                    });
                  },
                  child: const SizedBox(
                    width: 15,
                    height: 15,
                    child: Icon(Icons.check, size: 8, color: Colors.white),
                  ))),
        ),
        7.paddingWidth,
        Flexible(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            text: TextSpan(
                text: '我已阅读并同意',
                style: TextStyle(color: Colors.grey[700], fontSize: 11),
                children: textSpans),
          ),
        ),
      ],
    );
  }

  get _loginbtn {
    return MaterialButton(
      onPressed: _enable! ? _loginwx : _agreementdialog,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      height: 48,
      color: const Color.fromARGB(255, 8, 172, 87),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.public,
            size: 18,
            color: Colors.white,
          ),
          5.paddingWidth,
          const Text(
            '微信登录',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          5.paddingWidth,
          if (logined)
            const Text(
              '(上次登录)',
              style: TextStyle(color: Colors.white, fontSize: 12),
            )
        ],
      ),
    );
  }

  get _otherlogin {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextOntap(
            content: '其他登录方式',
            onPressed: _loginother,
            color: const Color.fromARGB(255, 55, 80, 109),
            size: 13,
            weight: FontWeight.w600,
            letters: 1.2,
          ),
          const Icon(
            Icons.chevron_right,
            size: 18,
            color: Color.fromARGB(255, 55, 80, 109),
          )
        ],
      ),
    );
  }

  get _helpage {
    return Positioned.fill(
      top: -MediaQuery.of(context).size.height * 9 / 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextOntap(
            content: '帮助',
            onPressed: () {
              NavigatorUtil.push(context, AgreementsDetailPage());
            },
            color: Colors.grey[500],
            size: 15,
            letters: 2,
          ),
          20.paddingWidth,
        ],
      ),
    );
  }

  get _agremeentsdialog {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < agreements.length; i++)
                TextOntap(
                  content: agreements[i].agreement!,
                  onPressed: () => _jeepPage,
                  color: const Color.fromARGB(255, 48, 125, 167),
                  size: 12,
                  letters: 1,
                ),
            ],
          ),
        ),
        10.paddingHeight,
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: MaterialButton(
            onPressed: () {
              setState(() {
                _enable = true;
              });
              Navigator.of(context).pop();
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            height: 48,
            minWidth: MediaQuery.of(context).size.width * 4 / 5,
            color: const Color.fromRGBO(255, 36, 66, 1),
            child: const Center(
              child: Text(
                '同意并继续',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        )
      ],
    );
  }

  get _loginotherdialog {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 130,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AllsmallWidget.radiusIcons(Icons.phone_android_outlined,
                  ontap: () {}),
              AllsmallWidget.radiusIcons(Icons.catching_pokemon),
            ],
          ),
        ),

        10.paddingHeight,
        // 点击确认条约
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Material(
                    elevation: 8,
                    color: const Color.fromRGBO(255, 34, 68, 1),
                    // : Colors.grey
                    child: InkWell(
                        onTap: () {},
                        child: const SizedBox(
                          width: 15,
                          height: 15,
                          child:
                              Icon(Icons.check, size: 8, color: Colors.white),
                        ))),
              ),
              7.paddingWidth,
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  text: TextSpan(
                      text: '我已阅读并同意',
                      style: TextStyle(color: Colors.grey[700], fontSize: 11),
                      children: [
                        for (var i = 0; i < agreements.length; i++)
                          TextSpan(
                              text: agreements[i].agreement,
                              style: const TextStyle(
                                  color: Color.fromRGBO(44, 65, 90, 1),
                                  fontSize: 11,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600),
                              recognizer: _textjeep
                                ..onTap = () => _jeepPage(agreements[i].url!))
                      ]),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _textjeep.dispose(); //销毁协议跳转页面函数
    TapGestureRecognizer().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < agreements.length; i++) {
      // 处理reconizer 不能传数组的问题
      var url = agreements[i].url!;
      textSpans.add(
        TextSpan(
          text: agreements[i].agreement,
          style: const TextStyle(
              color: Color.fromRGBO(44, 65, 90, 1),
              fontSize: 11,
              letterSpacing: 1,
              fontWeight: FontWeight.w600),
          recognizer: TapGestureRecognizer()..onTap = () => _jeepPage(url),
        ),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false, //键盘调整关闭
      body: Stack(children: [_bakcground, _content, _helpage]),
    );
  }

//ios 需要检测是否拥有wx 没有则提供别的登录方式

  _loginwx() {
    // wx登录操作 todo

    // 暂时先直接跳转

    NavigatorUtil.goToHome(context);
  }

  _agreementdialog() {
    // 如果没有同意协议自动弹窗是否确定 todo
    DialogUtil.showsbluedialog(context,
        title: '请阅读并同意以下条款', widget: _agremeentsdialog);
    // 点击跳转
  }

  _loginother() {
    // 其他登录操作 todo
    DialogUtil.showsbluedialog(context,
        title: '选择登录方式', widget: _loginotherdialog);
  }

  _jeepPage(String url) {
    //跳转页面 todo
    if (url == 'user' || url == 'message' || url == 'child') {
      NavigatorUtil.push(context, AgreementPage(url: url));
      debugPrint(url);
    }
  }
}
