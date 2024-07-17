import 'dart:async';
import 'package:flutter/material.dart';

/// 继承此组件获取键盘高度
///
/// 重写 keyboardHeight 函数获取键盘高度
///
/// 某些机型会随着键盘弹出而接收到多次键盘高度事件，此方法已过滤。
/// 使用方法：
// class _ChatPageState extends State<ChatPage>  with WidgetsBindingObserver, KeyboardHeight {
//         @override
//         keyboardHeight(double height) {
//                 // 高度
//         }
// }
///
mixin KeyboardHeight<T extends StatefulWidget>
    on State<T>, WidgetsBindingObserver {
  final WidgetsBinding _widgetsBinding = WidgetsBinding.instance;

  late Timer timer;
  @override
  void initState() {
    _widgetsBinding.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    // 键盘高度
    final viewInsets = EdgeInsets.fromWindowPadding(
        WidgetsBinding.instance.window.viewInsets,
        WidgetsBinding.instance.window.devicePixelRatio);

    // 某些机型会随着键盘弹出而接收到多次键盘高度事件，在此延时32毫秒过滤出最终值。
    try {
      // 取消已有的延时任务，过滤出最终值。
      timer.cancel();
    } catch (_) {}
    timer = Timer(const Duration(milliseconds: 32), () {
      keyboardHeight(viewInsets.bottom);
    });
  }

  // 重写此事件获取键盘高度
  void keyboardHeight(double height) {}

  @override
  void dispose() {
    _widgetsBinding.removeObserver(this);
    super.dispose();
  }
}
