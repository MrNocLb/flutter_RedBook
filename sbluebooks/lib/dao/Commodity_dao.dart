import 'dart:async';

import 'package:flutter/material.dart';

import '../model/Commodity_model.dart';

class CommodityController implements ICommodityController {
  // 初始化
  final List<CommodityModel> initialCommodityList;
  final ScrollController scrollController;

  CommodityController(
      {required this.initialCommodityList, required this.scrollController});
  StreamController<List<CommodityModel>> commodityStreamController =
      StreamController();

  void dispose() {
    commodityStreamController.close();
    scrollController.dispose();
  }

  @override
  void widgetReady() {
    if (!commodityStreamController.isClosed) {
      commodityStreamController.sink.add(initialCommodityList);
    }
  }

  // 分页查询评论
  Future<List<CommodityModel>> getPageData(
      {int pageSize = 10,
      int pageIndex = 1,
      List<CommodityModel> initialCoMModityModelList = const []}) async {
    // 计算开始和结束的索引
    int start = (pageIndex - 1) * pageSize;
    int end = start + pageSize;

    // 检查索引是否超出列表的范围
    if (start >= initialCoMModityModelList.length) {
      return []; // 如果开始的索引超出了列表的范围，返回空列表
    }

    if (end > initialCoMModityModelList.length) {
      end = initialCoMModityModelList.length; // 如果结束的索引超出了列表的范围，将其设置为列表的长度
    }
    debugPrint('pageIndex ${pageIndex}');
    // 返回指定范围内的评论列表
    return initialCoMModityModelList.sublist(start, end);
  }

  @override
  void addCommodity(CommodityModel model) {
    if (!commodityStreamController.isClosed) {
      initialCommodityList.add(model);
      commodityStreamController.sink.add(initialCommodityList);
    }
  }

// 上拉刷新 将暂存的数据分页获取 若超过两次刷新获得的重置前面的页数
  @override
  void loadMoreDate(List<CommodityModel> commodityList) async {
    if (initialCommodityList.length >= 20) {
      initialCommodityList.removeRange(0, initialCommodityList.length - 10);
    }
    initialCommodityList.addAll(commodityList);
    if (commodityStreamController.isClosed) return;
    commodityStreamController.sink.add(initialCommodityList);
  }

// 下拉刷新 重置数据
  @override
  void refreshData(List<CommodityModel> commodityList) {
    initialCommodityList.clear();
    initialCommodityList.addAll(commodityList);
  }
}

abstract class ICommodityController {
  void widgetReady();
  void addCommodity(CommodityModel model);
  void loadMoreDate(List<CommodityModel> commodityList);
  void refreshData(List<CommodityModel> commodityList);
}
