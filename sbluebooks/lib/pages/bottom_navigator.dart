// 底部导航栏
import 'package:comlogin_sdk/util/navigator_util.dart';
import 'package:comlogin_sdk/util/padding_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbluebooks/pages/my_page.dart';
import 'package:sbluebooks/pages/shopping_page.dart';
import 'package:sbluebooks/provider/show_provider.dart';
import 'main_page.dart';
import 'main_search_page.dart';
import 'message_page.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentIndex = 0;
  double bottompadding = 0;
// 侧边栏
  Widget _drawer(Function onClose) {
    return Row(
      children: [
        ClipRRect(
          // 使用ClipRRect来移除圆角
          borderRadius: BorderRadius.zero, // 确保没有圆角
          child: Container(
            width: MediaQuery.of(context).size.width * 0.65,
            color: Colors.white,
            // 保持与默认drawer颜色一致
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 0, top: 60, bottom: 10, right: 0),
              child: Column(
                children: [
                  Flexible(
                    flex: 7,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        drawerList(context,
                            icon: Icons.person_add_alt_1_outlined,
                            title: '发现好友',
                            url: const ShoppingPage()),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 15),
                          child: SizedBox(
                              height: 1.6,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(136, 236, 235, 235)),
                              )),
                        ),
                        drawerList(context,
                            icon: Icons.emoji_objects_outlined,
                            title: '创作中心',
                            url: const ShoppingPage()),
                        drawerList(context,
                            icon: Icons.work_history_outlined,
                            title: '我的草稿',
                            url: const ShoppingPage()),
                        drawerList(context,
                            icon: Icons.history,
                            title: '浏览记录',
                            url: const ShoppingPage()),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 15),
                          child: SizedBox(
                              height: 1.6,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(136, 236, 235, 235)),
                              )),
                        ),
                        drawerList(context,
                            icon: Icons.assignment_outlined,
                            title: '订单',
                            url: const ShoppingPage()),
                        drawerList(context,
                            icon: Icons.shopping_cart_outlined,
                            title: '购物车',
                            url: const ShoppingPage()),
                        drawerList(context,
                            icon: Icons.account_balance_wallet_outlined,
                            title: '钱包',
                            url: const ShoppingPage()),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 15),
                          child: SizedBox(
                              height: 1.6,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(136, 236, 235, 235)),
                              )),
                        ),
                        drawerList(context,
                            icon: Icons.grass_outlined,
                            title: '社区公约',
                            url: const ShoppingPage()),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          icontxt(
                              icon: Icons.settings_outlined,
                              title: '设置',
                              ontap: () {
                                setting();
                              }),
                          icontxt(
                              icon: Icons.headset_mic_outlined,
                              title: '帮助与客服',
                              ontap: () {
                                helpandhelp();
                              }),
                          icontxt(
                              icon: Icons.qr_code_scanner,
                              title: '扫一扫',
                              ontap: () {
                                scaning();
                              }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        // 空白区域设置回调方式
        Expanded(
            child: GestureDetector(
          onTap: () {
            onClose();
            Navigator.pop(context);
          },
          child: Container(
            color: Colors.transparent,
          ),
        ))
      ],
    );
  }

  // 自定义导航栏 配合 pageview
  get bottom {
    return SizedBox(
      height: 56 + bottompadding,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        GestureDetector(
          onTap: () {
            if (_currentIndex != 0) {
              setState(() {
                _currentIndex = 0;
              });
              _controller.jumpToPage(0);
            }
          },
          child: Text(
            '首页',
            style: _currentIndex == 0
                ? const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 15)
                : const TextStyle(color: Colors.grey),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (_currentIndex != 1) {
              setState(() {
                _currentIndex = 1;
              });
              _controller.jumpToPage(1);
            }
          },
          child: Text(
            '购物',
            style: _currentIndex == 1
                ? const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 15)
                : const TextStyle(color: Colors.grey),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.redAccent[400],
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (_currentIndex != 2) {
              setState(() {
                _currentIndex = 2;
              });
              _controller.jumpToPage(2);
            }
          },
          child: Text(
            '消息',
            style: _currentIndex == 2
                ? const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 15)
                : const TextStyle(color: Colors.grey),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (_currentIndex != 3) {
              setState(() {
                _currentIndex = 3;
              });
              _controller.jumpToPage(3);
            }
          },
          child: Text(
            '我的',
            style: _currentIndex == 3
                ? const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 15)
                : const TextStyle(color: Colors.grey),
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    NavigatorUtil.updataContext(context);
    if (MediaQuery.of(context).padding.bottom == 0) {
      bottompadding = 10;
    } else {
      bottompadding = MediaQuery.of(context).padding.bottom;
    }

    final drawershowchange = context.watch<DrawershowProvider>();
    return Scaffold(
        drawerEnableOpenDragGesture: false,
        drawer: _drawer(() {
          drawershowchange.changershow0(); //目前没有意义
        }),
        body: Builder(builder: (context) {
          return PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // MainSearchPage(),
              // const ShoppingPage(),
              MainPage(
                contextq: context,
              ),
              const ShoppingPage(),
              const MessagePage(),
              MyPage(
                contextq: context,
              ),
            ],
          );
        }),
        bottomNavigationBar: bottom);
  }

  // 设置按钮 todo
  void setting() {}
  //  帮助与客服按钮 todo
  void helpandhelp() {}
  // 扫描 todo
  void scaning() {}
}

// 侧边栏 菜单组件
Widget drawerList(context,
    {required IconData icon, required String title, required Widget url}) {
  return Material(
    child: Ink(
      child: InkWell(
        splashColor: const Color.fromARGB(218, 238, 236, 236),
        onTap: () {
          // NavigatorUtil.push(context, url);s
        },
        child: SizedBox(
          height: 60,
          // color: Colors.blue,
          child: Row(
            children: [
              25.paddingWidth,
              Icon(
                icon,
                size: 25,
                color: Colors.grey[800],
              ),
              15.paddingWidth,
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[900],
                  letterSpacing: 0.8,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

// 侧边栏 底部按钮组件
Widget icontxt(
    {required IconData icon, required String title, required Function ontap}) {
  return InkWell(
    onTap: () {
      ontap();
    },
    child: Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(139, 232, 232, 232), // 灰色背景
            ),
            child: Icon(icon, color: Colors.grey[700], size: 22),
          ),
          4.paddingHeight,
          Text(
            title,
            style: TextStyle(
                fontSize: 12, color: Colors.grey[900], letterSpacing: 1),
          ),
        ],
      ),
    ),
  );
}
