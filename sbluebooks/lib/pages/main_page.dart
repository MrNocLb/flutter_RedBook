// 首页
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comlogin_sdk/util/navigator_util.dart';
import 'package:comlogin_sdk/util/padding_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sbluebooks/dao/Postmain_dao.dart';
import 'package:sbluebooks/model/Post_model.dart';
import 'package:sbluebooks/pages/main_detail_page.dart';
import 'package:sbluebooks/util/allsmallutil.dart';

import 'main_search_page.dart';

class MainPage extends StatefulWidget {
  final BuildContext contextq;
  const MainPage({super.key, required this.contextq});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  int _topindex = 1; //顶部选择index
  // 左边关注的控制器
  final ScrollController _scrollScrollerl = ScrollController();
  late PostmainController postmainControllerl; //stream控制器
  // 中间的scroll控制器
  final ScrollController _scrollScroller = ScrollController();
  late PostmainController postmainController; //stream控制器
  // 右边 地区的
  final ScrollController _scrollScrollerr = ScrollController();
  late PostmainController postmainControllerr; //stream控制器
  bool _isLoading0 = false; //刷新节流
  bool _isLoading = false; //刷新节流
  bool _isLoading2 = false; //刷新节流
  final List imgList = [
    'https://gd-hbimg.huaban.com/7502b9c5e5dcb9e229f4719752777d0474f6a45315c75f-6vU7Ue_fw240webp',
    'https://gd-hbimg.huaban.com/f1dfc7bedd4d980f48cb11e76431a7c5aeb601aa2548c-fKlRYm_fw240webp',
    'https://gd-hbimg.huaban.com/ba45f01a25a3b292818e2d2b4b36fb8a82e1680041820b-txsIaF_fw240webp',
    'https://gd-hbimg.huaban.com/0e77105ca462eeefa4b6ae5729c2bc639707dfce8725f-NbrPVT_fw240webp',
    'https://gd-hbimg.huaban.com/470225d84bc74586250b10586380a26ec911cce7fe1c0-ibff1e_fw240webp',
    'https://gd-hbimg.huaban.com/50c9c9dcda80ac6f27e4b2eb94b252d0f247f3054a0e1-zs6HUn_fw240webp',
    'https://gd-hbimg.huaban.com/207a966cfc92105463b119f0d2366f5e7c7e24be1f6bdc-ao65De_fw240webp',
    'https://gd-hbimg.huaban.com/10f210c8f28d34b8fa00190c9adc2afaa0201db355fc6c-wP8sSl_fw240webp',
    'https://gd-hbimg.huaban.com/39e6133c570111480c56241b7bfde1e63d1a0ffaadfb8-HTR8Xx_fw240webp',
    'https://gd-hbimg.huaban.com/3353d7a81b9b63c2f3e04af138641e52e970d24c8db1e-66q6dt_fw240webp',
    'https://gd-hbimg.huaban.com/9c7f2920493774863f15e1836f193bff7831eddd38a1d-07Qsh3_fw240webp',
    'https://gd-hbimg.huaban.com/b6db623795851634508c2736e19a82c1fd630da520ab6-7LOhNE_fw240webp',
    'https://gd-hbimg.huaban.com/9b98ed9e7242a0f0fd79edc0bd1359029f8f66d4905f5-P8HMOS_fw240webp',
    'https://gd-hbimg.huaban.com/2ca6ab6cb5123d0d9930b23f82743ce0d5ea8e985cf3e-onL0AP_fw240webp',
    'https://gd-hbimg.huaban.com/3e527fdca4630374575d668e45eabb7954d6cd982ab88c-2WSzip_fw240webp',
    'https://gd-hbimg.huaban.com/9b7aafc01dbb78ab54e603c2ed3361a9a164cb5620dad7-Ui7MsM_fw240webp',
  ];
  final List<PostModel> tempList = [];
  // 后续开发 为节约流量 以及性能 主页面刷新获取的只有 部分数据 图片 内容 头像名称 获赞 是否为视频 以及点击继续再次获取具体数据
  final List<PostModel> _PostList = [
    PostModel(
        avatar: 'assets/images/tx.jpg',
        username: '我爱吃土豆',
        title: '一些杂图',
        content:
            '滴滴！欢迎有需要的师兄师姐来了解！📍详情请看图2联系方式请看图3更多拍摄风格请看主页其他笔记 \n\n\n\n\n\n\n\n 滴滴！欢迎有需要的师兄师姐来了解！📍详情请看图2联系方式请看图3更多拍摄风格请看主页其他笔记',
        tag: ['无状态', 'wuyu'],
        date: 1711355529100,
        location: '江门',
        favorite: 20,
        like: 10100,
        islikeshow: false,
        postId: 'post_1',
        userId: 'user_1',
        //后面需附带图片高度
        imgurl: [
          'https://gd-hbimg.huaban.com/d00becc66bb3046dd73669b00eb94ce8928af3d22442b7-uQJJP9_fw240webp',
          'https://gd-hbimg.huaban.com/867b7882db19f1b599291711544634de3321019f312d8b-1jXbKG_fw240webp',
          'https://gd-hbimg.huaban.com/7287ad233e539594c273176e4ee0b4449922f699572b33-XWEIMc_fw658webp',
          'https://gd-hbimg.huaban.com/6767ac43fb8c31f797a75b11b923505b8dd2519410a78e-wfUAVs_fw240webp',
        ],
        comments: [
          Comments(
            avatar: 'assets/images/tx.jpg',
            username: '我丢五个圣杯',
            like: 12,
            isWrite: false,
            isTop: true,
            islikewirte: true,
            content: '我丢了十个圣杯，都同意我去,我丢了十个圣杯，都同意,我去我丢了十个圣杯，都同意我去',
            date: 1711355529100,
            location: '广州',
            replies: [
              Replies(
                avatar: 'assets/images/tx.jpg',
                username: '我丢五个圣杯',
                like: 12,
                isWrite: false,
                isTop: true,
                islikewirte: true,
                content:
                    '我丢了十个圣杯，都同意我去丢了十个圣杯，都同意我去,我丢了十个圣杯，都同意,丢了十个圣杯，都同意我去,我丢了十个圣杯，都同意,',
                date: DateTime.now().microsecondsSinceEpoch,
                location: '广州',
              ),
              Replies(
                avatar: 'assets/images/tx.jpg',
                username: '十点半的飞机场',
                like: 12,
                isWrite: false,
                isTop: true,
                islikewirte: true,
                content: 'babybabybaby babaybay',
                date: DateTime.now().microsecondsSinceEpoch,
                location: '广州',
              ),
              Replies(
                avatar: 'assets/images/tx.jpg',
                username: '十点半的飞机场',
                like: 12,
                isWrite: false,
                isTop: true,
                islikewirte: true,
                content: 'babybabybaby babaybay',
                date: DateTime.now().microsecondsSinceEpoch,
                location: '广州',
              ),
              Replies(
                avatar: 'assets/images/tx.jpg',
                username: '十点半的飞机场',
                like: 12,
                isWrite: false,
                isTop: true,
                islikewirte: true,
                content: 'babybabybaby babaybay',
                date: DateTime.now().microsecondsSinceEpoch,
                location: '广州',
              ),
              Replies(
                avatar: 'assets/images/tx.jpg',
                username: '十点半的飞机场',
                like: 12,
                isWrite: false,
                isTop: true,
                islikewirte: true,
                content: 'babybabybaby babaybay',
                date: DateTime.now().microsecondsSinceEpoch,
                location: '广州',
              ),
              Replies(
                avatar: 'assets/images/tx.jpg',
                username: '十点半的飞机场',
                like: 12,
                isWrite: false,
                isTop: true,
                islikewirte: true,
                content: 'babybabybaby babaybay',
                date: DateTime.now().microsecondsSinceEpoch,
                location: '广州',
              ),
              Replies(
                avatar: 'assets/images/tx.jpg',
                username: '十点半的飞机场',
                like: 12,
                isWrite: false,
                isTop: true,
                islikewirte: true,
                content: 'babybabybaby babaybay',
                date: DateTime.now().microsecondsSinceEpoch,
                location: '广州',
              )
            ],
          ),
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '我丢了9个圣杯，都同意我去',
              date: 1711459490510,
              location: '广州',
              replies: []),
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '爱拼才会赢',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: [
                Replies(
                  avatar: 'assets/images/tx.jpg',
                  username: '我丢五个圣杯',
                  like: 12,
                  isWrite: false,
                  isTop: true,
                  islikewirte: true,
                  content: '我丢了十个圣杯，都同意我去',
                  date: DateTime.now().microsecondsSinceEpoch,
                  location: '广州',
                )
              ]),
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '爱拼才会赢',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: [
                Replies(
                  avatar: 'assets/images/tx.jpg',
                  username: '我丢五个圣杯',
                  like: 12,
                  isWrite: false,
                  isTop: true,
                  islikewirte: true,
                  content: '我丢了十个圣杯，都同意我去',
                  date: DateTime.now().microsecondsSinceEpoch,
                  location: '广州',
                )
              ]),
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '爱拼才会赢',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: []),
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '爱拼才会赢',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: []),
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '爱拼才会赢',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: []),
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '爱拼才会赢',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: []),
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '爱拼才会赢',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: []),
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '爱拼才会赢',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: []),
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '爱拼才会赢',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: []),
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '她今年农历三月六',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: []),
        ]),
    PostModel(
        avatar: 'assets/images/tx.jpg',
        username: '我爱吃土豆',
        title: 'DISAH11111S',
        content: '系方式请看图3更多拍摄风格请看主页其他笔记',
        tag: ['无状态', 'wuyu'],
        date: DateTime.now().millisecondsSinceEpoch,
        location: '江门',
        favorite: 20,
        like: 1000,
        islikeshow: false,
        postId: 'post_1',
        userId: 'user_1',
        imgurl: [
          'https://gd-hbimg.huaban.com/7502b9c5e5dcb9e229f4719752777d0474f6a45315c75f-6vU7Ue_fw240webp',
        ],
        comments: []),
    PostModel(
        avatar: 'assets/images/tx.jpg',
        username: '我爱吃土豆',
        title: 'DISAHS',
        content: '滴滴！欢迎有需要的师兄师姐来了解！📍详情请看图2联系方式请看图3更多拍摄风格请看主页其他笔记',
        tag: ['无状态', 'wuyu'],
        date: DateTime.now().millisecondsSinceEpoch,
        location: '江门',
        favorite: 20,
        like: 1000,
        islikeshow: false,
        postId: 'post_1',
        userId: 'user_1',
        imgurl: [
          'https://gd-hbimg.huaban.com/f1dfc7bedd4d980f48cb11e76431a7c5aeb601aa2548c-fKlRYm_fw240webp',
        ],
        comments: [
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '我丢了十个圣杯，都同意我去',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: [
                Replies(
                  avatar: 'assets/images/tx.jpg',
                  username: '我丢五个圣杯',
                  like: 12,
                  isWrite: false,
                  isTop: true,
                  islikewirte: true,
                  content: '我丢了十个圣杯，都同意我去',
                  date: DateTime.now().microsecondsSinceEpoch,
                  location: '广州',
                )
              ])
        ]),
    PostModel(
        avatar: 'assets/images/tx.jpg',
        username: '我爱吃土豆',
        title: 'DISAHS',
        content: '滴滴！欢迎有需要的师兄师姐来了解！📍详情请看图2联系方式请看图3更多拍摄风格请看主页其他笔记',
        tag: ['无状态', 'wuyu'],
        date: DateTime.now().millisecondsSinceEpoch,
        location: '江门',
        favorite: 20,
        like: 1000,
        islikeshow: false,
        postId: 'post_1',
        userId: 'user_1',
        imgurl: [
          'https://gd-hbimg.huaban.com/ba45f01a25a3b292818e2d2b4b36fb8a82e1680041820b-txsIaF_fw240webp',
        ],
        comments: [
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '我丢了十个圣杯，都同意我去',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: [
                Replies(
                  avatar: 'assets/images/tx.jpg',
                  username: '我丢五个圣杯',
                  like: 12,
                  isWrite: false,
                  isTop: true,
                  islikewirte: true,
                  content: '我丢了十个圣杯，都同意我去',
                  date: DateTime.now().microsecondsSinceEpoch,
                  location: '广州',
                )
              ])
        ]),
    PostModel(
        avatar: 'assets/images/tx.jpg',
        username: '我爱吃土豆',
        title: 'DISAHS',
        content: '滴滴！欢迎有需要的师兄师姐来了解！📍详情请看图2联系方式请看图3更多拍摄风格请看主页其他笔记',
        tag: ['无状态', 'wuyu'],
        date: DateTime.now().millisecondsSinceEpoch,
        location: '江门',
        favorite: 20,
        like: 1000,
        islikeshow: false,
        postId: 'post_1',
        userId: 'user_1',
        imgurl: [
          'https://gd-hbimg.huaban.com/0e77105ca462eeefa4b6ae5729c2bc639707dfce8725f-NbrPVT_fw240webp',
        ],
        comments: [
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '我丢了十个圣杯，都同意我去',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: [
                Replies(
                  avatar: 'assets/images/tx.jpg',
                  username: '我丢五个圣杯',
                  like: 12,
                  isWrite: false,
                  isTop: true,
                  islikewirte: true,
                  content: '我丢了十个圣杯，都同意我去',
                  date: DateTime.now().microsecondsSinceEpoch,
                  location: '广州',
                )
              ])
        ]),
    PostModel(
        avatar: 'assets/images/tx.jpg',
        username: '我爱吃土豆',
        title: 'DISAHS',
        content: '滴滴！欢迎有需要的师兄师姐来了解！📍详情请看图2联系方式请看图3更多拍摄风格请看主页其他笔记',
        tag: ['无状态', 'wuyu'],
        date: DateTime.now().millisecondsSinceEpoch,
        location: '江门',
        favorite: 20,
        like: 1000,
        islikeshow: false,
        postId: 'post_1',
        userId: 'user_1',
        imgurl: [
          'https://gd-hbimg.huaban.com/470225d84bc74586250b10586380a26ec911cce7fe1c0-ibff1e_fw240webp',
        ],
        comments: [
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '我丢了十个圣杯，都同意我去',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: [
                Replies(
                  avatar: 'assets/images/tx.jpg',
                  username: '我丢五个圣杯',
                  like: 12,
                  isWrite: false,
                  isTop: true,
                  islikewirte: true,
                  content: '我丢了十个圣杯，都同意我去',
                  date: DateTime.now().microsecondsSinceEpoch,
                  location: '广州',
                )
              ])
        ]),
    PostModel(
        avatar: 'assets/images/tx.jpg',
        username: '我爱吃土豆',
        title: 'DISAHS',
        content: '滴滴！欢迎有需要的师兄师姐来了解！📍详情请看图2联系方式请看图3更多拍摄风格请看主页其他笔记',
        tag: ['无状态', 'wuyu'],
        date: DateTime.now().millisecondsSinceEpoch,
        location: '江门',
        favorite: 20,
        like: 1000,
        islikeshow: false,
        postId: 'post_1',
        userId: 'user_1',
        imgurl: [
          'https://gd-hbimg.huaban.com/50c9c9dcda80ac6f27e4b2eb94b252d0f247f3054a0e1-zs6HUn_fw240webp',
        ],
        comments: [
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '我丢了十个圣杯，都同意我去',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: [
                Replies(
                  avatar: 'assets/images/tx.jpg',
                  username: '我丢五个圣杯',
                  like: 12,
                  isWrite: false,
                  isTop: true,
                  islikewirte: true,
                  content: '我丢了十个圣杯，都同意我去',
                  date: DateTime.now().microsecondsSinceEpoch,
                  location: '广州',
                )
              ])
        ]),
    PostModel(
        avatar: 'assets/images/tx.jpg',
        username: '我爱吃土豆',
        title: 'DISAHS',
        content: '滴滴！欢迎有需要的师兄师姐来了解！📍详情请看图2联系方式请看图3更多拍摄风格请看主页其他笔记',
        tag: ['无状态', 'wuyu'],
        date: DateTime.now().millisecondsSinceEpoch,
        location: '江门',
        favorite: 20,
        like: 1000,
        islikeshow: false,
        postId: 'post_1',
        userId: 'user_1',
        imgurl: [
          'https://gd-hbimg.huaban.com/207a966cfc92105463b119f0d2366f5e7c7e24be1f6bdc-ao65De_fw240webp',
        ],
        comments: [
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '我丢了十个圣杯，都同意我去',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: [
                Replies(
                  avatar: 'assets/images/tx.jpg',
                  username: '我丢五个圣杯',
                  like: 12,
                  isWrite: false,
                  isTop: true,
                  islikewirte: true,
                  content: '我丢了十个圣杯，都同意我去',
                  date: DateTime.now().microsecondsSinceEpoch,
                  location: '广州',
                )
              ])
        ]),
    PostModel(
        avatar: 'assets/images/tx.jpg',
        username: '我爱吃土豆',
        title: 'DISAHS',
        content: '滴滴！欢迎有需要的师兄师姐来了解！📍详情请看图2联系方式请看图3更多拍摄风格请看主页其他笔记',
        tag: ['无状态', 'wuyu'],
        date: DateTime.now().millisecondsSinceEpoch,
        location: '江门',
        favorite: 20,
        like: 1000,
        islikeshow: false,
        postId: 'post_1',
        userId: 'user_1',
        imgurl: [
          'https://gd-hbimg.huaban.com/10f210c8f28d34b8fa00190c9adc2afaa0201db355fc6c-wP8sSl_fw240webp',
        ],
        comments: [
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '我丢了十个圣杯，都同意我去',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: [
                Replies(
                  avatar: 'assets/images/tx.jpg',
                  username: '我丢五个圣杯',
                  like: 12,
                  isWrite: false,
                  isTop: true,
                  islikewirte: true,
                  content: '我丢了十个圣杯，都同意我去',
                  date: DateTime.now().microsecondsSinceEpoch,
                  location: '广州',
                )
              ])
        ]),
    PostModel(
        avatar: 'assets/images/tx.jpg',
        username: '我爱吃土豆',
        title: 'DISAHS',
        content: '滴滴！欢迎有需要的师兄师姐来了解！📍详情请看图2联系方式请看图3更多拍摄风格请看主页其他笔记',
        tag: ['无状态', 'wuyu'],
        date: DateTime.now().millisecondsSinceEpoch,
        location: '江门',
        favorite: 20,
        like: 1000,
        islikeshow: false,
        postId: 'post_1',
        userId: 'user_1',
        imgurl: [
          'https://gd-hbimg.huaban.com/39e6133c570111480c56241b7bfde1e63d1a0ffaadfb8-HTR8Xx_fw240webp',
        ],
        comments: [
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '我丢了十个圣杯，都同意我去',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: [
                Replies(
                  avatar: 'assets/images/tx.jpg',
                  username: '我丢五个圣杯',
                  like: 12,
                  isWrite: false,
                  isTop: true,
                  islikewirte: true,
                  content: '我丢了十个圣杯，都同意我去',
                  date: DateTime.now().microsecondsSinceEpoch,
                  location: '广州',
                )
              ])
        ]),
    PostModel(
        avatar: 'assets/images/tx.jpg',
        username: '我爱吃土豆',
        title: 'DISAHS',
        content: '滴滴！欢迎有需要的师兄师姐来了解！📍详情请看图2联系方式请看图3更多拍摄风格请看主页其他笔记',
        tag: ['无状态', 'wuyu'],
        date: DateTime.now().millisecondsSinceEpoch,
        location: '江门',
        favorite: 20,
        like: 1000,
        islikeshow: false,
        postId: 'post_1',
        userId: 'user_1',
        imgurl: [
          'https://gd-hbimg.huaban.com/3353d7a81b9b63c2f3e04af138641e52e970d24c8db1e-66q6dt_fw240webp',
        ],
        comments: [
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '我丢了十个圣杯，都同意我去',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: [
                Replies(
                  avatar: 'assets/images/tx.jpg',
                  username: '我丢五个圣杯',
                  like: 12,
                  isWrite: false,
                  isTop: true,
                  islikewirte: true,
                  content: '我丢了十个圣杯，都同意我去',
                  date: DateTime.now().microsecondsSinceEpoch,
                  location: '广州',
                )
              ])
        ]),
    PostModel(
        avatar: 'assets/images/tx.jpg',
        username: '我爱吃土豆',
        title: 'DISAHS',
        content: '滴滴！欢迎有需要的师兄师姐来了解！📍详情请看图2联系方式请看图3更多拍摄风格请看主页其他笔记',
        tag: ['无状态', 'wuyu'],
        date: DateTime.now().millisecondsSinceEpoch,
        location: '江门',
        favorite: 20,
        like: 1000,
        islikeshow: false,
        postId: 'post_1',
        userId: 'user_1',
        imgurl: [
          'https://gd-hbimg.huaban.com/9c7f2920493774863f15e1836f193bff7831eddd38a1d-07Qsh3_fw240webp',
        ],
        comments: [
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '我丢了十个圣杯，都同意我去',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: [
                Replies(
                  avatar: 'assets/images/tx.jpg',
                  username: '我丢五个圣杯',
                  like: 12,
                  isWrite: false,
                  isTop: true,
                  islikewirte: true,
                  content: '我丢了十个圣杯，都同意我去',
                  date: DateTime.now().microsecondsSinceEpoch,
                  location: '广州',
                )
              ])
        ]),
    PostModel(
        avatar: 'assets/images/tx.jpg',
        username: '我爱吃土豆',
        title: 'DISAHS',
        content: '滴滴！欢迎有需要的师兄师姐来了解！📍详情请看图2联系方式请看图3更多拍摄风格请看主页其他笔记',
        tag: ['无状态', 'wuyu'],
        date: DateTime.now().millisecondsSinceEpoch,
        location: '江门',
        favorite: 20,
        like: 1000,
        islikeshow: false,
        postId: 'post_1',
        userId: 'user_1',
        imgurl: [
          'https://gd-hbimg.huaban.com/b6db623795851634508c2736e19a82c1fd630da520ab6-7LOhNE_fw240webp',
        ],
        comments: [
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '我丢了十个圣杯，都同意我去',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: [
                Replies(
                  avatar: 'assets/images/tx.jpg',
                  username: '我丢五个圣杯',
                  like: 12,
                  isWrite: false,
                  isTop: true,
                  islikewirte: true,
                  content: '我丢了十个圣杯，都同意我去',
                  date: DateTime.now().microsecondsSinceEpoch,
                  location: '广州',
                )
              ])
        ]),
    PostModel(
        avatar: 'assets/images/tx.jpg',
        username: '我爱吃土豆',
        title: 'DISAHS',
        content: '滴滴！欢迎有需要的师兄师姐来了解！📍详情请看图2联系方式请看图3更多拍摄风格请看主页其他笔记',
        tag: ['无状态', 'wuyu'],
        date: DateTime.now().millisecondsSinceEpoch,
        location: '江门',
        favorite: 20,
        like: 1000,
        islikeshow: false,
        postId: 'post_1',
        userId: 'user_1',
        imgurl: [
          'https://gd-hbimg.huaban.com/9b98ed9e7242a0f0fd79edc0bd1359029f8f66d4905f5-P8HMOS_fw240webp',
        ],
        comments: [
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '我丢了十个圣杯，都同意我去',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: [
                Replies(
                  avatar: 'assets/images/tx.jpg',
                  username: '我丢五个圣杯',
                  like: 12,
                  isWrite: false,
                  isTop: true,
                  islikewirte: true,
                  content: '我丢了十个圣杯，都同意我去',
                  date: DateTime.now().microsecondsSinceEpoch,
                  location: '广州',
                )
              ])
        ]),
    PostModel(
        avatar: 'assets/images/tx.jpg',
        username: '我爱吃土豆',
        title: 'DISAHS',
        content: '滴滴！欢迎有需要的师兄师姐来了解！📍详情请看图2联系方式请看图3更多拍摄风格请看主页其他笔记',
        tag: ['无状态', 'wuyu'],
        date: DateTime.now().millisecondsSinceEpoch,
        location: '江门',
        favorite: 20,
        like: 1000,
        islikeshow: false,
        postId: 'post_1',
        userId: 'user_1',
        imgurl: [
          'https://gd-hbimg.huaban.com/2ca6ab6cb5123d0d9930b23f82743ce0d5ea8e985cf3e-onL0AP_fw240webp',
        ],
        comments: [
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '我丢了十个圣杯，都同意我去',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: [
                Replies(
                  avatar: 'assets/images/tx.jpg',
                  username: '我丢五个圣杯',
                  like: 12,
                  isWrite: false,
                  isTop: true,
                  islikewirte: true,
                  content: '我丢了十个圣杯，都同意我去',
                  date: DateTime.now().microsecondsSinceEpoch,
                  location: '广州',
                )
              ])
        ]),
    PostModel(
        avatar: 'assets/images/tx.jpg',
        username: '我爱吃土豆',
        title: 'DISAHS',
        content: '滴滴！欢迎有需要的师兄师姐来了解！📍详情请看图2联系方式请看图3更多拍摄风格请看主页其他笔记',
        tag: ['无状态', 'wuyu'],
        date: DateTime.now().millisecondsSinceEpoch,
        location: '江门',
        favorite: 20,
        like: 1000,
        islikeshow: false,
        postId: 'post_1',
        userId: 'user_1',
        imgurl: [
          'https://gd-hbimg.huaban.com/3e527fdca4630374575d668e45eabb7954d6cd982ab88c-2WSzip_fw240webp',
        ],
        comments: [
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '我丢了十个圣杯，都同意我去',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: [
                Replies(
                  avatar: 'assets/images/tx.jpg',
                  username: '我丢五个圣杯',
                  like: 12,
                  isWrite: false,
                  isTop: true,
                  islikewirte: true,
                  content: '我丢了十个圣杯，都同意我去',
                  date: DateTime.now().microsecondsSinceEpoch,
                  location: '广州',
                )
              ])
        ]),
    PostModel(
        avatar: 'assets/images/tx.jpg',
        username: '我爱吃土豆',
        title: 'DISAHS',
        content: '滴滴！欢迎有需要的师兄师姐来了解！📍详情请看图2联系方式请看图3更多拍摄风格请看主页其他笔记',
        tag: ['无状态', 'wuyu'],
        date: DateTime.now().millisecondsSinceEpoch,
        location: '江门',
        favorite: 20,
        like: 1000,
        islikeshow: false,
        postId: 'post_1',
        userId: 'user_1',
        imgurl: [
          'https://gd-hbimg.huaban.com/9b7aafc01dbb78ab54e603c2ed3361a9a164cb5620dad7-Ui7MsM_fw240webp',
        ],
        comments: [
          Comments(
              avatar: 'assets/images/tx.jpg',
              username: '我丢五个圣杯',
              like: 12,
              isWrite: false,
              isTop: true,
              islikewirte: true,
              content: '我丢了十个圣杯，都同意我去',
              date: DateTime.now().microsecondsSinceEpoch,
              location: '广州',
              replies: [
                Replies(
                  avatar: 'assets/images/tx.jpg',
                  username: '我丢五个圣杯',
                  like: 12,
                  isWrite: false,
                  isTop: true,
                  islikewirte: true,
                  content: '我丢了十个圣杯，都同意我去',
                  date: DateTime.now().microsecondsSinceEpoch,
                  location: '广州',
                )
              ])
        ]),
  ];
  final PageController _pageController = PageController(initialPage: 1);
  get _appbar {
    return AppBar(
        leading: Builder(builder: (context) {
          // final drawershowchange = context.watch<DrawershowProvider>();
          return IconButton(
            icon: Icon(
              Icons.menu,
              size: 25,
              color: Colors.grey[700],
            ),
            onPressed: () {
              // 外边需要套一个builder才可以使用Scaffold.of(context)无法获取到正确的scafold对象。
              // Scafold.of(context方法只能在Scafold的子组件中使
              // 用，如果在子组件的子组件中使用，会导致无法找到正确的Scaffold对象。
              // drawershowchange.changershow1();
              Scaffold.of(widget.contextq).openDrawer();
            },
          );
        }),
        centerTitle: true,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (_topindex != 0) {
                    setState(() {
                      _topindex = 0;
                    });
                    _pageController.jumpToPage(0);
                  }
                },
                child: Column(
                  children: [
                    Text(
                      '关注',
                      style: TextStyle(
                          color: _topindex == 0
                              ? Colors.black87
                              : Colors.grey[700],
                          fontWeight: _topindex == 0
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontSize: 16,
                          letterSpacing: 0.5),
                    ),
                    4.paddingHeight,
                    _topindex == 0
                        ? SizedBox(
                            width: 34,
                            height: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.red,
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              20.paddingWidth,
              GestureDetector(
                onTap: () {
                  if (_topindex != 1) {
                    setState(() {
                      _topindex = 1;
                    });
                    _pageController.jumpToPage(1);
                  }
                },
                child: Column(
                  children: [
                    Text(
                      '发现',
                      style: TextStyle(
                          color: _topindex == 1
                              ? Colors.black87
                              : Colors.grey[700],
                          fontWeight: _topindex == 1
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontSize: 16,
                          letterSpacing: 0.5),
                    ),
                    4.paddingHeight,
                    _topindex == 1
                        ? SizedBox(
                            width: 34,
                            height: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.red,
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              20.paddingWidth,
              GestureDetector(
                onTap: () {
                  if (_topindex != 2) {
                    setState(() {
                      _topindex = 2;
                    });
                    _pageController.jumpToPage(2);
                  }
                },
                child: Column(
                  children: [
                    Text(
                      '地区',
                      style: TextStyle(
                          color: _topindex == 2
                              ? Colors.black87
                              : Colors.grey[700],
                          fontWeight: _topindex == 2
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontSize: 16,
                          letterSpacing: 0.5),
                    ),
                    4.paddingHeight,
                    _topindex == 2
                        ? SizedBox(
                            width: 34,
                            height: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.red,
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
                //先写地名后面加换
              ),
            ],
          ),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                NavigatorUtil.push(context, MainSearchPage());
              },
              child: Icon(
                Icons.search,
                size: 25,
                color: Colors.grey[600],
              )),
          20.paddingWidth
        ],
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.8),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 2,
              child: const DecoratedBox(
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
              )),
        ));
  }

  @override
  void initState() {
    super.initState();
    _doInit();
  }

  Widget itemWidget(int index, List<PostModel> list) {
    PostModel model = list[index];
    return Material(
      color: Colors.white,
      // elevation: 2,
      borderRadius: const BorderRadius.all(
        Radius.circular(4.0),
      ),
      child: InkWell(
        child: Hero(
            tag: model,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child:
                      //  Image.network(
                      //   imgPath,
                      //   fit: BoxFit.fill,
                      // ),
                      CachedNetworkImage(
                    // height: 300,  先渲染高度再获取网络图片  后端获取图片高度并处理返回
                    imageUrl: model.imgurl![0],
                    fit: BoxFit.fill,
                  ),
                ),
                5.paddingHeight,
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 10, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 暂时先试着
                      Text(
                        model.content!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 38, 37, 37),
                            fontSize: 12,
                            letterSpacing: 0.5),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      5.paddingHeight,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(25.0),
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    // decoration:
                                    // BoxDecoration(color: Colors.redAccent),
                                    child: Image.asset(
                                      model.avatar!,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                  // Image.network(
                                  //   '', //先放着
                                  //   height: 10,
                                  //   width: 10,
                                  // ),
                                  ),
                              4.paddingWidth,
                              Text(
                                AllSmallUtil.nameToShort(model.username!, 8),
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 11,
                                    letterSpacing: 0.3),
                                // maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                          GestureDetector(
                            // hero里使用gesture  改变事件命中逻辑
                            // behavior: HitTestBehavior.translucent,
                            onTap: () {
                              // 点击喜欢
                              if (!model.islikeshow!) {
                                setState(() {
                                  model.islikeshow = true;
                                  model.like = model.like! + 1;
                                });
                              } else {
                                setState(() {
                                  model.islikeshow = false;
                                  model.like = model.like! - 1;
                                });
                              }
                            },
                            // onTapLike(model),
                            child: Row(
                              children: [
                                Icon(
                                  model.islikeshow!
                                      ? Icons.favorite
                                      : Icons.favorite_border_sharp,
                                  size: 15,
                                  color: model.islikeshow!
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                4.paddingWidth,
                                Text(
                                  AllSmallUtil.intToShort(model.like!),
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 13), //超过几位数要怎么办
                                )
                              ],
                            ) //是否点赞
                            ,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
        onTap: () async {
          // 页面传参 不用provide
          var isLikeShown =
              await NavigatorUtil.push(context, MainDetailPage(model: model));
          setState(() {
            model.islikeshow = isLikeShown as bool?;
          });
          debugPrint("Is like shown: $isLikeShown");
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true; //保持页面
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 246, 245, 245),
        appBar: _appbar,
        body: PageView(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                _topindex = value;
              });
            },
            children: [
              // 关注
              StreamBuilder(
                stream: postmainControllerl.postStreanController.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<PostModel>> snapshot) {
                  return snapshot.connectionState == ConnectionState.active
                      ? RefreshIndicator(
                          // backgroundColor: Colors.red,
                          onRefresh: _onRefresh0,
                          color: const Color.fromARGB(255, 240, 38, 23),
                          child: SingleChildScrollView(
                            controller: _scrollScrollerl,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  MasonryGridView.count(
                                    crossAxisCount: 2,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            itemWidget(index, snapshot.data!),
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 3,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                  ),
                                  if (_isLoading0) ...[
                                    15.paddingHeight,
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      child: Container(
                                        color: Colors.white54,
                                        width: 20,
                                        height: 20,
                                        child: const CircularProgressIndicator(
                                          color:
                                              Color.fromARGB(141, 90, 88, 88),
                                        ),
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                },
              ),
              // 发现
              StreamBuilder(
                stream: postmainController.postStreanController.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<PostModel>> snapshot) {
                  return snapshot.connectionState == ConnectionState.active
                      ? RefreshIndicator(
                          // backgroundColor: Colors.red,
                          onRefresh: _onRefresh1,
                          color: const Color.fromARGB(255, 240, 38, 23),
                          child: SingleChildScrollView(
                            controller: _scrollScroller,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  MasonryGridView.count(
                                    crossAxisCount: 2,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            itemWidget(index, snapshot.data!),
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 3,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                  ),
                                  if (_isLoading) ...[
                                    15.paddingHeight,
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      child: Container(
                                        color: Colors.white54,
                                        width: 20,
                                        height: 20,
                                        child: const CircularProgressIndicator(
                                          color:
                                              Color.fromARGB(141, 90, 88, 88),
                                        ),
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                },
              ),

              // 地区
              StreamBuilder(
                stream: postmainControllerr.postStreanController.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<PostModel>> snapshot) {
                  return snapshot.connectionState == ConnectionState.active
                      ? RefreshIndicator(
                          // backgroundColor: Colors.red,
                          onRefresh: _onRefresh2,
                          color: const Color.fromARGB(255, 240, 38, 23),
                          child: SingleChildScrollView(
                            controller: _scrollScrollerr,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  MasonryGridView.count(
                                    crossAxisCount: 2,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            itemWidget(index, snapshot.data!),
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 3,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                  ),
                                  if (_isLoading2) ...[
                                    15.paddingHeight,
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      child: Container(
                                        color: Colors.white54,
                                        width: 20,
                                        height: 20,
                                        child: const CircularProgressIndicator(
                                          color:
                                              Color.fromARGB(141, 90, 88, 88),
                                        ),
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                },
              ),
            ]));
  }

  void _doInit() async {
    // 初始化post控制器
    // 初始化三个
    postmainController = PostmainController(
        initialPostModelList: [], scrollController: _scrollScroller);
    postmainControllerl = PostmainController(
        initialPostModelList: [], scrollController: _scrollScrollerl);
    postmainControllerr = PostmainController(
        initialPostModelList: [], scrollController: _scrollScrollerr);

    postmainController.widgetReady();
    postmainControllerl.widgetReady();
    postmainControllerr.widgetReady();

    // 中间的
    var list = await postmainController.getPageData(
        pageSize: 10, initialPostModelList: _PostList);
    postmainController.loadMoreData(list);

    // 上拉刷新
    _scrollScroller.addListener(() {
      if (_scrollScroller.position.pixels ==
              _scrollScroller.position.maxScrollExtent &&
          !_isLoading) {
        _loadData(loadMore: true);
      }
    });
// ----------------- 左边的
    var list0 = await postmainControllerl.getPageData(
        pageSize: 10,
        initialPostModelList: AllSmallUtil.shuffleArray(_PostList));
    postmainControllerl.loadMoreData(list0);
    _scrollScrollerl.addListener(() {
      if (_scrollScrollerl.position.pixels ==
              _scrollScrollerl.position.maxScrollExtent &&
          !_isLoading) {
        _loadData(loadMore: true, index: 0);
      }
    });
// -----------------
    var list2 = await postmainControllerr.getPageData(
        pageSize: 10,
        initialPostModelList: AllSmallUtil.shuffleArray(_PostList));
    postmainControllerr.loadMoreData(list2);
    _scrollScrollerr.addListener(() {
      if (_scrollScrollerr.position.pixels ==
              _scrollScrollerr.position.maxScrollExtent &&
          !_isLoading) {
        _loadData(loadMore: true, index: 2);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 下拉刷新
  Future<void> _onRefresh0() async {
    if (!_isLoading0) {
      _loadData(toporbootm: true, index: 0);
    }
  }

  Future<void> _onRefresh1() async {
    if (!_isLoading) {
      _loadData(toporbootm: true);
    }
  }

  Future<void> _onRefresh2() async {
    if (!_isLoading2) {
      _loadData(toporbootm: true, index: 2);
    }
  }

  // 上拉刷新 上部的还在 一次最多暂存20个
  // 下拉刷新 数组重置
  //后续返回相应模型的异步操作  参数是 第一个是否上下拉刷新 第二个是否启用分页
  int pageIndex0 = 1;
  int pageIndex = 1;
  int pageIndex2 = 1;
  void _loadData({toporbootm = false, loadMore = false, index = 1}) async {
    if (index == 0) {
      // 节流
      setState(() {
        _isLoading0 = true;
      });

      if (toporbootm) {
        // 下拉刷新
        // 模拟数据加载操作
        // 原定要发出请求 超时处理
        Future.delayed(const Duration(seconds: 1), () async {
          setState(() {
            _isLoading0 = false;
          });
          pageIndex0 = 1;
          var list = await postmainControllerl.getPageData(
              pageIndex: pageIndex0, initialPostModelList: _PostList);
          postmainControllerl.refreshData(AllSmallUtil.shuffleArray(list));
        }).catchError((error) {
          // 处理错误
          debugPrint('数据加载失败: $error');
          setState(() {
            _isLoading0 = false;
          });
        });
      } else {
        if (loadMore) {
          pageIndex0++;
        } else {
          pageIndex0 = 1;
        }
        Future.delayed(const Duration(seconds: 1), () async {
          setState(() {
            _isLoading0 = false;
          });
          var list = await postmainControllerl.getPageData(
              pageIndex: pageIndex0, initialPostModelList: _PostList);
          debugPrint('${list.length}');
          postmainControllerl.loadMoreData(list);
        }).catchError((error) {
          // 处理错误
          debugPrint('数据加载失败: $error');
          setState(() {
            _isLoading = false;
          });
        });
      }
    } else if (index == 1) {
      // 节流
      setState(() {
        _isLoading = true;
      });

      if (toporbootm) {
        // 下拉刷新
        // 模拟数据加载操作
        // 原定要发出请求 超时处理
        Future.delayed(const Duration(seconds: 1), () async {
          setState(() {
            _isLoading = false;
          });
          pageIndex = 1;
          var list = await postmainController.getPageData(
              pageIndex: pageIndex, initialPostModelList: _PostList);
          postmainController.refreshData(AllSmallUtil.shuffleArray(list));
        }).catchError((error) {
          // 处理错误
          debugPrint('数据加载失败: $error');
          setState(() {
            _isLoading = false;
          });
        });
      } else {
        if (loadMore) {
          pageIndex++;
        } else {
          pageIndex = 1;
        }
        Future.delayed(const Duration(seconds: 1), () async {
          setState(() {
            _isLoading = false;
          });
          var list = await postmainController.getPageData(
              pageIndex: pageIndex, initialPostModelList: _PostList);
          debugPrint('${list.length}');
          postmainController.loadMoreData(list);
        }).catchError((error) {
          // 处理错误
          debugPrint('数据加载失败: $error');
          setState(() {
            _isLoading = false;
          });
        });
      }
    } else {
      // 节流
      setState(() {
        _isLoading2 = true;
      });

      if (toporbootm) {
        // 下拉刷新
        // 模拟数据加载操作
        // 原定要发出请求 超时处理
        Future.delayed(const Duration(seconds: 1), () async {
          setState(() {
            _isLoading2 = false;
          });
          pageIndex2 = 1;
          // 获取list打乱原定收到接口数据
          var list = await postmainControllerr.getPageData(
              pageIndex: pageIndex2, initialPostModelList: _PostList);
          postmainControllerr.refreshData(AllSmallUtil.shuffleArray(list));
        }).catchError((error) {
          // 处理错误
          debugPrint('数据加载失败: $error');
          setState(() {
            _isLoading2 = false;
          });
        });
      } else {
        // 上拉加载
        if (loadMore) {
          pageIndex2++;
        } else {
          pageIndex2 = 1;
        }
        Future.delayed(const Duration(seconds: 1), () async {
          setState(() {
            _isLoading2 = false;
          });
          // 获取分页数据 如果数据不足需发起请求todo
          var list = await postmainControllerr.getPageData(
              pageIndex: pageIndex2, initialPostModelList: _PostList);
          debugPrint('${list.length}');
          postmainControllerr.loadMoreData(list);
        }).catchError((error) {
          // 处理错误
          debugPrint('数据加载失败: $error');
          setState(() {
            _isLoading2 = false;
          });
        });
      }
    }
  }
}
