import 'dart:async';
import 'dart:math';

import 'package:comlogin_sdk/util/padding_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AllSmallUtil {
  static String nameToShort(String name, int i) {
    // 名称过长不显示 i长度
    if (name.runes.length > i) {
      return '${name.substring(0, i)}...';
    } else {
      return name;
    }
  }

  // 数字转换 超过五位数 超过十位数
  static String intToShort(int i) {
    if (i > 9999) {
      return '${(i / 10000).toStringAsFixed(2)}万';
    } else {
      return i.toString();
    }
  }

// 蓝字标签跳转
  static Widget blueText(String n, VoidCallback ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Text(
        n,
        style: const TextStyle(color: Color.fromARGB(255, 17, 91, 151)),
      ),
    );
  }

  // 时间处理
  static String format(int millisecondsSinceEpoch, {bool dayOnly = true}) {
    // 当前日期
    DateTime nowDate = DateTime.now();
    // 传入日期
    DateTime targetDate =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    String prefix = '';

    // --------------------------
    if (nowDate.year != targetDate.year) {
      prefix = DateFormat('yyyy-M-d').format(targetDate);
    } else if (nowDate.month != targetDate.month) {
      prefix = DateFormat('M-d').format(targetDate);
    } else if (nowDate.day > targetDate.day) {
      if (nowDate.day - targetDate.day == 1) {
        prefix = '昨天';
      } else {
        prefix = DateFormat('M-d').format(targetDate);
      }
    } else if (nowDate.day - targetDate.day == 0) {
      if (nowDate.hour - targetDate.hour > 12 && dayOnly) {
        prefix = DateFormat('h:mm').format(targetDate);
      } else {
        if (nowDate.hour - targetDate.hour == 0) {
          if (nowDate.minute - targetDate.minute <= 5) {
            prefix = '刚刚';
          } else {
            prefix = '${nowDate.minute - targetDate.minute} 分钟前';
          }
        } else {
          prefix = '${nowDate.hour - targetDate.hour} 小时前';
        }
      }
    }

    return '$prefix ';
  }

  // 打乱数组顺序函数
  static List<T> shuffleArray<T>(List<T> array) {
    final Random rng = Random();
    for (int i = array.length - 1; i > 0; i--) {
      final int n = rng.nextInt(i + 1);
      final T temp = array[i];
      array[i] = array[n];
      array[n] = temp;
    }
    return array;
  }

  // 评论弹出键盘组件
  /// 上下文 是否diy 是的传widget
  static Future<bool?> showdialogkey(BuildContext context,
      {double keyheight = 0.0,
      bool isDiy = false,
      Widget? widget,
      ValueChanged<String>? onChanged,
      VoidCallback? onSend}) {
    debugPrint('keyheight : $keyheight ');
    final _controller = TextEditingController();
    return showDialog<bool>(
        barrierDismissible: true, //点击灰色背景时候是否消失弹窗11
        context: context,
        builder: (context) {
          return !isDiy
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Material(
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    // height: 30,

                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(93, 231, 226, 226),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        12.paddingWidth,
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          child: TextField(
                                            controller: _controller,
                                            style: TextStyle(
                                                fontSize: 14,
                                                letterSpacing: 0.5,
                                                color: Colors.grey[700]),
                                            cursorColor: Colors.blue,
                                            // cursorHeight: 14,
                                            decoration: const InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0,
                                                            color: Colors
                                                                .transparent)),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0,
                                                            color: Colors
                                                                .transparent)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0,
                                                            color: Colors
                                                                .transparent)),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 0,
                                                        color: Colors
                                                            .transparent)),
                                                contentPadding: EdgeInsets.zero,
                                                isCollapsed: true,
                                                // border:
                                                //     InputBorder.none, // 去掉下横线
                                                // focusedBorder: InputBorder
                                                // .none, // 去掉焦点时的下横线
                                                hintText: '让大家听到你的声音'),
                                            autofocus: true,
                                            onChanged: (value) {
                                              if (onChanged != null)
                                                onChanged!(value);
                                            },
                                            onSubmitted: (String value) {
                                              if (onSend != null) onSend!();
                                              FocusScope.of(context)
                                                  .unfocus(); // 移除焦点
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                debugPrint('1');
                                              },
                                              child: const Icon(
                                                Icons.alternate_email,
                                                size: 23,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            5.paddingWidth,
                                            GestureDetector(
                                              onTap: () {
                                                debugPrint('2');
                                              },
                                              child: const Icon(
                                                Icons.sentiment_satisfied,
                                                size: 23,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            5.paddingWidth,
                                            GestureDetector(
                                              onTap: () {
                                                debugPrint('3');
                                              },
                                              child: const Icon(
                                                Icons.image_outlined,
                                                size: 23,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            10.paddingWidth
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                // if (value)
                                //   GestureDetector(
                                //     onTap: () {},
                                //     child: Container(
                                //         width: 40,
                                //         height: 30,
                                //         decoration: BoxDecoration(
                                //             borderRadius:
                                //                 const BorderRadius.all(
                                //                     Radius.circular(5)),
                                //             color: Colors.blue[800]),
                                //         child: const Text(
                                //           '发送',
                                //           style: TextStyle(
                                //               color: Colors.white,
                                //               fontSize: 14,
                                //               letterSpacing: 0.6),
                                //         )),
                                //   )
                              ],
                            ),
                            15.paddingHeight,
                            SizedBox(height: keyheight),
                            // You can add more widgets here if needed
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : widget ?? const SizedBox();
        });
  }

// 获取网络图片高度
  static Future<Size> getImageDimensions(String imageUrl) async {
    // 创建一个ImageProvider
    final ImageProvider provider = NetworkImage(imageUrl);

    // 完成图片加载的Completer
    final Completer<Size> completer = Completer<Size>();

    // 定义图片加载监听器
    final ImageStreamListener listener = ImageStreamListener(
      (ImageInfo info, bool synchronousCall) {
        // 图片加载完成，获取图片的宽度和高度
        final ImageSize = Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        );
        // 完成completer
        completer.complete(ImageSize);
      },
      onError: (exception, stackTrace) {
        // 图片加载失败，完成completer并传递异常
        completer.completeError(exception, stackTrace);
      },
    );

    // 获取图片的ImageStream
    final ImageStream stream = provider.resolve(const ImageConfiguration());

    // 为ImageStream添加监听器
    stream.addListener(listener);

    // 返回Future，将在图片加载完成或发生错误时完成
    return completer.future;
  }
}
