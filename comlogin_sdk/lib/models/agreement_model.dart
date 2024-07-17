class AgreementModel {
  String? url;
  String? agreement;

  AgreementModel({this.url, this.agreement});

  AgreementModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    agreement = json['agreement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['agreement'] = agreement;
    return data;
  }
}
