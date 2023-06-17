class AuthModel {
  bool? status;
  String? text;
  Data? data;

  AuthModel({this.status, this.text, this.data});

  AuthModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    text = json['text'];
    data = json['data'] != null ?( ( json['data'] is List)? null:   Data.fromJson(json['data'])  ): null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['text'] = text;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? authtoken;
  String? userType;

  Data({this.authtoken, this.userType});

  Data.fromJson(Map<String, dynamic> json) {
    authtoken = json['authtoken'];
    userType = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authtoken'] = authtoken;
    data['userType'] = userType;
    return data;
  }
}
