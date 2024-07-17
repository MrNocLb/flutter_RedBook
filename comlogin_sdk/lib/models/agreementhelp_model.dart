class AgreHelpModel {
  String? title;
  String? explain;
  String? url;

  AgreHelpModel({this.title, this.explain, this.url});

  AgreHelpModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    explain = json['explain'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['explain'] = explain;
    data['url'] = url;
    return data;
  }
}
