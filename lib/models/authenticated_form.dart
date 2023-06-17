class AuthenticatedForm {
  int? statusCode;
  Body? body;

  AuthenticatedForm({this.statusCode, this.body});

  AuthenticatedForm.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (body != null) {
      data['body'] = body!.toJson();
    }
    return data;
  }
}

class Body {
  bool? status;
  String? text;
  List? data;

  Body({this.status, this.text, this.data});

  Body.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    text = json['text'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['text'] = text;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v?.toJson()).toList();
    }
    return data;
  }
}