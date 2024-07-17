// import 'package:flutter/material.dart';
// import 'package:flutter_hi_cache/flutter_hi_cache.dart';

// class KeyboardProvider extends ChangeNotifier {
//   static const keyboardh = 'keyboardh';
//   double _h = 0.0;
//   double get h => _h;

//   // 初始化
//   void init() {
//     String? keybh = HiCache.getInstance().get(keyboardh);
//   }

//   // 设置键盘高度
//   void setKeyboard({required double h}) {
//     HiCache.getInstance().setDouble(keyboardh, h);
//     notifyListeners();
//   }

//   // 获取键盘高度
//   double getKeyboard() {
//     _h ??= init();
//     return;
//   }

//   // 重置至默认键盘高度
//   void rkeyboard() {}
// }
import 'package:flutter/material.dart';
import 'package:flutter_hi_cache/flutter_hi_cache.dart';

class KeyboardProvider extends ChangeNotifier {
  static const String keyboardHeightKey = 'keyboardh';
  double _keyboardHeight = 0.0;

  double get keyboardHeight => _keyboardHeight;

  // 初始化，在构造函数中完成
  KeyboardProvider() {
    _initKeyboardHeight();
  }

  // 私有方法，初始化键盘高度
  void _initKeyboardHeight() {
    double? cachedHeight = HiCache.getInstance().get(keyboardHeightKey);
    if (cachedHeight != null) {
      _keyboardHeight = cachedHeight;
    }
  }

  // 设置键盘高度
  void setKeyboardHeight(double height) {
    HiCache.getInstance().setDouble(keyboardHeightKey, height);
    _keyboardHeight = height;
    notifyListeners();
  }

  // 获取键盘高度，直接返回当前已有的高度
  double getKeyboardHeight() {
    return _keyboardHeight;
  }

  // 重置至默认键盘高度，可以设定一个默认值
  void resetToDefaultKeyboardHeight() {
    _keyboardHeight = 0.0;
    HiCache.getInstance().remove(keyboardHeightKey);
    notifyListeners();
  }
}
