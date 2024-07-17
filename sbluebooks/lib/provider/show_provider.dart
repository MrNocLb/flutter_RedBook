import 'package:flutter/material.dart';

class DrawershowProvider with ChangeNotifier {
  bool _drawershowPro = false;

  bool get drawershowPro => _drawershowPro;

  void changershow1() {
    _drawershowPro = true;
    debugPrint('$_drawershowPro');
    notifyListeners(); // 状态改变后通知监听者
  }

  void changershow0() {
    _drawershowPro = false;
    debugPrint('$_drawershowPro');
    notifyListeners(); // 状态改变后通知监听者
  }
}
