import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:sbluebooks/model/Post_model.dart';

// 详情页面评论区
class CommentController implements ICommentController {
  // 初始化数据  屏幕控制 stream
  final List<Comments> initialCommentsList;
  final ScrollController scrollController;

  CommentController(
      {required this.initialCommentsList, required this.scrollController});
  StreamController<List<Comments>> commentStreanController = StreamController();

  void dispose() {
    commentStreanController.close();
    scrollController.dispose();
  }

  void widgetReady() {
    // 加载数据
    if (!commentStreanController.isClosed) {
      commentStreanController.sink.add(initialCommentsList);
    }
  }

// 分页查询评论
  Future<List<Comments>> getPageData(
      {int pageSize = 20,
      int pageIndex = 1,
      List<Comments> initialCommentsList = const []}) async {
    // 计算开始和结束的索引
    int start = (pageIndex - 1) * pageSize;
    int end = start + pageSize;

    // 检查索引是否超出列表的范围
    if (start >= initialCommentsList.length) {
      return []; // 如果开始的索引超出了列表的范围，返回空列表
    }

    if (end > initialCommentsList.length) {
      end = initialCommentsList.length; // 如果结束的索引超出了列表的范围，将其设置为列表的长度
    }

    // 返回指定范围内的评论列表
    return initialCommentsList.sublist(start, end);
  }

  @override
  void addComments(Comments comment) {
    if (commentStreanController.isClosed) return;

    initialCommentsList.insert(0, comment);
    // initialCommentsList.add(comment);
    // print(initialCommentsList);
    // commentStreanController.sink.add(initialCommentsList);
  }

  @override
  void deleteComment(Comments comment) {
    if (commentStreanController.isClosed) return;
    // 是否有重复问题
    initialCommentsList.remove(comment);
    commentStreanController.sink.add(initialCommentsList);
  }

  @override
  void loadMoreData(List<Comments> commentList) {
    List<Comments> tempList = [...initialCommentsList, ...commentList];
    initialCommentsList.clear();
    initialCommentsList.addAll(tempList);
    if (commentStreanController.isClosed) return;
    commentStreanController.sink.add(initialCommentsList);
  }
}

abstract class ICommentController {
  void addComments(Comments comment);
  void deleteComment(Comments comment);
  void loadMoreData(List<Comments> commentList);
}
