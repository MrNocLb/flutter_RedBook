import 'dart:async';
import 'package:comlogin_sdk/util/allsmallwidget.dart';
import 'package:comlogin_sdk/util/padding_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:sbluebooks/model/Post_model.dart';
import 'package:sbluebooks/util/allsmallutil.dart';

import '../dao/comments_dao.dart';
import '../provider/keyboard_provider.dart';
import '../util/keyboardHeight.dart';

// 点击进入的主要页面
// 判断是否有视频
class MainDetailPage extends StatefulWidget {
  final PostModel model;
  const MainDetailPage({super.key, required this.model});

  @override
  State<MainDetailPage> createState() => _MainDetailPageState();
}

class _MainDetailPageState extends State<MainDetailPage>
    with WidgetsBindingObserver, KeyboardHeight {
  double keyheight = 280.0; //键盘高度 默认高度
  int _swiperindex = 0; //当前轮播页inndex
  bool isShowindex = false; //是否显示第几张
  final timeout = const Duration(seconds: 5); // 设置超时时间为5秒
  double bottompadding = 0; //获取手机是否有刘海屏
  bool isLike = false; //是否喜欢和保存
  String commentcontent = ''; //评论内容
  TextEditingController commentcontentController = TextEditingController();
  bool commentshow = false; //是否发送
  bool isSave = false;
  List<TextSpan> textSpans = []; //标签
  final ScrollController _scrollController = ScrollController();
  late CommentController commentController;
  Timer? _timer;
  List<int> _commentrepliesShow = []; //各个评论展开多少评论
  int commentCount = 0;
  @override
  void keyboardHeight(double height) {
    // 在这里处理键盘高度的变化
    double? hi_keybh = KeyboardProvider().getKeyboardHeight();
    if (height != 0 && hi_keybh == null) {
      setState(() {
        KeyboardProvider().setKeyboardHeight(height);
        // debugPrint('执行了');
        keyheight = height;
      });
    }

    // debugPrint(
    //     '2 keyheight : $keyheight height : $height  hi_keybh  $hi_keybh');
  }

  get _head {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(40.0),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Image.asset(
                widget.model.avatar!,
                fit: BoxFit.fill,
              ),
            )
            // Image.network(
            //   '', //先放着
            //   height: 10,
            //   width: 10,
            // ),
            ),
        10.paddingWidth,
        Text(
          AllSmallUtil.nameToShort(widget.model.username!, 12),
          style: const TextStyle(
              color: Colors.black, fontSize: 14, letterSpacing: 0.3),
          // maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  get _appbar {
    return AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 25,
          ),
          onPressed: () => Navigator.pop(context, widget.model.islikeshow),
        ),
        centerTitle: true,
        title: _head,
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _headaction,
          )
        ],
        // iconTheme: IconThemeData(color: , size: 30),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.8),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: AllsmallWidget.soidwidgt(
                h: 1,
                w: MediaQuery.of(context).size.width,
                color: const Color.fromARGB(255, 232, 229, 229))));
  }

  get _headaction {
    return [
      GestureDetector(
        onTap: () {
          // 在这里添加你的代码
        },
        child: Container(
          width: 65, // 设置按钮的宽度
          height: 30, // 设置按钮的高度
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color.fromARGB(255, 235, 76, 65),
              width: 1.2,
            ),
          ),
          alignment: Alignment.center,
          child: const Text(
            '关注',
            style: TextStyle(
                color: Color.fromARGB(255, 235, 76, 65),
                letterSpacing: 3,
                fontSize: 10,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      // 分享
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.ios_share,
            color: Color.fromARGB(255, 82, 79, 79),
            size: 24,
          )),
      5.paddingWidth
    ];
  }

// 图片和内容组件
  get imgContainer {
    return [
      Stack(
        children: [
          SizedBox(
            // 还是要判断一下图片大小的
            height: MediaQuery.of(context).size.height * 5 / 8,
            child: Swiper(
              itemCount: widget.model.imgurl!.length,
              loop: widget.model.imgurl!.length == 1 ? false : true,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  // 双指放大 todo
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Image.network(
                    widget.model.imgurl![index],
                    fit: BoxFit.fitWidth,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Center();
                    },
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
                        activeColor: const Color.fromARGB(255, 244, 76, 64),
                      ),
                    )
                  : const SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        size: 0,
                        activeSize: 0,
                      ),
                    ),
              onIndexChanged: (value) {
                setState(() {
                  _swiperindex = value + 1;
                  isShowindex = true;
                  _timer = Timer(timeout, () {
                    if (mounted) {
                      setState(() {
                        isShowindex = false;
                      });
                    }
                  });
                });
              },
            ),
          ),
          if (isShowindex)
            Positioned(
                top: 5,
                right: 10,
                child: Container(
                  width: 40,
                  height: 30,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(173, 2, 2, 2),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${_swiperindex.toString()}/${widget.model.imgurl!.length.toString()}',
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.6),
                    ),
                  ),
                )),
        ],
      ),
      5.paddingHeight,
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            Text(
              widget.model.title!,
              style: const TextStyle(
                  fontSize: 16,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            5.paddingHeight,
            // 内容
            Text(
              widget.model.content!,
              style: const TextStyle(
                  color: Color.fromARGB(255, 22, 22, 22),
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w500,
                  height: 1.5),
            ),
            5.paddingHeight,
            // 标签
            RichText(
              // overflow: TextOverflow.ellipsis,
              text: TextSpan(children: textSpans),
            ),
            10.paddingHeight,
            // 时间地点  是否显示可以隐藏
            Text(
              ' ${AllSmallUtil.format(widget.model.date!)} ${widget.model.location}',
              style: const TextStyle(
                  color: Color.fromARGB(255, 103, 102, 102),
                  fontSize: 13,
                  letterSpacing: 1),
            ), // 分割线
            10.paddingHeight,
            Center(
              child: AllsmallWidget.soidwidgt(
                  h: 1,
                  w: MediaQuery.of(context).size.width * 0.95,
                  color: const Color.fromARGB(255, 241, 241, 241)),
            ),
            15.paddingHeight,
            // 后半评论
            ..._contentbottom,
          ],
        ),
      ),
    ];
  }

// 共有多少 评论之后的组件合集
  get _contentbottom {
    return [
      Text(
        '共 ${numcomment(widget.model.comments!) + (commentCount - widget.model.comments!.length)} 条评论',
        style: const TextStyle(
            color: Color.fromARGB(255, 80, 76, 76),
            fontSize: 15,
            letterSpacing: 0.5),
      ),
      8.paddingHeight,
      _comment,
      15.paddingHeight,
    ];
  }

// 中间的评论 组件
  get _comment {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        5.paddingWidth,
        ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: SizedBox(
              width: 30,
              height: 30,
              // 到时候读取账户头像
              child: Image.asset(
                widget.model.avatar!,
                fit: BoxFit.fill,
              ),
            )
            // Image.network(
            //   '', //先放着
            //   height: 10,
            //   width: 10,
            // ),
            ),
        15.paddingWidth,
        Expanded(
          child: GestureDetector(
            onTap: () {
              _textshowdialg(context, ontap: onsend);
            },
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(93, 231, 226, 226),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              height: 35,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 220,
                    child: Text(
                      '   让大家听到你的声音',
                      style: TextStyle(color: Colors.grey),
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
        )
      ],
    );
  }

// 评论文本输入弹窗
  Future<bool?> _textshowdialg(BuildContext context,
      {String hittext = '', VoidCallback? ontap}) async {
    return await showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (BuildContext context, setState) {
                return Column(
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
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                93, 231, 226, 226),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Wrap(
                                                alignment: WrapAlignment.end,
                                                spacing: 4,
                                                children: [
                                                  Container(
                                                    child: TextField(
                                                      maxLines: null,
                                                      // minLines: 1,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      textInputAction:
                                                          TextInputAction
                                                              .newline,
                                                      controller:
                                                          commentcontentController,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          letterSpacing: 1.4,
                                                          height: 1.6,
                                                          color:
                                                              Colors.grey[700]),
                                                      cursorColor: Colors.blue,
                                                      // cursorHeight: 14,
                                                      decoration: InputDecoration(
                                                          focusedBorder: const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  width: 0,
                                                                  color: Colors
                                                                      .transparent)),
                                                          disabledBorder:
                                                              const OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                              0,
                                                                          color: Colors
                                                                              .transparent)),
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                              0,
                                                                          color: Colors
                                                                              .transparent)),
                                                          border: const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  width: 0,
                                                                  color: Colors
                                                                      .transparent)),
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          isCollapsed: true,
                                                          hintText: (hittext !=
                                                                  ''
                                                              ? hittext
                                                              : '让大家听到你的声音')),
                                                      autofocus: true,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          var a =
                                                              commentcontentController
                                                                  .text;
                                                          commentshow =
                                                              value.isNotEmpty;
                                                          debugPrint(
                                                              'content $a');
                                                        });
                                                      },
                                                      onSubmitted:
                                                          (String value) {
                                                        FocusScope.of(context)
                                                            .unfocus(); // 移除焦点
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                    width: 100,
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            debugPrint('1');
                                                          },
                                                          child: const Icon(
                                                            Icons
                                                                .alternate_email,
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
                                                            Icons
                                                                .sentiment_satisfied,
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
                                                            Icons
                                                                .image_outlined,
                                                            size: 23,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        // 10.paddingWidth
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (commentshow)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (ontap != null) {
                                          ontap();
                                          debugPrint('dko');
                                        }
                                        // onsend();
                                        setState(
                                          () {
                                            commentshow = false;
                                          },
                                        );
                                      }
                                      // 发送按钮 事件
                                      ,
                                      child: Container(
                                          width: 55,
                                          height: 35,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              color: Color.fromARGB(
                                                  255, 89, 170, 240)),
                                          child: const Center(
                                            child: Text(
                                              '发送',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  letterSpacing: 0.6),
                                            ),
                                          )),
                                    ),
                                  )
                              ],
                            ),
                            15.paddingHeight,
                            Container(
                              color: Colors.transparent,
                              height: keyheight,
                            ),
                            // SizedBox(height: keyheight),
                            // You can add more widgets here if needed
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ));
  }

// 评论区
// 解决stream 和 singlechild监听问题 stream包在最外面
  get _listcomment {
    return StreamBuilder(
        stream: commentController.commentStreanController.stream,
        builder:
            (BuildContext context, AsyncSnapshot<List<Comments>> snapshot) {
          return snapshot.connectionState == ConnectionState.active
              ? SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      ...imgContainer,
                      // 评论以及回复
                      Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Column(
                              children: List.generate(
                                  snapshot.data!.length,
                                  (index) => InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          debugPrint('555');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, top: 5, bottom: 5),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  child: SizedBox(
                                                    width: 30,
                                                    height: 30,
                                                    // 到时候读取账户头像
                                                    child: Image.asset(
                                                      widget.model.avatar!,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )
                                                  // Image.network(
                                                  //   '', //先放着
                                                  //   height: 10,
                                                  //   width: 10,
                                                  // ),
                                                  ),
                                              15.paddingWidth,
                                              Flexible(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.72,
                                                          child: Column(
                                                            // mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // 文字------------------------------
                                                              Text(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .username!,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      0.5,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              3.paddingHeight,
                                                              Text(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .content!,
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                              ),
                                                              5.paddingHeight,
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    '${AllSmallUtil.format(snapshot.data![index].date!)}  ${snapshot.data![index].location}  ',
                                                                    style: TextStyle(
                                                                        color: Colors.grey[
                                                                            500],
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      replies(snapshot
                                                                          .data![
                                                                              index]
                                                                          .replies![0]);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      // color: Colors.blueAccent,
                                                                      width: 40,
                                                                      height:
                                                                          30,
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          5.paddingWidth,
                                                                          Text(
                                                                            '回复',
                                                                            style:
                                                                                TextStyle(fontSize: 14, color: Colors.grey[800]),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Column(
                                                          children: [
                                                            5.paddingHeight,
                                                            GestureDetector(
                                                              onTap: () {
                                                                debugPrint(DateTime
                                                                        .now()
                                                                    .millisecondsSinceEpoch
                                                                    .toString());
                                                                taplike(snapshot
                                                                    .data![
                                                                        index]
                                                                    .like);
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .favorite_border_outlined,
                                                                color: Colors
                                                                    .grey[800],
                                                              ),
                                                            ),
                                                            Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .like
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            )
                                                          ],
                                                        ),
                                                        15.paddingWidth
                                                      ],
                                                    ),
                                                    10.paddingHeight,
                                                    Column(
                                                        children: List.generate(
                                                            _commentrepliesShow[
                                                                index],
                                                            (e) => commentsWidget(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .replies![e]))),
                                                    if (snapshot.data![index]
                                                            .replies!.length >
                                                        1)
                                                      GestureDetector(
                                                        onTap: () =>
                                                            showRepiles(
                                                                snapshot.data!,
                                                                index),
                                                        child: Row(
                                                          children: [
                                                            35.paddingWidth,
                                                            if (snapshot
                                                                        .data![
                                                                            index]
                                                                        .replies!
                                                                        .length -
                                                                    _commentrepliesShow[
                                                                        index] !=
                                                                0)
                                                              Text(
                                                                  (snapshot.data![index].replies!.length -
                                                                              1) !=
                                                                          snapshot.data![index].replies!.length -
                                                                              _commentrepliesShow[
                                                                                  index]
                                                                      ? '展开更多'
                                                                      : '展开${snapshot.data![index].replies!.length - _commentrepliesShow[index]}条评论',
                                                                  style: const TextStyle(
                                                                      color: Color.fromARGB(
                                                                          192,
                                                                          3,
                                                                          57,
                                                                          104),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          13,
                                                                      letterSpacing:
                                                                          0.8)),
                                                          ],
                                                        ),
                                                      ),
                                                    5.paddingHeight,
                                                    AllsmallWidget.soidwidgt(
                                                        h: 0.9,
                                                        w: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        color: const Color
                                                                .fromARGB(255,
                                                            228, 227, 227)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )))),
                      if (commentCount ==
                          commentController.initialCommentsList.length)
                        SizedBox(
                          height: 80,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '- THE END -',
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                  letterSpacing: 0.6),
                            ),
                          ),
                        )
                    ],
                    // ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 118, 118, 118),
                  ),
                );
        });
  }

// 回复组件
  Widget commentsWidget(Replies model) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        debugPrint('555');
      },
      child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      // 到时候读取账户头像
                      child: Image.asset(
                        widget.model.avatar!,
                        fit: BoxFit.fill,
                      ),
                    )
                    // Image.network(
                    //   '', //先放着
                    //   height: 10,
                    //   width: 10,
                    // ),
                    ),
                10.paddingWidth,
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.72 - 35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.username!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          letterSpacing: 0.5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      3.paddingHeight,
                      Text(
                        model.content!,
                        style:
                            const TextStyle(fontSize: 15, letterSpacing: 0.5),
                      ),
                      // 5.paddingHeight,
                      Row(
                        children: [
                          Text(
                            '${AllSmallUtil.format(model.date!)}  ${model.location}  ',
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              replies(model);
                            },
                            child: Container(
                              // color: Colors.blueAccent,
                              width: 40,
                              height: 30,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  5.paddingWidth,
                                  Text(
                                    '回复',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[800]),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      5.paddingHeight,
                    ],
                  ),
                ),
                Column(
                  children: [
                    5.paddingHeight,
                    GestureDetector(
                      onTap: () {
                        debugPrint(
                            DateTime.now().millisecondsSinceEpoch.toString());
                      },
                      child: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      model.like.toString(),
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ],
            )
          ]),
    );
  }

// 点击事件没加
  get _bottom {
    return Container(
      height: 40 + bottompadding,
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(color: Color.fromARGB(255, 241, 241, 241)))),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            5.paddingWidth,
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _textshowdialg(context, ontap: onsend);
                },
                child: Container(
                  height: 33,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(105, 218, 214, 214),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Row(
                    children: [
                      10.paddingWidth,
                      const Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 156, 153, 153),
                        size: 20,
                      ),
                      5.paddingWidth,
                      Text(
                        '说点什么...',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      )
                    ],
                  ),
                ),
              ),
            ),
            5.paddingWidth,
            GestureDetector(
              onTap: () {
                if (!widget.model.islikeshow!) {
                  setState(() {
                    widget.model.islikeshow = true;
                    widget.model.like = widget.model.like! + 1;
                  });
                } else {
                  setState(() {
                    widget.model.islikeshow = false;
                    widget.model.like = widget.model.like! - 1;
                  });
                }
              },
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                !widget.model.islikeshow!
                    ? const Icon(
                        Icons.favorite_border_outlined,
                        size: 25,
                      )
                    : Icon(
                        Icons.favorite,
                        color: Colors.red[600],
                        size: 25,
                      ),
                2.paddingWidth,
                Text(
                  AllSmallUtil.intToShort(widget.model.like!),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color.fromARGB(198, 0, 0, 0)),
                )
              ]),
            ),
            5.paddingWidth,
            GestureDetector(
              onTap: () {
                if (!isSave!) {
                  setState(() {
                    isSave = true;
                    // 发送收藏请求 并做节流处理 todo
                    widget.model.favorite = widget.model.favorite! + 1;
                  });
                } else {
                  setState(() {
                    isSave = false;
                    widget.model.favorite = widget.model.favorite! - 1;
                  });
                }
              },
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                !isSave
                    ? const Icon(
                        Icons.star_border_rounded,
                        size: 30,
                      )
                    : Icon(
                        Icons.star_rate_rounded,
                        color: Colors.yellow[600],
                        size: 30,
                      ),
                2.paddingWidth,
                Text(
                  AllSmallUtil.intToShort(widget.model.favorite!),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color.fromARGB(198, 0, 0, 0)),
                )
              ]),
            ),
            5.paddingWidth,
            GestureDetector(
              onTap: () {
                _textshowdialg(context, ontap: onsend);
              },
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                const Icon(
                  Icons.sms_outlined,
                  size: 25,
                ),
                2.paddingWidth,
                Text(
                  AllSmallUtil.intToShort(numcomment(widget.model.comments!) +
                      (commentCount - widget.model.comments!.length)),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color.fromARGB(198, 0, 0, 0)),
                )
              ]),
            ),
            5.paddingWidth
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    doInit();
  }

  @override
  void dispose() {
    _timer?.cancel();
    TapGestureRecognizer().dispose();
    commentController.dispose();
    textSpans.clear();
    commentcontentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).padding.bottom == 0) {
      bottompadding = 10;
    } else {
      bottompadding = MediaQuery.of(context).padding.bottom;
    }
    for (var i = 0; i < widget.model.tag!.length; i++) {
      textSpans.add(
        TextSpan(
          text: '#${widget.model.tag![i]} ',
          style: const TextStyle(
              color: Color.fromRGBO(45, 87, 139, 1),
              fontSize: 13,
              letterSpacing: 1,
              fontWeight: FontWeight.w600),
          recognizer: TapGestureRecognizer()
            ..onTap = () => tagjeepPage(widget.model.tag![i]),
        ),
      );
    }

    return Scaffold(
      appBar: _appbar,
      body: _listcomment,
      bottomNavigationBar: _bottom,
    );
  }

  // 初始化函数
  void doInit() async {
    // _timer = Timer(timeout, () {
    //   setState(() {
    //     isShowindex = false;
    //   });
    // });
    commentCount = widget.model.comments!.length;
    commentController = CommentController(
        initialCommentsList: [],
        // widget.model.comments!
        scrollController: _scrollController);
    // 实际开发进入要先发送接口处理数据
    commentController.widgetReady();
    // 获取分页
    var list = await commentController.getPageData(
        pageSize: 10, initialCommentsList: widget.model.comments!);
    commentController.loadMoreData(list);
    // 下拉获取分页评论
    // 可能要更换请求结构
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);
        debugPrint('已刷新');
      }
    });
    createListReplie(widget.model.comments!);
  }

  // 标签跳转
  void tagjeepPage(String url) {
    // todo
    debugPrint(url);
    // debugPrint('${DateTime.now().millisecondsSinceEpoch}');
  }

  //第一次 构造展示多少回复列表
  createListReplie(List<Comments> model) {
    List<int> temp = List<int>.filled(model.length, 0); // 初始化列表长度
    for (var i = 0; i < model.length; i++) {
      if (model[i].replies!.length != 0) {
        temp[i] = 1;
      }
    }
    setState(() {
      _commentrepliesShow = temp;
    });
  }

  // 计算评论数量包括回复
  int numcomment(List<Comments> model) {
    var c = 0;
    c = model.length;
    for (var i = 0; i < model.length; i++) {
      c = c + model[i].replies!.length;
    }
    return c;
  }

// 是否展开评论逻辑
  void showRepiles(List<Comments> model, int index) {
    if (model![index].replies!.length - _commentrepliesShow[index] - 1 > 4) {
      setState(() {
        _commentrepliesShow[index] = _commentrepliesShow[index] + 5;
      });
    } else {
      setState(() {
        _commentrepliesShow[index] = model![index].replies!.length;
      });
    }
  }

  int pageIndex = 1;
  // 要下拉刷新就传true 无传则不更新数据只返回分页list
  Future<List<Comments>> _loadData({loadMore = false}) async {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    var list = await commentController.getPageData(
        pageSize: 10,
        pageIndex: pageIndex,
        initialCommentsList: widget.model.comments!);
    if (loadMore) {
      if (list.isNotEmpty) {
        commentController.loadMoreData(list);
      } else {
        // 如果没有更多数据则回退
        pageIndex--;
      }
    }
    // var a = commentController.initialCommentsList.length;
    // var b = commentCount;
    // debugPrint(
    //     'commentController.initialCommentsList.length $a  widget.model.comments!.length  $b ');
    return list;
  }

  // 发送评论
  void onsend() async {
    String content = commentcontentController.text;
    commentcontentController.clear();
    FocusScope.of(context).unfocus(); // 移除焦点
    Navigator.of(context).pop();
    var temp = Comments(
        avatar: 'assets/images/tx.jpg',
        username: '到时候获取',
        like: 0,
        isWrite: false,
        isTop: false,
        islikewirte: false,
        content: content,
        date: DateTime.now().millisecondsSinceEpoch,
        location: '浙江',
        replies: []);
    // 是否成功在执行
    setState(() {
      commentCount = commentCount + 1;
      _commentrepliesShow = [0, ..._commentrepliesShow];
    });
    // ui层添加评论
    // 重新对评论数 赋值 可能后续有bug
    commentController.addComments(temp);
    // 接口层发送 todo
  }

  // 回复
  replies(Replies model) async {
    // ui层
    String temp = model.username ?? "";
    // 弹出 评论框  给个加载接口
    _textshowdialg(
      context,
      hittext: '回复: @$temp',
      ontap: () {
        // todo
      },
    );
    // 接口层 todo
  }

  // 点赞
  void taplike(int? like) async {
    // 数据设计有问题 先不写 对于评论是否点赞这个状态值是否需要
  }
}
