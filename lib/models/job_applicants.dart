class JobApplicantModel {
  int? statusCode;
  Body? body;

  JobApplicantModel({this.statusCode, this.body});

  JobApplicantModel.fromJson(Map<String, dynamic> json) {
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
    data = json['data'] != null ? (json['data'] is List)? null :Data.fromJson(json['data']) : null;
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
  List<Applicants>? applicants;

  Data({this.applicants});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['applicants'] != null) {
      applicants = <Applicants>[];
      json['applicants'].forEach((v) {
        applicants!.add(Applicants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (applicants != null) {
      data['applicants'] = applicants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Applicants {
  String? resume;
  int? status;
  String? id;
  String? jobId;
  String? jobCategory;
  String? employeeId;
  String? position;
  String? location;
  int? jobType;
  String? expectedSalary;
  String? experienceLevel;
  String? requirements;
  String? createdAt;
  String? updatedAt;
  String? companyName;
  String? companyLocation;
  String? fullname;
  String? email;
  String? phoneno;
  String? profilePic;
  String? userLocation;
  String? categoryName;
  String? statusValue;

  Applicants(
      {this.resume,
      this.status,
      this.id,
      this.jobId,
      this.jobCategory,
      this.employeeId,
      this.position,
      this.location,
      this.jobType,
      this.expectedSalary,
      this.experienceLevel,
      this.requirements,
      this.createdAt,
      this.updatedAt,
      this.companyName,
      this.companyLocation,
      this.fullname,
      this.email,
      this.phoneno,
      this.profilePic,
      this.userLocation,
      this.categoryName,
      this.statusValue});

  Applicants.fromJson(Map<String, dynamic> json) {
    resume = json['resume'];
    status = json['status'];
    id = json['id'];
    jobId = json['job_id'];
    jobCategory = json['job_category'];
    employeeId = json['employee_id'];
    position = json['position'];
    location = json['location'];
    jobType = json['job_type'];
    expectedSalary = json['expected_salary'];
    experienceLevel = json['experience_level'];
    requirements = json['requirements'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    companyName = json['company_name'];
    companyLocation = json['company_location'];
    fullname = json['fullname'];
    email = json['email'];
    phoneno = json['phoneno'];
    profilePic = json['profile_pic'];
    userLocation = json['user_location'];
    categoryName = json['category_name'];
    statusValue = json['statusValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resume'] = resume;
    data['status'] = status;
    data['id'] = id;
    data['job_id'] = jobId;
    data['job_category'] = jobCategory;
    data['employee_id'] = employeeId;
    data['position'] = position;
    data['location'] = location;
    data['job_type'] = jobType;
    data['expected_salary'] = expectedSalary;
    data['experience_level'] = experienceLevel;
    data['requirements'] = requirements;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['company_name'] = companyName;
    data['company_location'] = companyLocation;
    data['fullname'] = fullname;
    data['email'] = email;
    data['phoneno'] = phoneno;
    data['profile_pic'] = profilePic;
    data['user_location'] = userLocation;
    data['category_name'] = categoryName;
    data['statusValue'] = statusValue;
    return data;
  }
}