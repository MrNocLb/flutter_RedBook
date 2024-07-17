class MessageModel {
  String? avatar;
  String? username;
  int? date;
  int cid;
  int? messageCount;
  String? lastMessage;

  MessageModel(
      {this.avatar,
      this.username,
      this.date,
      required this.cid,
      this.messageCount,
      this.lastMessage});

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        avatar: json['avatar'],
        username: json['username'],
        date: json['date'],
        cid: json['cid'],
        messageCount: json['messageCount'],
        lastMessage: json['lastMessage'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['username'] = username;
    data['date'] = date;
    data['cid'] = cid;
    data['messageCount'] = messageCount;
    data['lastMessage'] = lastMessage;
    return data;
  }
}


// 消息要本地保存 需要一个cid去查找 先弄这么一点等基础效果弄好了再弄 聊天界面
//   是否有新消息 是否为红点 
// {
//   "avatar": "url",                               
//   "username": "str",      
//   "date": 1,                    
//   "cid": 1,
//   "messageCount": 1,
//   "lastMessage": "str", 



// }