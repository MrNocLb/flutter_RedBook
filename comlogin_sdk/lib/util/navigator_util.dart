import 'package:comlogin_sdk/comlogin_sdk.dart';
import 'package:comlogin_sdk/pages/login_page.dart';
import 'package:flutter/material.dart';

class NavigatorUtil {
  // 用于获取不到context的地方 如dao中跳转页面时使用 需要在homepage赋值
  static BuildContext? _context;
  static updataContext(BuildContext context) {
    NavigatorUtil._context = context;
  }

  // 跳转到指定页面
  static Future<T?> push<T extends Object?>(BuildContext context, Widget page) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  }

  // 跳转回登录界面
  static goToLogin() {
    // 跳转而且不能返回
    Navigator.pushReplacement(
        _context!, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  // 跳首页不返回
  static goToHome(BuildContext context) {
    if (LoginConfig.instance().homePage is Widget) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginConfig.instance().homePage!));
    } else {
      throw Exception('请初始化登录配置');
    }
  }
}
