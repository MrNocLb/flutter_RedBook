class PostModel {
  String? avatar;
  String? username;
  String? title;
  String? content;
  List<String>? tag;
  int? date;
  String? location;
  int? favorite;
  int? like;
  bool? islikeshow;
  String? postId;
  String? userId;
  List<String>? imgurl;
  List<Comments>? comments;

  PostModel(
      {this.avatar,
      this.username,
      this.title,
      this.content,
      this.tag,
      this.date,
      this.location,
      this.favorite,
      this.like,
      this.islikeshow,
      this.postId,
      this.userId,
      this.imgurl,
      this.comments});

  PostModel.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    username = json['username'];
    title = json['title'];
    content = json['content'];
    tag = json['tag'].cast<String>();
    date = json['date'];
    location = json['location'];
    favorite = json['favorite'];
    like = json['like'];
    islikeshow = json['islikeshow'];
    postId = json['post_id'];
    userId = json['user_id'];
    imgurl = json['imgurl'].cast<String>();
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['username'] = username;
    data['title'] = title;
    data['content'] = content;
    data['tag'] = tag;
    data['date'] = date;
    data['location'] = location;
    data['favorite'] = favorite;
    data['like'] = like;
    data['islikeshow'] = islikeshow;
    data['post_id'] = postId;
    data['user_id'] = userId;
    data['imgurl'] = imgurl;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  String? avatar;
  String? username;
  int? like;
  bool? isWrite;
  bool? isTop;
  bool? islikewirte;
  String? content;
  int? date;
  String? location;
  List<Replies>? replies;

  Comments(
      {this.avatar,
      this.username,
      this.like,
      this.isWrite,
      this.isTop,
      this.islikewirte,
      this.content,
      this.date,
      this.location,
      this.replies});

  Comments.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    username = json['username'];
    like = json['like'];
    isWrite = json['isWrite'];
    isTop = json['isTop'];
    islikewirte = json['islikewirte'];
    content = json['content'];
    date = json['date'];
    location = json['location'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['username'] = username;
    data['like'] = like;
    data['isWrite'] = isWrite;
    data['isTop'] = isTop;
    data['islikewirte'] = islikewirte;
    data['content'] = content;
    data['date'] = date;
    data['location'] = location;
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Replies {
  String? avatar;
  String? username;
  int? like;
  bool? isWrite;
  bool? isTop;
  bool? islikewirte;
  String? content;
  int? date;
  String? location;
  List<Replies>? replies;

  Replies(
      {this.avatar,
      this.username,
      this.like,
      this.isWrite,
      this.isTop,
      this.islikewirte,
      this.content,
      this.date,
      this.location,
      this.replies});

  Replies.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    username = json['username'];
    like = json['like'];
    isWrite = json['isWrite'];
    isTop = json['isTop'];
    islikewirte = json['islikewirte'];
    content = json['content'];
    date = json['date'];
    location = json['location'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['username'] = username;
    data['like'] = like;
    data['isWrite'] = isWrite;
    data['isTop'] = isTop;
    data['islikewirte'] = islikewirte;
    data['content'] = content;
    data['date'] = date;
    data['location'] = location;
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// 添加文本样式后续加
// {
//     "avatar": "url",                               头像
//     "username": "str",                             名称
//     "title": "str",                                标题
//     "content": "str",                              内容
//     "tag": "str",                                  标签
//     "date": 1,                                     日期
//     "location": "str"                              地址
//     "favorite": 1,                                 收藏数
//     "like": 1,                                     点赞数
//     "post_id": "str11",                            帖子id
//     "user_id": "st11",                             用户id
//      "imgurl":[]                                   图片数组
//     "comments": [                                  评论
//         {
//             "avatar": "url",                                
//             "username": "str",
//             "like": 1,
//             "isWrite": false,                      是否为作者
//             "isTop": false,                        是否置顶
//             "islikewirte": false,                  作者是否点赞
//             "content": "sr",
//             "date": 1,
//             "location": "str",
//             "replies": [                           回复
//                 {
//                     "avatar": "url",
//                     "username": "str",
//                     "like": 1,
//                     "isWrite": false,
//                     "isTop": false,
//                     "islikewirte": false,
//                     "content": "sr",
//                     "date": 1,
//                     "location": "str",
//                     "replies": []
//                 }
//             ]
//         }
//     ]
// }










