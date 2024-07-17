class CommodityModel {
  List<String>? imgurl;
  String? name;
  double? price;
  int? buyed;
  int? tag;
  List<Evaluates>? evaluates;
  int? safeguard;
  int? ishave;
  String? location;
  int? sendshow;
  Store? store;
  String? detail;

  CommodityModel(
      {this.imgurl,
      this.name,
      this.price,
      this.buyed,
      this.tag,
      this.evaluates,
      this.safeguard,
      this.ishave,
      this.location,
      this.sendshow,
      this.store,
      this.detail});

  CommodityModel.fromJson(Map<String, dynamic> json) {
    imgurl = json['imgurl'].cast<String>();
    name = json['name'];
    price = json['price'];
    buyed = json['buyed'];
    tag = json['tag'];
    if (json['evaluates'] != null) {
      evaluates = <Evaluates>[];
      json['evaluates'].forEach((v) {
        evaluates!.add(Evaluates.fromJson(v));
      });
    }
    safeguard = json['safeguard'];
    ishave = json['ishave'];
    location = json['location'];
    sendshow = json['sendshow'];
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imgurl'] = imgurl;
    data['name'] = name;
    data['price'] = price;
    data['buyed'] = buyed;
    data['tag'] = tag;
    if (evaluates != null) {
      data['evaluates'] = evaluates!.map((v) => v.toJson()).toList();
    }
    data['safeguard'] = safeguard;
    data['ishave'] = ishave;
    data['location'] = location;
    data['sendshow'] = sendshow;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    data['detail'] = detail;
    return data;
  }
}

class Evaluates {
  String? avatar;
  String? username;
  double? grade;
  String? content;
  int? time;
  String? location;
  int? like;
  String? specification;

  Evaluates(
      {this.avatar,
      this.username,
      this.grade,
      this.content,
      this.time,
      this.location,
      this.like,
      this.specification});

  Evaluates.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    username = json['username'];
    grade = json['grade'];
    content = json['content'];
    time = json['time'];
    location = json['location'];
    like = json['like'];
    specification = json['specification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['username'] = username;
    data['grade'] = grade;
    data['content'] = content;
    data['time'] = time;
    data['location'] = location;
    data['like'] = like;
    data['specification'] = specification;
    return data;
  }
}

class Store {
  String? name;
  String? avatar;
  int? fan;
  int? allbuyed;
  int? gradestore;
  List<Commodity>? commodity;

  Store(
      {this.name,
      this.fan,
      this.allbuyed,
      this.gradestore,
      this.commodity,
      this.avatar});

  Store.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    fan = json['fan'];
    allbuyed = json['allbuyed'];
    gradestore = json['gradestore'];
    if (json['commodity'] != null) {
      commodity = <Commodity>[];
      json['commodity'].forEach((v) {
        commodity!.add(Commodity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['avatar'] = avatar;
    data['fan'] = fan;
    data['allbuyed'] = allbuyed;
    data['gradestore'] = gradestore;
    if (commodity != null) {
      data['commodity'] = commodity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Commodity {
  String? img;
  String? name;
  int? price;

  Commodity({this.img, this.name, this.price});

  Commodity.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['img'] = img;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}

// 
// {
//    "imgurl":[]  ,
//    "name":"str",
//    "price":10.0, 
//    "buyed":10,
//    "tag":1,  标签 0-？ 不同代表不同标签
//   "evaluates":[{
//     "avatar":"url",
//     "username":"str",
//     "grade":5.0,
//     "content":"str",
//     "time":11,
//     "location":"str",
//     "like":1,
//     "specification":"str"  "规格"
//   }]
//   "safeguard":0,  保障标签 0-？
//   "ishave":0,   是否有货
//   "location":"str",
//   "sendshow":0   快递情况
//   "store":{
//     "name":"str",
//     "fan":1,
//     "allbuyed":1,
//     "gradestore":1, 
//     "commodity":[  产品
//       {
//         "img":"str"
//         "name":"set",
//         "price":1.0
//       }
//     ]
//   },
//   "detail":"" 详细
// }
