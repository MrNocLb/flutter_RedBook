import 'package:cached_network_image/cached_network_image.dart';
import 'package:comlogin_sdk/util/navigator_util.dart';
import 'package:comlogin_sdk/util/padding_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:sbluebooks/model/Commodity_model.dart';
import 'package:sbluebooks/pages/shopping_search_page.dart';
import 'package:sbluebooks/util/allsmallutil.dart';

class ShoppingDetailPage extends StatefulWidget {
  final CommodityModel model;
  const ShoppingDetailPage({super.key, required this.model});

  @override
  State<ShoppingDetailPage> createState() => _ShoppingDetailPageState();
}

class _ShoppingDetailPageState extends State<ShoppingDetailPage> {
  int _topindex = 0;
  late Size imgh;
  final ScrollController scrollController = ScrollController();
  int _opacity = 0;
  GlobalKey barKey = GlobalKey(); // 在改变颜色的时候 这个方式不会卡顿
  late Future getimg;
  get _top {
    return Positioned(
        top: 0,
        child: IgnorePointer(
          ignoring: _opacity > 230 ? true : false, //上下层事件穿透控制
          child: AnimatedOpacity(
            duration: Duration(seconds: 0), // 动画持续时间
            curve: Curves.easeIn, // 动画曲线
            opacity: 1 - (_opacity / 255),

            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              color: Color.fromARGB(_opacity, 255, 255, 255),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: MediaQuery.of(context).padding.top + 2,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            iconround(
                                Icons.navigate_before, Colors.white, navback)
                          ],
                        ),
                        Row(
                          children: [
                            iconround(Icons.search, Colors.white, search),
                            10.paddingWidth,
                            iconround(Icons.star_border_outlined, Colors.white,
                                addlike),
                            10.paddingWidth,
                            iconround(Icons.share_outlined, Colors.white, share)
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  get _top2 {
    return Positioned(
        top: 0,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: AnimatedOpacity(
            opacity: _opacity / 255,
            duration: const Duration(seconds: 0), // 动画持续时间
            curve: Curves.easeIn, // 动画曲线
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              decoration: BoxDecoration(
                  color: Color.fromARGB(_opacity, 255, 255, 255),
                  border: const Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 218, 218, 218)))),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: MediaQuery.of(context).padding.top,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            iconround(
                                Icons.navigate_before, Colors.grey, navback,
                                roundc: Colors.transparent)
                          ],
                        ),
                        Expanded(
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                5.paddingWidth,
                                Icon(
                                  Icons.search,
                                  color: Colors.grey[500],
                                  size: 20,
                                ),
                                5.paddingWidth,
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      NavigatorUtil.push(
                                          context, ShoppingSearchPage());
                                    },
                                    child: TextField(
                                      enabled: false,
                                      style: const TextStyle(fontSize: 15),
                                      // controller: textEditingController,
                                      cursorColor: Colors.red,
                                      textInputAction: TextInputAction.search,
                                      decoration: InputDecoration(
                                        // contentPadding: EdgeInsets.only(bottom: 0),
                                        hintText:
                                            '男士穿搭', //后面换成接口根据账号随机返回关键字 按时间随便更新
                                        hintStyle: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 15),
                                        border: InputBorder.none,
                                        // contentPadding: EdgeInsets.all(1),
                                      ),
                                      // 点击时跳转到页面或者更换
                                    ),
                                  ),
                                ),
                                8.paddingWidth
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            iconround(Icons.share_outlined, Colors.grey, share1,
                                roundc: Colors.transparent)
                          ],
                        )
                      ],
                    ),
                    14.paddingHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (_topindex != 0) {
                              setState(() {
                                _topindex = 0;
                              });
                              // _pageController.jumpToPage(0);
                            }
                          },
                          child: Column(
                            children: [
                              Text(
                                '商品',
                                style: _topindex == 0
                                    ? const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        letterSpacing: 0.8,
                                        fontWeight: FontWeight.w600)
                                    : const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        letterSpacing: 0.8,
                                      ),
                              ),
                              3.paddingHeight,
                              _topindex == 0
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
                        15.paddingWidth,
                        GestureDetector(
                          onTap: () {
                            if (_topindex != 1) {
                              setState(() {
                                _topindex = 1;
                              });
                              // _pageController.jumpToPage(0);
                            }
                          },
                          child: Column(
                            children: [
                              Text(
                                '评价',
                                style: _topindex == 1
                                    ? const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        letterSpacing: 0.8,
                                        fontWeight: FontWeight.w600)
                                    : const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        letterSpacing: 0.8,
                                      ),
                              ),
                              3.paddingHeight,
                              _topindex == 1
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
                        15.paddingWidth,
                        GestureDetector(
                          onTap: () {
                            if (_topindex != 2) {
                              setState(() {
                                _topindex = 2;
                              });
                              // _pageController.jumpToPage(0);
                            }
                          },
                          child: Column(
                            children: [
                              Text(
                                '详细',
                                style: _topindex == 2
                                    ? const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        letterSpacing: 0.8,
                                        fontWeight: FontWeight.w600)
                                    : const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        letterSpacing: 0.8,
                                      ),
                              ),
                              3.paddingHeight,
                              _topindex == 2
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
                        15.paddingWidth,
                        GestureDetector(
                          onTap: () {
                            if (_topindex != 3) {
                              setState(() {
                                _topindex = 3;
                              });
                              // _pageController.jumpToPage(0);
                            }
                          },
                          child: Column(
                            children: [
                              Text(
                                '推荐',
                                style: _topindex == 3
                                    ? const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        letterSpacing: 0.8,
                                        fontWeight: FontWeight.w600)
                                    : const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        letterSpacing: 0.8,
                                      ),
                              ),
                              3.paddingHeight,
                              _topindex == 3
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
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  get _main {
    return Positioned(
      top: 0,
      child: GestureDetector(
        // behavior: HitTestBehavior.translucent, //使上层组件事件穿透
        child: Container(
          color: const Color.fromRGBO(246, 246, 246, 1),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 70,
          child: Column(
            children: [
              Expanded(
                child: NotificationListener(
                  onNotification: (ScrollNotification notification) {
                    ScrollMetrics metrics = notification.metrics;
                    int extentBefore = metrics.extentBefore.toInt();
                    if (extentBefore <= 200) {
                      _opacity =
                          extentBefore >= 200 ? 255 : extentBefore * 255 ~/ 200;
                      onChange(_opacity);
                    }
                    return true;
                  },
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(children: [
                      // 图片组件
                      _imgwidget,
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                        ),
                        child: Column(children: [
                          // 商品信息组件
                          _shopmessage, 10.paddingHeight,
                          // 保证发货信息组件
                          _sendmessage, 10.paddingHeight,
                          // 评论
                          _comments, 10.paddingHeight,
                          // 店铺信息
                          _storemess, 10.paddingHeight,
                          // 卖家笔记
                          _shoppingnote, 10.paddingHeight,
                          // 图文详细
                          _imgtextdetail, 10.paddingHeight,
                          // ....
                        ]),
                      ),
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

// main 中的各种组件
  get _imgwidget {
    // Size h = await AllSmallUtil.getImageDimensions(widget.model.imgurl![0]);
    return FutureBuilder(
        future: getimg,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: // 数据正在加载
              return const SizedBox(
                height: 500,
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.red,
                )),
              ); // 显示加载指示器
            case ConnectionState.done: // 数据加载完成
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final Size imghh = snapshot.data!;
                return SizedBox(
                  height: MediaQuery.of(context).size.width /
                      (imghh.width / imghh.height),
                  // height: imgh.height,
                  child: Swiper(
                    itemCount: widget.model.imgurl!.length,
                    loop: widget.model.imgurl!.length == 1 ? false : true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        // 双指放大 todo
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Image.network(
                          widget.model.imgurl![index],
                          fit: BoxFit.fitWidth,
                        ),
                      );
                    },
                    pagination: widget.model.imgurl!.length != 1
                        ? SwiperPagination(
                            alignment: Alignment.bottomCenter,
                            margin: const EdgeInsets.only(top: 20.0),
                            builder: DotSwiperPaginationBuilder(
                              size: 6,
                              activeSize: 6,
                              color: Colors.grey[300],
                              activeColor:
                                  const Color.fromARGB(255, 244, 76, 64),
                            ),
                          )
                        : const SwiperPagination(
                            builder: DotSwiperPaginationBuilder(
                              size: 0,
                              activeSize: 0,
                            ),
                          ),
                    onIndexChanged: (value) {
                      setState(() {});
                    },
                  ),
                );
              }
            default:
              return SizedBox.shrink(); // 或其他占位Widget
          }
        });
  }

  get _shopmessage {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 138, 138, 138),
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(254, 192, 203, 1),
                      Color.fromARGB(219, 255, 240, 239),
                      Colors.white
                    ])),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            '￥',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Colors.red),
                          ),
                          Text(
                            '${widget.model.price}',
                            style: const TextStyle(
                                fontSize: 22,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w600,
                                color: Colors.red),
                          ),
                        ],
                      ),
                      const Text(
                        '新客专享 平台补贴 ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),

                      // 占位
                    ],
                  ),
                  // 5.paddingHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 平台新课补贴15元 .....标签
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4),
                            ),
                            border: Border.all(width: 1, color: Colors.red)),
                        child: const Text(
                          ' 平台新课补贴10元 ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 249, 37, 22),
                              fontSize: 11),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.navigate_next,
                            color: Colors.grey[500],
                            size: 14,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.model.name.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  letterSpacing: 0.9,
                  fontSize: 15,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 3,
              ),
              5.paddingHeight,
              // 后面用个 ...[]传递标签
              Row(
                children: [
                  Text(
                    '已售 ${widget.model.buyed}  |  ${2000}+人加购 ',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  )
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }

  get _sendmessage {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 138, 138, 138),
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        '保障  ',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            letterSpacing: 0.3),
                      ),
                      if (widget.model.safeguard! == 1)
                        const Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 14,
                            ),
                            Text(
                              ' 退货包运费  ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  letterSpacing: 0.3),
                            ),
                            Icon(
                              Icons.check_circle_outline,
                              size: 14,
                            ),
                            Text(
                              ' 7天无理由退货  ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  letterSpacing: 0.3),
                            )
                          ],
                        )
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.navigate_next,
                        color: Colors.grey[500],
                        size: 14,
                      ))
                ],
              ),
              8.paddingHeight,
              Row(
                children: [
                  const Text(
                    '发货  ',
                    style: TextStyle(
                        fontSize: 14, color: Colors.black, letterSpacing: 0.3),
                  ),
                  if (widget.model.ishave! > 0)
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(2),
                          ),
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 118, 118, 118))),
                      child: const Text(
                        ' 现货 ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  Text(
                    '  48小时内从发货${widget.model.location} ',
                    style: const TextStyle(
                        fontSize: 13, color: Colors.black, letterSpacing: 0.3),
                  ),
                  if (widget.model.sendshow == 0)
                    const Text('| 包邮',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            letterSpacing: 0.3))
                ],
              )
            ]),
      ),
    );
  }

  get _comments {
    return GestureDetector(
      onTap: () {},
      child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 138, 138, 138),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 8, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '商品评论 (${widget.model.evaluates!.length})',
                  style: const TextStyle(
                      fontSize: 14, color: Colors.black, letterSpacing: 0.3),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.navigate_next,
                          color: Colors.grey[500],
                          size: 14,
                        ))
                  ],
                )
              ],
            ),
          )),
    );
  }

  get _storemess {
    return GestureDetector(
      onTap: () {},
      child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 138, 138, 138),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, bottom: 8, top: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            child: CachedNetworkImage(
                              width: 50,
                              height: 50,
                              imageUrl: widget.model.store!.avatar ?? '',
                              fit: BoxFit.fill,
                            ),
                          ),
                          10.paddingWidth,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.model.store!.name.toString(),
                                style: const TextStyle(fontSize: 12),
                              ),
                              4.paddingHeight,
                              Row(
                                children: [
                                  Text(
                                    '粉丝 ',
                                    style: TextStyle(
                                        color: Colors.grey[500], fontSize: 12),
                                  ),
                                  Text(
                                    widget.model.store!.fan.toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  5.paddingWidth,
                                  Text(
                                    '已售 ',
                                    style: TextStyle(
                                        color: Colors.grey[500], fontSize: 12),
                                  ),
                                  Text(
                                    widget.model.store!.allbuyed.toString(),
                                    style: const TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                              4.paddingHeight,
                              Row(
                                children: [
                                  Container(
                                    decoration:
                                        BoxDecoration(color: Colors.grey[200]),
                                    child: const Text(
                                      ' 卖家口碑 ',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  Text(
                                    '  ${widget.model.store!.gradestore.toString()}分 ',
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: 50,
                        height: 25,
                        decoration: BoxDecoration(
                            color: Colors.red[400],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: const Center(
                          child: Text(
                            ' 进店 ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                letterSpacing: 0.8),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 400,
                    height: 180,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.model.store!.commodity!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  5.paddingHeight,
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: CachedNetworkImage(
                                      width: 120,
                                      height: 120,
                                      imageUrl: widget
                                          .model.store!.commodity![index].img
                                          .toString(),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  4.paddingHeight,
                                  Text(
                                    widget.model.store!.commodity![index].name
                                        .toString(),
                                    maxLines: 1,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 11),
                                  ),
                                  Text(
                                    '￥${widget.model.store!.commodity![index].price}',
                                    style: const TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ))),
    );
  }

  get _shoppingnote {
    return GestureDetector(
      onTap: () {},
      child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 138, 138, 138),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, bottom: 8, top: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '卖家笔记',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            letterSpacing: 0.3),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.navigate_next,
                                color: Colors.grey[500],
                                size: 14,
                              ))
                        ],
                      )
                    ],
                  )
                ],
              ))),
    );
  }

  get _imgtextdetail {
    return GestureDetector(
      onTap: () {},
      child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 138, 138, 138),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 10, top: 10),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '图文详细',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            letterSpacing: 0.3),
                      ),
                    ],
                  ),
                  // 循环把 图文介绍 放入组件
                  ...List.generate(0, (index) {
                    return SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: CachedNetworkImage(
                          imageUrl: '',
                          fit: BoxFit.fitWidth,
                        ));
                  })
                ],
              ))),
    );
  }

  get _bottom {
    return Positioned(
        bottom: 0,
        child: Container(
          decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(
                      width: 1, color: Color.fromARGB(186, 229, 229, 229)))),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 11,
          // color: Colors.blue,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 18, right: 18, bottom: 10, top: 10),
            child: Row(
              children: [
                IconButtonNav(
                  isavatar: true,
                  avatarurl: widget.model.store!.avatar,
                  icon: Icons.abc,
                  t1: '店铺',
                  ontap: gotoshop,
                ),
                20.paddingWidth,
                IconButtonNav(
                  icon: Icons.support_agent_outlined,
                  t1: '客服',
                  ontap: linkshop,
                ),
                20.paddingWidth,
                IconButtonNav(
                  icon: Icons.shopping_cart_outlined,
                  t1: '购物车',
                  ontap: buycar,
                ),
                20.paddingWidth,
                Expanded(
                  child: Container(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(60),
                                      bottomLeft: Radius.circular(60)),
                                  color: Color.fromRGBO(254, 242, 242, 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '加入购物车',
                                  style: TextStyle(
                                      color: Colors.red[600],
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.8,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(60),
                                    bottomRight: Radius.circular(60)),
                                color: Color.fromRGBO(255, 36, 66, 1),
                              ),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '立即购买',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.8,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget iconround(IconData icon, Color color, VoidCallback? ontap,
      {Color? roundc = const Color.fromARGB(23, 38, 38, 38)}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              color: roundc),
          child: Center(
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [_main, _top2, _top, _bottom],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _doinit();
  }

  Future<Size> _getImageSize() async {
    final url = widget.model.imgurl![0];
    return AllSmallUtil.getImageDimensions(url);
  }

  _doinit() async {
    getimg = _getImageSize(); //避免重复刷新
  }

  void onChange(int alpha) {
    setState(() {
      _opacity = alpha;
    });
  }

// 顶部点击事件 组件加括号会直接运行
  navback() {
    Navigator.pop(context);
  }

  search() {
    NavigatorUtil.push(context, ShoppingSearchPage());
  }

  addlike() {
    debugPrint('222');
  }

  share() {
    debugPrint('11');
  }

  share1() {
    debugPrint('12323');
  }

// 底部点击事件
  gotoshop() {
    debugPrint('22');
  }

  linkshop() {}

  buycar() {}
}

// 购物车 浏览记录 等组件
class IconButtonNav extends StatelessWidget {
  final IconData icon;
  final bool isavatar;
  String? avatarurl;
  final String t1;
  final VoidCallback? ontap;
  IconButtonNav(
      {super.key,
      required this.icon,
      required this.t1,
      this.ontap,
      this.isavatar = false,
      this.avatarurl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isavatar
                ? ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: CachedNetworkImage(
                      width: 25,
                      height: 25,
                      imageUrl: avatarurl ?? '',
                      fit: BoxFit.fill,
                    ),
                  )
                : Icon(
                    icon,
                    size: 25,
                    color: Colors.grey[800],
                  ),
            2.paddingHeight,
            Text(
              t1,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 10,
              ),
            )
          ]),
    );
  }
}
