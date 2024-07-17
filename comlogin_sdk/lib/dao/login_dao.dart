// 登录操作
import 'package:comlogin_sdk/util/navigator_util.dart';
import 'package:flutter_hi_cache/flutter_hi_cache.dart';

abstract class AloginDao {
  // static不能修饰抽象类
  void saveUserInfo(); // 保存登录信息
  void loginOut(); // 登出账号
  Map<String, dynamic>? getUserInfo(); // 获取账号信息
  String? getBoardingPass(); //获取登录令牌
  String? getAccountHash(); //多账号数据标识
}

// 后续完成主要内容再来处理微信登录

class LoginDao implements AloginDao {
  static const kUserInfo = 'user_info';

  @override
  String? getAccountHash() {
    // TODO: implement getAccountHash
    throw UnimplementedError();
  }

  @override
  String? getBoardingPass() {
    // TODO: implement getBoardingPass
    // throw UnimplementedError();
    return '';
  }

  @override
  Map<String, dynamic>? getUserInfo() {
    // TODO: implement getUserInfo
    throw UnimplementedError();
  }

  @override
  void saveUserInfo() {
    // TODO: implement saveUserInfo
  }

  @override
  void loginOut() {
    HiCache.getInstance().remove(kUserInfo);
    NavigatorUtil.goToLogin();
  }
}
