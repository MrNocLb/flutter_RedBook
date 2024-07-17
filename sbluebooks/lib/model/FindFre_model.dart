// ignore: file_names
class FindfrendModel {
  String? avatar;
  String? username;
  int? comfrecount;
  String? life;
  int? notecount;
  String? page;

  FindfrendModel(
      {this.avatar,
      this.username,
      this.comfrecount,
      this.life,
      this.notecount,
      this.page});

  FindfrendModel.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    username = json['username'];
    comfrecount = json['comfrecount'];
    life = json['life'];
    notecount = json['notecount'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['username'] = username;
    data['comfrecount'] = comfrecount;
    data['life'] = life;
    data['notecount'] = notecount;
    data['page'] = page;
    return data;
  }
}



// {
//   "avatar" :"url",
//   "username": "str",    
//   "comfrecount": 1, //多少个共同好友
//   "life": "url"  //最近活跃时长
//   "notecount":3   //有多少笔记
//   "page" : "model"   //跳转到个人页面的model 目前为先设定为空
 
// }