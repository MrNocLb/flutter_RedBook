library comlogin_sdk;

import 'package:flutter/cupertino.dart';
import 'package:flutter_hi_cache/flutter_hi_cache.dart';

class LoginConfig {
  static LoginConfig? _instance;
  Widget? homePage;
  static LoginConfig instance() {
    _instance ??= LoginConfig._();
    return _instance!;
  }

  // 初始化 登录所需的配置
  Future<void> init({required Widget homePage}) async {
    this.homePage = homePage;
    await HiCache.preInit();
  }

  LoginConfig._();
}
