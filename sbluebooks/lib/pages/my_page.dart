// // 我的
import 'dart:ffi';
import 'dart:ui';

import 'package:comlogin_sdk/util/padding_extension.dart';
import 'package:comlogin_sdk/widget/textontap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class MyPage extends StatefulWidget {
  final BuildContext contextq;
  const MyPage({super.key, required this.contextq});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  get _basemessage {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _top,
        9.paddingHeight,
        // 简介 todo 判断是否有简介
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              15.paddingWidth,
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: Text(
                  '暂时还没有简介',
                  style: TextStyle(
                      color: Colors.white, fontSize: 15, letterSpacing: 0.4),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        12.paddingHeight,
        _mid,
        15.paddingHeight,
        _bottom
      ],
    );
  }

  get _top {
    return Row(
      children: [
        15.paddingWidth,
        GestureDetector(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: SizedBox(
                width: 70,
                height: 70,

                // decoration:
                // BoxDecoration(color: Colors.redAccent),
                child: Image.asset(
                  'assets/images/tx.jpg',
                  fit: BoxFit.fill,
                ),
              )
              // Image.network(
              //   '', //先放着
              //   height: 10,
              //   width: 10,
              // ),
              ),
        ),
        20.paddingWidth,
        Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 本地获取
            Text('谈不之的自然界',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600)),
            Row(
              children: [
                Text(
                  '小红书号:${'1123123213123'}',
                  style: TextStyle(color: Colors.grey[400]),
                ),
                IconButton(
                    onPressed: personcard(),
                    icon: Icon(
                      Icons.qr_code_2_outlined,
                      color: Colors.grey[400],
                      size: 20,
                    ))
              ],
            )
          ],
        )
      ],
    );
  }

  get _mid {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              MidNumWidget(
                num: 0,
                txt: '关注',
                ontap: attention(),
              ),
              20.paddingWidth,
              MidNumWidget(
                num: 1,
                txt: '粉丝',
                ontap: fannum(),
              ),
              20.paddingWidth,
              MidNumWidget(
                num: 0,
                txt: '获赞与收藏',
                ontap: checklikefav(),
              )
            ],
          ),
          50.paddingWidth,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: editmess(),
                child: Container(
                  width: 90,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(39, 245, 245, 245),
                      border: Border.all(
                        color: Colors.white60,
                        width: 1,
                      )),
                  child: const Center(
                      child: Text(
                    '编辑资料',
                    style: TextStyle(
                        color: Colors.white, letterSpacing: 0.8, fontSize: 14),
                  )),
                ),
              ),
              20.paddingWidth,
              GestureDetector(
                onTap: opensetting(),
                child: Container(
                  width: 50,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(39, 245, 245, 245),
                      border: Border.all(
                        color: Colors.white60,
                        width: 1,
                      )),
                  child: const Center(
                      child: Icon(Icons.settings_outlined,
                          color: Colors.white, size: 20)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  get _bottom {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(children: [
          IconButtonNav(
            icon: Icons.shopping_cart_outlined,
            t1: '购物车',
            t2: '查看推荐好物',
            ontap: opencar(),
          ),
          10.paddingWidth,
          IconButtonNav(
            icon: Icons.emoji_objects_outlined,
            t1: '创作灵感',
            t2: '学创作找灵感',
            ontap: create(),
          ),
          10.paddingWidth,
          IconButtonNav(
            icon: Icons.access_time_rounded,
            t1: '浏览记录',
            t2: '看过的笔记',
            ontap: opensaw(),
          )
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              backgroundColor: Color.fromARGB(250, 37, 36, 36), //获取渐变图片或者默认渐变色
              leading: Builder(builder: (context) {
                // final drawershowchange = context.watch<DrawershowProvider>();
                return IconButton(
                  icon: const Icon(
                    Icons.menu,
                    size: 25,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  onPressed: () {
                    Scaffold.of(widget.contextq).openDrawer();
                  },
                );
              }),
              centerTitle: true,
              // 后续头像上下移
              title: const Center(
                child: Row(),
              ),
              // 后续有无图片 颜色渐变
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://gd-hbimg.huaban.com/f1dfc7bedd4d980f48cb11e76431a7c5aeb601aa2548c-fKlRYm_fw240webp'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // 图片全尺寸显示
                    Positioned.fill(child: Container()),
                    // 从上到下虚化遮罩层
                    Positioned.fill(
                      child: BackdropFilter(
                        filter:
                            ImageFilter.blur(sigmaX: 0, sigmaY: 10), // Y轴上的模糊强度
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 34, 34, 34)
                                .withOpacity(0.6), // 虚化层颜色及透明度
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 50,
                      child: _basemessage,
                    )
                  ],
                ),
              )),
              actions: [
                IconButton(
                    onPressed: openqr(),
                    icon: const Icon(
                      Icons.qr_code_scanner_outlined,
                      size: 20,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    )),
                IconButton(
                    onPressed: share(),
                    icon: const Icon(
                      Icons.share_outlined,
                      size: 20,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    )),
              ],
            ),
            SliverToBoxAdapter(
                child: Container(
              color: Colors.grey[200],
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(children: [
                      15.paddingHeight,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (_currentIndex != 0) {
                                setState(() {
                                  _currentIndex = 0;
                                });
                                _pageController.jumpToPage(0);
                              }
                            },
                            child: Column(
                              children: [
                                Text(
                                  '笔记',
                                  style: _currentIndex == 0
                                      ? const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.5)
                                      : TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 16,
                                          letterSpacing: 0.5),
                                ),
                                _currentIndex == 0
                                    ? SizedBox(
                                        width: 34,
                                        height: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                          40.paddingWidth,
                          GestureDetector(
                            onTap: () {
                              if (_currentIndex != 1) {
                                setState(() {
                                  _currentIndex = 1;
                                });
                                _pageController.jumpToPage(1);
                              }
                            },
                            child: Column(
                              children: [
                                Text(
                                  '收藏',
                                  style: _currentIndex == 1
                                      ? const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.5)
                                      : TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 16,
                                          letterSpacing: 0.5),
                                ),
                                _currentIndex == 1
                                    ? SizedBox(
                                        width: 34,
                                        height: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                          40.paddingWidth,
                          GestureDetector(
                            onTap: () {
                              if (_currentIndex != 2) {
                                setState(() {
                                  _currentIndex = 2;
                                });
                                _pageController.jumpToPage(2);
                              }
                            },
                            child: Column(
                              children: [
                                Text(
                                  '赞过',
                                  style: _currentIndex == 2
                                      ? const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.5)
                                      : TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 16,
                                          letterSpacing: 0.5),
                                ),
                                _currentIndex == 2
                                    ? SizedBox(
                                        width: 34,
                                        height: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          )
                        ],
                      ),
                      15.paddingHeight,
                      SizedBox(
                        height: 1,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.grey[200]),
                        ),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 582,
                    child: PageView(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          child: Center(child: Text('1111')),
                        ),
                        Container(
                          child: Center(child: Text('12221')),
                        ),
                        Container(
                          child: Center(child: Text('1331')),
                        ),
                      ],
                      onPageChanged: (value) {
                        setState(() {
                          _currentIndex = value;
                        });
                      },
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  // 展示个人名片二维码 todo
  personcard() {}
// 关注列表
  attention() {}
// 粉丝详情
  fannum() {}
// 查看获赞与收藏
  checklikefav() {}
// 编辑资料
  editmess() {}
// 系统设置
  opensetting() {}
  // 打开扫一扫
  openqr() {}
  // 分享
  share() {}
  // 打开购物车 todo
  opencar() {}
  // 创作灵感 todo
  create() {}
  // 查看浏览记录 todo
  opensaw() {}
}

// 关注等信息 按钮
class MidNumWidget extends StatelessWidget {
  final int num;
  final String txt;
  final VoidCallback? ontap;

  const MidNumWidget(
      {super.key, required this.num, required this.txt, this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        children: [
          Text(
            num.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          Text(txt, style: TextStyle(color: Colors.grey[300], fontSize: 13))
        ],
      ),
    );
  }
}

// 购物车 浏览记录 等组件
class IconButtonNav extends StatelessWidget {
  final IconData icon;
  final String t1;
  final String t2;
  final VoidCallback? ontap;
  const IconButtonNav(
      {super.key,
      required this.icon,
      required this.t1,
      required this.t2,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Color.fromARGB(39, 245, 245, 245),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 18,
                    color: Colors.white70,
                  ),
                  4.paddingWidth,
                  Text(
                    t1,
                    style: TextStyle(color: Colors.white, letterSpacing: 1),
                  )
                ],
              ),
              2.paddingHeight,
              Text(
                t2,
                style: TextStyle(color: Colors.grey[350], fontSize: 13),
              )
            ]),
      ),
    );
  }
}
