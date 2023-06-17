class ApplicantDetailsModel {
  int? statusCode;
  Body? body;

  ApplicantDetailsModel({this.statusCode, this.body});

  ApplicantDetailsModel.fromJson(Map<String, dynamic> json) {
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
  ApplicantData? data;

  Body({this.status, this.text, this.data});

  Body.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    text = json['text'];
    data = json['data'] != null ? ( json['data'] is List )? null :ApplicantData.fromJson(json['data']) : null;
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

class ApplicantData {
  String? id;
  String? jobId;
  String? userId;
  String? resume;
  int? status;
  String? createdAt;
  String? email;
  String? phoneno;
  String? profilePic;
  String? fullname;
  String? sex;
  String? location;
  String? city;
  String? state;
  String? country;
  String? statusValue;
  List<UserExperience>? userExperience;
  List<UserEducation>? userEducation;

  ApplicantData(
      {this.id,
      this.jobId,
      this.userId,
      this.resume,
      this.status,
      this.createdAt,
      this.email,
      this.phoneno,
      this.profilePic,
      this.fullname,
      this.sex,
      this.location,
      this.city,
      this.state,
      this.country,
      this.statusValue,
      this.userExperience,
      this.userEducation});

  ApplicantData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    userId = json['user_id'];
    resume = json['resume'];
    status = json['status'];
    createdAt = json['created_at'];
    email = json['email'];
    phoneno = json['phoneno'];
    profilePic = json['profile_pic'];
    fullname = json['fullname'];
    sex = json['sex'];
    location = json['location'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    statusValue = json['statusValue'];
    if (json['user_experience'] != null) {
      userExperience = <UserExperience>[];
      json['user_experience'].forEach((v) {
        userExperience!.add(UserExperience.fromJson(v));
      });
    }
    if (json['user_education'] != null) {
      userEducation = <UserEducation>[];
      json['user_education'].forEach((v) {
        userEducation!.add(UserEducation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['job_id'] = jobId;
    data['user_id'] = userId;
    data['resume'] = resume;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['email'] = email;
    data['phoneno'] = phoneno;
    data['profile_pic'] = profilePic;
    data['fullname'] = fullname;
    data['sex'] = sex;
    data['location'] = location;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['statusValue'] = statusValue;
    if (userExperience != null) {
      data['user_experience'] =
          userExperience!.map((v) => v.toJson()).toList();
    }
    if (userEducation != null) {
      data['user_education'] =
          userEducation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserExperience {
  String? experienceId;
  String? userId;
  String? company;
  String? role;
  String? startDate;
  String? endDate;
  String? state;

  UserExperience(
      {this.experienceId,
      this.userId,
      this.company,
      this.role,
      this.startDate,
      this.endDate,
      this.state});

  UserExperience.fromJson(Map<String, dynamic> json) {
    experienceId = json['experience_id'];
    userId = json['user_id'];
    company = json['company'];
    role = json['role'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['experience_id'] = experienceId;
    data['user_id'] = userId;
    data['company'] = company;
    data['role'] = role;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['state'] = state;
    return data;
  }
}

class UserEducation {
  String? educationId;
  String? userId;
  String? schoolName;
  String? certificate;
  String? field;
  String? startDate;
  String? endDate;
  String? state;

  UserEducation(
      {this.educationId,
      this.userId,
      this.schoolName,
      this.certificate,
      this.field,
      this.startDate,
      this.endDate,
      this.state});

  UserEducation.fromJson(Map<String, dynamic> json) {
    educationId = json['education_id'];
    userId = json['user_id'];
    schoolName = json['school_name'];
    certificate = json['certificate'];
    field = json['field'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['education_id'] = educationId;
    data['user_id'] = userId;
    data['school_name'] = schoolName;
    data['certificate'] = certificate;
    data['field'] = field;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['state'] = state;
    return data;
  }
}