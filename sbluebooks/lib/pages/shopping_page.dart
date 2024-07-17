// 购物页面
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comlogin_sdk/util/navigator_util.dart';
import 'package:comlogin_sdk/util/padding_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sbluebooks/dao/Commodity_dao.dart';
import 'package:sbluebooks/model/Commodity_model.dart';
import 'package:sbluebooks/pages/shopping_detail_page.dart';
import 'package:sbluebooks/util/allsmallutil.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  bool isString = false;
  TextEditingController textEditingController = TextEditingController();
  final ScrollController _scrollScroller = ScrollController();
  final ScrollController _iconscrollScroller = ScrollController();
  double _sliderPosition = 0;
  final List<CommodityModel> _commodityList = [
    CommodityModel(
        imgurl: [
          'https://gd-hbimg.huaban.com/c5133d370833f5d7ded1dae6d275a93c25d2dd8568630-BBADIm_fw658webp',
        ],
        name: '芋泥小蛋糕',
        price: 14.69,
        buyed: 40000,
        tag: 1,
        evaluates: [
          Evaluates(
              avatar: 'assets/images/tx.jpg',
              username: '芋泥啵啵小蛋糕',
              grade: 4.6,
              content: '太喜欢了',
              time: DateTime.now().microsecondsSinceEpoch,
              location: '广东',
              like: 4,
              specification: ''),
          Evaluates(
              avatar: 'assets/images/tx.jpg',
              username: '芋泥啵啵小蛋糕',
              grade: 4.6,
              content: '太喜欢了',
              time: DateTime.now().microsecondsSinceEpoch,
              location: '广东',
              like: 4,
              specification: ''),
        ],
        safeguard: 1,
        ishave: 1,
        location: '湖南',
        sendshow: 0,
        store: Store(
            name: '小东家的蛋',
            avatar:
                'https://gd-hbimg.huaban.com/c35f0113e5ffa451d0fb21147a418f8da639a6d826d940-MYLguD_fw658webp',
            fan: 4983,
            allbuyed: 15133,
            gradestore: 4,
            commodity: [
              Commodity(
                  img:
                      'https://gd-hbimg.huaban.com/c5133d370833f5d7ded1dae6d275a93c25d2dd8568630-BBADIm_fw658webp',
                  name: '芋泥波波小蛋糕',
                  price: 25),
              Commodity(
                  img:
                      'https://gd-hbimg.huaban.com/c5133d370833f5d7ded1dae6d275a93c25d2dd8568630-BBADIm_fw658webp',
                  name: '芋泥波波小蛋糕',
                  price: 25),
              Commodity(
                  img:
                      'https://gd-hbimg.huaban.com/c5133d370833f5d7ded1dae6d275a93c25d2dd8568630-BBADIm_fw658webp',
                  name: '芋泥波波小蛋糕',
                  price: 25),
            ]),
        detail: ''),
    CommodityModel(
        imgurl: [
          'https://gd-hbimg.huaban.com/66be2a6ec623cd4c711cfcbc0862adacb9fa071824b4e8-zj5dX3_fw658webp',
          'https://gd-hbimg.huaban.com/a13b090c75032d679762bd3eab31ac3e9339c00223a68c-lgKJQO_fw658webp'
        ],
        name: '奶油沙冰',
        price: 18.69,
        buyed: 1000,
        tag: 0,
        evaluates: [
          Evaluates(
              avatar: 'assets/images/tx.jpg',
              username: '芋泥啵啵小蛋糕',
              grade: 4.6,
              content: '太喜欢了',
              time: DateTime.now().microsecondsSinceEpoch,
              location: '广东',
              like: 4,
              specification: ''),
          Evaluates(
              avatar: 'assets/images/tx.jpg',
              username: '芋泥啵啵小蛋糕',
              grade: 4.6,
              content: '太喜欢了',
              time: DateTime.now().microsecondsSinceEpoch,
              location: '广东',
              like: 4,
              specification: ''),
        ],
        safeguard: 1,
        ishave: 1,
        location: '湖南',
        sendshow: 0,
        store: Store(
            name: '小东家的蛋',
            fan: 4983,
            allbuyed: 15133,
            gradestore: 4,
            commodity: []),
        detail: ''),
    CommodityModel(
        imgurl: [
          'https://gd-hbimg.huaban.com/66be2a6ec623cd4c711cfcbc0862adacb9fa071824b4e8-zj5dX3_fw658webp',
          'https://gd-hbimg.huaban.com/a13b090c75032d679762bd3eab31ac3e9339c00223a68c-lgKJQO_fw658webp'
        ],
        name: '奶油沙冰',
        price: 18.69,
        buyed: 1000,
        tag: 0,
        evaluates: [
          Evaluates(
              avatar: 'assets/images/tx.jpg',
              username: '芋泥啵啵小蛋糕',
              grade: 4.6,
              content: '太喜欢了',
              time: DateTime.now().microsecondsSinceEpoch,
              location: '广东',
              like: 4,
              specification: ''),
          Evaluates(
              avatar: 'assets/images/tx.jpg',
              username: '芋泥啵啵小蛋糕',
              grade: 4.6,
              content: '太喜欢了',
              time: DateTime.now().microsecondsSinceEpoch,
              location: '广东',
              like: 4,
              specification: ''),
        ],
        safeguard: 1,
        ishave: 1,
        location: '湖南',
        sendshow: 0,
        store: Store(
            name: '小东家的蛋',
            fan: 4983,
            allbuyed: 15133,
            gradestore: 4,
            commodity: []),
        detail: '')
  ];
  late CommodityController commodityController; //stream控制器

  Widget itemWidget(int index, List<CommodityModel> list) {
    CommodityModel model = list[index];
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.all(
        Radius.circular(4.0),
      ),
      child: InkWell(
        child: Hero(
          tag: model,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child:
                    //  Image.network(
                    //   imgPath,
                    //   fit: BoxFit.fill,
                    // ),
                    AspectRatio(
                  aspectRatio: 0.9,
                  child: CachedNetworkImage(
                    // height: 300,  先渲染高度再获取网络图片  后端获取图片高度并处理返回
                    imageUrl: model.imgurl![0],
                    fit: BoxFit.fill,
                  ),
                )),
            5.paddingHeight,
            Text(
              '  ${model.name!}',
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
              children: [
                const Text(
                  "  ￥",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 38, 37, 37),
                      fontSize: 12,
                      letterSpacing: 0.5),
                ),
                Text(
                  model.price.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 38, 37, 37),
                      fontSize: 14,
                      letterSpacing: 0.5),
                ),
                8.paddingWidth,
                if (model.tag == 1)
                  Text(
                    '${AllSmallUtil.intToShort(model.buyed!)}+的人已买',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
              ],
            ),
            // 各种标签 todo eg 新客......      判断是否插入广告 todo
            10.paddingHeight
          ]),
        ),
        onTap: () async {
          await NavigatorUtil.push(context, ShoppingDetailPage(model: model));
        },
      ),
    );
  }

  @override
  void initState() {
    _doInit();
    super.initState();
  }

  @override
  void dispose() {
    _scrollScroller.dispose();
    _iconscrollScroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 246, 245, 245),
        appBar: _appbar,
        body: StreamBuilder(
            stream: commodityController.commodityStreamController.stream,
            builder: (BuildContext context,
                AsyncSnapshot<List<CommodityModel>> snapshot) {
              return snapshot.connectionState == ConnectionState.active
                  ? RefreshIndicator(
                      onRefresh: _onRefresh,
                      color: const Color.fromARGB(255, 240, 38, 23),
                      child: SingleChildScrollView(
                        controller: _scrollScroller,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(children: [
                            _iconbtns,
                            10.paddingHeight,
                            MasonryGridView.count(
                              crossAxisCount: 2,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  itemWidget(index, snapshot.data!),
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 3,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                            )
                          ]),
                        ),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
            }));
  }

  void _doInit() async {
    commodityController = CommodityController(
        initialCommodityList: [..._commodityList],
        scrollController: _scrollScroller);
    commodityController.widgetReady();
    // commodityController.addCommodity(_commodityList);
    // var list = await commodityController.getPageData(
    //     pageSize: 10, initialCoMModityModelList: _commodityList);
    // commodityController.loadMoreDate(_commodityList);
    _iconscrollScroller.addListener(() {
      double offset = _iconscrollScroller.offset;
      double maxScrollExtent = _iconscrollScroller.position.maxScrollExtent;
      double sliderPosition = offset / maxScrollExtent; // 计算滑块位置占比
      setState(() {
        _sliderPosition = sliderPosition;
      });
    });
  }

  Future<void> _onRefresh() async {}

// 跳转订单
  void gotoorder() {}

  get _appbar {
    return AppBar(
        title: Row(
          children: [
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
                        cursorColor: Colors.red,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          // contentPadding: EdgeInsets.only(bottom: 0),
                          hintText: '男士穿搭', //后面换成接口根据账号随机返回关键字 按时间随便更新
                          hintStyle:
                              TextStyle(color: Colors.grey[500], fontSize: 15),
                          border: InputBorder.none,
                          // contentPadding: EdgeInsets.all(1),
                        ),
                        // 点击时跳转到页面或者更换
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
          5.paddingWidth,
          GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.more_horiz,
                size: 26,
                color: Colors.grey[700],
              )),
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

  get _iconbtns {
    return SizedBox(
      height: 90,
      child: Column(
        children: [
          8.paddingHeight,
          Expanded(
            child: ListView(
              controller: _iconscrollScroller,
              scrollDirection: Axis.horizontal,
              children: [
                IconButtonNav(
                  icon: Icons.assignment_outlined,
                  t1: '我的订单',
                  ontap: gotoorder,
                ),
                IconButtonNav(
                  icon: Icons.shopping_cart_outlined,
                  t1: '购物车',
                  ontap: gotoorder,
                ),
                IconButtonNav(
                  icon: Icons.messenger_outline,
                  t1: '客服消息',
                  ontap: gotoorder,
                ),
                IconButtonNav(
                  icon: Icons.store_outlined,
                  t1: '关注店铺',
                  ontap: gotoorder,
                ),
                IconButtonNav(
                  icon: Icons.history,
                  t1: '浏览记录',
                  ontap: gotoorder,
                ),
                IconButtonNav(
                  icon: Icons.loyalty_outlined,
                  t1: '心愿单',
                  ontap: gotoorder,
                ),
                IconButtonNav(
                  icon: Icons.confirmation_number_outlined,
                  t1: '卡卷',
                  ontap: gotoorder,
                ),
              ],
            ),
          ),
          // 自定义滑块根据 listview滑动自动移动
          Container(
            width: 30,
            height: 4,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.grey[400]),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Positioned(
                  left: 15 * _sliderPosition, // 根据滑动比例调整滑块的左边缘位置
                  child: Container(
                    width: 15,
                    height: 4,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black87),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// 购物车 浏览记录 等组件
class IconButtonNav extends StatelessWidget {
  final IconData icon;
  final String t1;
  final VoidCallback? ontap;
  const IconButtonNav(
      {super.key, required this.icon, required this.t1, this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        // height: 30,
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(4),
            // color: Colors.amberAccent,
            ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.black87,
              ),
              2.paddingHeight,
              Text(
                t1,
                style: TextStyle(color: Colors.black87, fontSize: 14),
              )
            ]),
      ),
    );
  }
}
