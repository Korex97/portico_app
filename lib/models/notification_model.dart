class NotificationModel {
  int? statusCode;
  Body? body;

  NotificationModel({this.statusCode, this.body});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  Data? data;

  Body({this.status, this.text, this.data});

  Body.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    text = json['text'];
    data = json['data'] != null ? (json['data'] is List)? null: Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['text'] = text;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<NotificationData>? notifications;

  Data({this.notifications});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <NotificationData>[];
      json['notifications'].forEach((v) {
        notifications!.add(NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notifications != null) {
      data['notifications'] =
          notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  int? id;
  String? userid;
  String? notificationtext;
  String? notificationtype;
  String? transactionid;
  String? notificationstatus;
  String? createdAt;
  String? notificationcode;
  int? seenbyuser;
  String? notificationHeader;
  String? time;

  NotificationData(
      {this.id,
      this.userid,
      this.notificationtext,
      this.notificationtype,
      this.transactionid,
      this.notificationstatus,
      this.createdAt,
      this.notificationcode,
      this.seenbyuser,
      this.notificationHeader,
      this.time});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    notificationtext = json['notificationtext'];
    notificationtype = json['notificationtype'];
    transactionid = json['transactionid'];
    notificationstatus = json['notificationstatus'];
    createdAt = json['created_at'];
    notificationcode = json['notificationcode'];
    seenbyuser = json['seenbyuser'];
    notificationHeader = json['notification_header'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userid'] = userid;
    data['notificationtext'] = notificationtext;
    data['notificationtype'] = notificationtype;
    data['transactionid'] = transactionid;
    data['notificationstatus'] = notificationstatus;
    data['created_at'] = createdAt;
    data['notificationcode'] = notificationcode;
    data['seenbyuser'] = seenbyuser;
    data['notification_header'] = notificationHeader;
    data['time'] = time;
    return data;
  }
}