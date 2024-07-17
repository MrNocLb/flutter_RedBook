import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sbluebooks/model/Post_model.dart';

class PostmainController implements IPostmainController {
  // 初始化数据  屏幕控制 stream
  final List<PostModel> initialPostModelList;
  final ScrollController scrollController;

  PostmainController(
      {required this.initialPostModelList, required this.scrollController});
  StreamController<List<PostModel>> postStreanController = BehaviorSubject();
  // rxdart解决广播流无法加载旧数据的问题

  // StreamController<List<PostModel>>.broadcast();
  // StreamController();

  void dispose() {
    postStreanController.close();
    scrollController.dispose();
  }

  void widgetReady() {
    // 加载数据
    if (!postStreanController.isClosed) {
      postStreanController.sink.add(initialPostModelList);
    }
  }

  // 分页查询评论
  Future<List<PostModel>> getPageData(
      {int pageSize = 10,
      int pageIndex = 1,
      List<PostModel> initialPostModelList = const []}) async {
    // 计算开始和结束的索引
    int start = (pageIndex - 1) * pageSize;
    int end = start + pageSize;

    // 检查索引是否超出列表的范围
    if (start >= initialPostModelList.length) {
      return []; // 如果开始的索引超出了列表的范围，返回空列表
    }

    if (end > initialPostModelList.length) {
      end = initialPostModelList.length; // 如果结束的索引超出了列表的范围，将其设置为列表的长度
    }
    debugPrint('pageIndex ${pageIndex}');
    // 返回指定范围内的评论列表
    return initialPostModelList.sublist(start, end);
  }

  @override
  void addPostmain(PostModel model) {
    if (postStreanController.isClosed) return;
    initialPostModelList.add(model);
    postStreanController.sink.add(initialPostModelList);
  }

  // 上拉刷新 如果同时暂存的帖子超过两次刷新获得的 则重置前一次的 12 23 34 只构建页面显示的帖子 传进来一定是10个帖子
  @override
  void loadMoreData(List<PostModel> postmainList) async {
    // 检查暂存的帖子是否超过两次刷新获得的
    if (initialPostModelList.length >= 20) {
      // 重置前一次的数据，只保留最后一次刷新获得的帖子
      initialPostModelList.removeRange(0, initialPostModelList.length - 10);
    }
    // 将新拉取的帖子添加到暂存列表
    initialPostModelList.addAll(postmainList);
    if (postStreanController.isClosed) return;
    postStreanController.sink.add(initialPostModelList);
  }

// 下拉刷新 重置所有数据 并添加新的数据
  @override
  void refreshData(List<PostModel> postmainList) {
    initialPostModelList.clear();
    initialPostModelList.addAll(postmainList);
  }
}

abstract class IPostmainController {
  void addPostmain(PostModel model);
  void loadMoreData(List<PostModel> postmainList);
  void refreshData(List<PostModel> postmainList);
}
