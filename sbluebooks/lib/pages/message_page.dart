// 消息页面
import 'dart:async';
import 'dart:core';
import 'package:comlogin_sdk/util/padding_extension.dart';
import 'package:flutter/material.dart';
import 'package:sbluebooks/model/Message_model.dart';
import 'package:sbluebooks/model/Post_model.dart';
import 'package:sbluebooks/util/allsmallutil.dart';

import '../model/FindFre_model.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return const MyTextField();
  }
}

class MyTextField extends StatefulWidget {
  const MyTextField({super.key});

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  // mock 发现更多好友  后续作为templist
  final List<FindfrendModel> _FindFrendList = [
    FindfrendModel(
        avatar:
            'https://gd-hbimg.huaban.com/7502b9c5e5dcb9e229f4719752777d0474f6a45315c75f-6vU7Ue_fw240webp',
        username: '小李',
        life: '近一周活跃',
        comfrecount: 1,
        notecount: 1,
        page: '?'),
    FindfrendModel(
        avatar:
            'https://gd-hbimg.huaban.com/50c9c9dcda80ac6f27e4b2eb94b252d0f247f3054a0e1-zs6HUn_fw240webp',
        username: '小张',
        life: '近一个月活跃',
        comfrecount: 1,
        notecount: 1,
        page: '?'),
    FindfrendModel(
        avatar:
            'https://gd-hbimg.huaban.com/3353d7a81b9b63c2f3e04af138641e52e970d24c8db1e-66q6dt_fw240webp',
        username: '小罗',
        life: '',
        comfrecount: 1,
        notecount: 1,
        page: '?')
  ];
  final List<MessageModel> _MessageList = [
    MessageModel(
      cid: 1,
      avatar:
          'https://gd-hbimg.huaban.com/0d17ee0a16996feac314a1a99ccfc097ea41926021292-08tmTY_fw658webp',
      username: '消息通知',
      date: DateTime.now().millisecondsSinceEpoch - 1000000,
      lastMessage: '活动通知:用调色盘让最后一缕纯色行动起来！',
      messageCount: 1,
    ),
    MessageModel(
      cid: 2,
      avatar:
          'https://gd-hbimg.huaban.com/58afd697517e35eb71a2d869bd2efe40b47804d8e6549-qxxOI9_fw658webp',
      username: '作者助手',
      date: DateTime.now().millisecondsSinceEpoch - 10000,
      lastMessage: '欢迎来到小红书撒的谎哦啊收到后三年方法',
      messageCount: 1,
    ),
    MessageModel(
      cid: 3,
      avatar:
          'https://gd-hbimg.huaban.com/34510bc6491d9efd2f58940ad9373f7672c565e517a6e-yEVbHA_fw658webp',
      username: '不吃鱼的狗',
      date: DateTime.now().millisecondsSinceEpoch - 10000,
      lastMessage: '在吗',
      messageCount: 1,
    )
  ];

  bool findfriendsshow = true;
  StreamController<List<PostModel>> streammess = StreamController();
  final ScrollController _scrollController = ScrollController();
  get _body {
    return Column(
      children: [
        35.paddingHeight,
        _notice,
        _message,
        20.paddingHeight,
        if (findfriendsshow) _findmore
      ],
    );
  }

  // 通知 部分
  get _notice {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '消息',
                    style: TextStyle(
                        color: Color.fromARGB(201, 37, 37, 37),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6),
                  ),
                ],
              ),
            ),
            Positioned(
                // top: 0,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    findgroup();
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.group_outlined,
                        color: Color.fromARGB(225, 0, 0, 0),
                        size: 26,
                      ),
                      // 1.paddingWidth,
                      Text('发现群聊',
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 13,
                              letterSpacing: 0.6))
                    ],
                  ),
                ))
          ],
        ),
        35.paddingHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icontxt(
                color: Colors.red,
                icon: Icons.favorite,
                ontap: () {
                  likeastar();
                },
                title: '赞和收藏'),
            icontxt(
                color: Colors.blue,
                icon: Icons.person,
                ontap: () {
                  newlike();
                },
                title: '新增关注'),
            icontxt(
                color: Colors.green,
                icon: Icons.chat_bubble,
                ontap: () {
                  commentandat();
                },
                title: '评论和@'),
          ],
        ),
        20.paddingHeight
      ],
    );
  }

  // 消息 部分
  get _message {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
          children: List.generate(_MessageList.length,
              (index) => messagelist(_MessageList[index], index))),
    );
  }

  // 发现更多 部分
  get _findmore {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '发现更多好友',
                    style: TextStyle(
                        color: Colors.black, letterSpacing: 0.8, fontSize: 15),
                  ),
                  3.paddingWidth,
                  GestureDetector(
                    onTap: () {
                      // 弹出提示
                    },
                    child: Icon(
                      Icons.info_outline,
                      size: 18,
                      color: Colors.grey[400],
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    // 后续修改 这个关了一阵子不会出现 todo
                    findfriendsshow = false;
                  });
                },
                child: const Text(
                  '关闭',
                  style: TextStyle(
                      color: Color.fromARGB(255, 162, 160, 160),
                      letterSpacing: 0.8,
                      fontSize: 15),
                ),
              ),
            ],
          ),
          Column(
              children: List.generate(_FindFrendList.length,
                  (index) => findmore(_FindFrendList[index], index)))
          // ListView.builder(
          //     itemCount: _FindFrendList.length,
          //     itemBuilder: (context, index) {
          //       return findmore(_FindFrendList[index]);
          //     })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: streammess.stream,
          builder:
              (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
            return SingleChildScrollView(
              controller: _scrollController,
              child: _body,
            );
          }),
    );
  }

// 消息页面简略版
  Widget messagelist(MessageModel model, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 0),
      child: GestureDetector(
        onTap: () {
          messagedetail();
        },
        child: SizedBox(
          // color: Colors.cyan,
          height: 70,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    // border: Border.all(width: 1, color: Colors.grey)
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(191, 0, 0, 0)
                            .withOpacity(0.1), // 阴影颜色
                        spreadRadius: 1, // 阴影扩散半径
                        blurRadius: 1, // 阴影模糊半径
                        // offset: Offset(0, 3), // 阴影偏移量
                      ),
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.network(
                      model.avatar!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              10.paddingWidth,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.username!,
                      style: const TextStyle(fontSize: 16, letterSpacing: 0.8),
                    ),
                    4.paddingHeight,
                    Text('${model.lastMessage}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            letterSpacing: 0.6)),
                  ],
                ),
              ),
              Column(
                children: [
                  15.paddingHeight,
                  Text(
                    AllSmallUtil.format(model.date!),
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        letterSpacing: 0.6),
                  )
                  // 是否有红点或者 红标 不清楚逻辑先不用
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

// 点击跳转 个人详情界面 以及关注按钮
  Widget findmore(FindfrendModel model, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 0),
      child: GestureDetector(
        onTap: () {
          morefredetial();
        },
        child: SizedBox(
          // color: Colors.cyan,
          height: 70,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    // border: Border.all(width: 1, color: Colors.grey)
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(191, 0, 0, 0)
                            .withOpacity(0.1), // 阴影颜色
                        spreadRadius: 1, // 阴影扩散半径
                        blurRadius: 1, // 阴影模糊半径
                        // offset: Offset(0, 3), // 阴影偏移量
                      ),
                    ]),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.network(
                        model.avatar!,
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              10.paddingWidth,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.username!,
                      style: TextStyle(fontSize: 14, letterSpacing: 0.6),
                    ),
                    Row(
                      children: [
                        Text('有${model.comfrecount}个共同联系人 | ',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                letterSpacing: 0.6)),
                        (model.life!.length > 0)
                            ? Text(model.life!,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                    letterSpacing: 0.6))
                            : Text('${model.notecount}篇笔记',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                    letterSpacing: 0.6))
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // 在这里添加你的代码
                },
                child: Container(
                  width: 55, // 设置按钮的宽度
                  height: 25, // 设置按钮的高度
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color.fromARGB(255, 236, 101, 92),
                      width: 0.6,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '关注',
                    style: TextStyle(
                        color: Color.fromARGB(255, 242, 89, 79),
                        letterSpacing: 3,
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              10.paddingWidth,
              GestureDetector(
                  onTap: () {
                    closefind(index);
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.grey[400],
                    size: 16,
                  ))
            ],
          ),
        ),
      ),
    );
  }

// 关闭单个发现更多好友
  void closefind(int e) {
    setState(() {
      _FindFrendList.removeAt(e);
    });
  }

  // 发现群聊 todo
  void findgroup() {}
  // 赞和收藏 todo
  void likeastar() {}
  //新增关注 todo
  void newlike() {}
  // 评论和@ todo
  void commentandat() {}
  // 点击头像进入个人主页 todo
  void morefredetial() {}
  // 点击消息详情页面 todo
  void messagedetail() {}
}

// 三个不同颜色按钮组件  后续将颜色换成图片
Widget icontxt(
    {required IconData icon,
    required String title,
    required Function ontap,
    required Color color}) {
  return GestureDetector(
    onTap: () {
      ontap();
    },
    child: Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 55,
            height: 55,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                gradient: RadialGradient(
                    colors: [color.withOpacity(0.2), color.withOpacity(0.1)]),
                border: Border.all(
                    color: const Color.fromARGB(241, 213, 213, 213),
                    width: 0.2)),
            child: Icon(icon, color: color, size: 35),
          ),
          10.paddingHeight,
          Text(
            title,
            style: const TextStyle(
                fontSize: 14, color: Colors.black, letterSpacing: 0.8),
          ),
        ],
      ),
    ),
  );
}
