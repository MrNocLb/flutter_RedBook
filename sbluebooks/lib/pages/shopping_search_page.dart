import 'package:cached_network_image/cached_network_image.dart';
import 'package:comlogin_sdk/util/padding_extension.dart';
import 'package:flutter/material.dart';

class ShoppingSearchPage extends StatefulWidget {
  const ShoppingSearchPage({super.key});

  @override
  State<ShoppingSearchPage> createState() => _ShoppingSearchPageState();
}

class _ShoppingSearchPageState extends State<ShoppingSearchPage> {
  bool isGuesshow = true; //猜你想吃是否展示
  bool isString = false;
  TextEditingController textEditingController = TextEditingController();
  List<String> historyarry = ['俯卧撑', '睡觉', '撒发货哦撒谎佛啊好哦是佛娜娜了', '睡觉', '睡觉'];
  List<String> guesseekarry = ['聊天软件soul', '慢养好气色', '负重俯卧撑'];
  List<Map<String, String>> classify = [
    {
      't': '防晒',
      'url':
          'https://gd-hbimg.huaban.com/184d2f9e89d902922ac3f27406958c7b783c6cf71dbb1-690evM_fw658webp'
    },
    {
      't': '眼霜',
      'url':
          'https://gd-hbimg.huaban.com/184d2f9e89d902922ac3f27406958c7b783c6cf71dbb1-690evM_fw658webp'
    },
    {
      't': '眼睫毛',
      'url':
          'https://gd-hbimg.huaban.com/184d2f9e89d902922ac3f27406958c7b783c6cf71dbb1-690evM_fw658webp'
    },
    {
      't': '耳夹',
      'url':
          'https://gd-hbimg.huaban.com/184d2f9e89d902922ac3f27406958c7b783c6cf71dbb1-690evM_fw658webp'
    },
    {
      't': '纸巾',
      'url':
          'https://gd-hbimg.huaban.com/184d2f9e89d902922ac3f27406958c7b783c6cf71dbb1-690evM_fw658webp'
    },
    {
      't': '戒指',
      'url':
          'https://gd-hbimg.huaban.com/184d2f9e89d902922ac3f27406958c7b783c6cf71dbb1-690evM_fw658webp'
    },
    {
      't': '光腿神器',
      'url':
          'https://gd-hbimg.huaban.com/184d2f9e89d902922ac3f27406958c7b783c6cf71dbb1-690evM_fw658webp'
    },
    {
      't': '美瞳',
      'url':
          'https://gd-hbimg.huaban.com/184d2f9e89d902922ac3f27406958c7b783c6cf71dbb1-690evM_fw658webp'
    }
  ];
  List<String> aboutseek = ['一二三', '一一一'];

  get _appbar {
    return AppBar(
        // 移除默认的返回按钮
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.chevron_left,
                size: 30,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Container(
                // width: MediaQuery.of(context).size.width * 0.7,
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
                      child: TextField(
                        style: TextStyle(fontSize: 15),
                        controller: textEditingController,
                        cursorColor: Colors.grey,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          // contentPadding: EdgeInsets.only(bottom: 0),
                          hintText: '如何快速睡觉', //后面换成接口根据账号随机返回关键字
                          hintStyle:
                              TextStyle(color: Colors.grey[600], fontSize: 15),
                          border: InputBorder.none,
                          // contentPadding: EdgeInsets.all(1),
                        ),
                        onEditingComplete: () {
                          // 点击完成的回调
                        },
                        onChanged: (value) {
                          if (value != '') {
                            setState(() {
                              isString = true;
                            });
                            // 改变时 发送请求 获取搜索相关数据显示
                          } else {
                            setState(() {
                              isString = false;
                            });
                          }
                        },
                      ),
                    ),
                    if (!isString)
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.photo_camera_outlined,
                          size: 20,
                          color: Colors.grey[600],
                        ),
                      ),
                    8.paddingWidth
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Text(
              '搜索',
              style: TextStyle(
                  color: Colors.grey[600], fontSize: 16, letterSpacing: 1),
            ),
          ),
          10.paddingWidth
        ],
        iconTheme: IconThemeData(color: Colors.black87, size: 30),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.8),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 1,
              child: const DecoratedBox(
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 230, 229, 229)),
              )),
        ));
  }

  get _aboutcontent {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Column(
        children: [
          for (int i = 0; i < aboutseek.length; i++)
            GestureDetector(
              onTap: gotoseek(aboutseek[i]),
              child: Container(
                height: 50,
                child: Column(children: [
                  Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.grey[500],
                        size: 20,
                      ),
                      10.paddingWidth,
                      RichText(
                          text: TextSpan(
                              text: textEditingController.text,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 16),
                              children: [
                            TextSpan(
                              text: aboutseek[i]
                                  .substring(textEditingController.text.length),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            )
                          ]))
                    ],
                  ),
                  10.paddingHeight,
                  Center(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 1,
                        child: const DecoratedBox(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 230, 229, 229)),
                        )),
                  ),
                ]),
              ),
            )
        ],
      ),
    );
  }

  get _Nostring {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 历史记录
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '历史记录',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        letterSpacing: 0.8),
                  ),
                  IconButton(
                      onPressed: delhistory,
                      icon: Icon(
                        Icons.delete,
                        size: 22,
                        color: Colors.grey[500],
                      ))
                ],
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                // textDirection: TextDirection.ltr,
                alignment: WrapAlignment.start,
                // crossAxisAlignment: WrapCrossAlignment.start,
                // 点击将里面的文本赋值到 搜索框 并且发起请求跳转
                children: [
                  for (int i = 0; i < (historyarry.length ?? 0); i++)
                    historybtn(
                      str: historyarry[i],
                    )
                ],
              )
            ],
          ),
          10.paddingHeight,
          // 猜你想搜
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '猜你想搜',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        letterSpacing: 0.8),
                  ),
                  Row(
                    children: [
                      isGuesshow
                          ? IconButton(
                              onPressed: refresh,
                              icon: Icon(
                                Icons.refresh,
                                size: 22,
                                color: Colors.grey[500],
                              ))
                          : Text(
                              '已隐藏',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                      const Text(
                        '  |',
                        style: TextStyle(
                            color: Color.fromARGB(169, 158, 158, 158)),
                      ),
                      IconButton(
                          onPressed: closeseek,
                          icon: Icon(
                            isGuesshow
                                ? Icons.remove_red_eye
                                : Icons.visibility_off,
                            size: 22,
                            color: Colors.grey[500],
                          )),
                    ],
                  )
                ],
              ),
              if (isGuesshow)
                for (int i = 0; i < guesseekarry.length; i += 2)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, left: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        guesseekbtn(
                          guesseekarry[i],
                        ),
                        if (i + 1 < guesseekarry.length)
                          guesseekbtn(
                            guesseekarry[i + 1],
                          ),
                      ],
                    ),
                  ),
            ],
          ),
          // 小红书热点
          8.paddingHeight,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '常用分类',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    letterSpacing: 0.8),
              ),
              15.paddingHeight,
              Container(
                // color: Colors.amberAccent,
                height: 200,
                child: GridView.count(
                  crossAxisCount: 4,
                  childAspectRatio: 0.9,
                  children: List.generate(
                      classify.length,
                      (index) => iconnav(
                          classify[index]['t'].toString(),
                          classify[index]['url'].toString(),
                          () => classifynav(index))),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar,
      body: SingleChildScrollView(child: isString ? _aboutcontent : _Nostring),
    );
  }

// 删除历史记录
  void delhistory() {}
// 刷新猜你想搜
  void refresh() {}
  // 关闭猜你想搜
  void closeseek() {
    setState(() {
      isGuesshow = !isGuesshow;
    });
  }

  void classifynav(int index) {
    switch (index) {
      case 1:
        debugPrint('执行与索引1相关的操作');
        break;
      case 2:
        debugPrint('执行与索引2相关的操作');
        break;
      case 3:
        debugPrint('执行与索引3相关的操作');
        break;
      case 4:
        debugPrint('执行与索引4相关的操作');
        break;
      case 5:
        debugPrint('执行与索引5相关的操作');
        break;
      case 6:
        debugPrint('执行与索引6相关的操作');
        break;
      case 7:
        debugPrint('执行与索引7相关的操作');
        break;
      case 0:
        debugPrint('执行与索引0相关的操作');
        break;
      default:
        debugPrint('索引不在1到8的范围内');
    }
  }

//
  Widget guesseekbtn(String str) {
    return GestureDetector(
      onTap: gotoseek(str),
      child: Container(
        width: 150,
        // color: Colors.amberAccent,
        child: Text(
          str,
          style: TextStyle(
              fontSize: 15,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }

  // 常用分类的组件
  Widget iconnav(String t, String url, VoidCallback ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 100,
        child: Column(children: [
          5.paddingHeight,
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            child: Container(
              width: 60,
              height: 60,
              color: Color.fromARGB(172, 236, 236, 236),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: url,
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ),
          5.paddingHeight,
          Text(
            t,
            style: const TextStyle(fontSize: 16, letterSpacing: 0.8),
          )
        ]),
      ),
    );
  }
}

class historybtn extends StatefulWidget {
  final String str;
  const historybtn({super.key, required this.str});

  @override
  State<historybtn> createState() => _historybtnState();
}

class _historybtnState extends State<historybtn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gotoseek(widget.str),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(81, 245, 235, 235),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 0.8, color: Color.fromARGB(17, 0, 0, 0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
          child: Text(
            widget.str,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

// 根据字符串搜索数据即发送请求 再把回调 放到页面中
gotoseek(String str) {}
