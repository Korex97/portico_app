class JobDetailsModel {
  int? statusCode;
  Body? body;

  JobDetailsModel({this.statusCode, this.body});

  JobDetailsModel.fromJson(Map<String, dynamic> json) {
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
  List<Jobs>? jobs;

  Data({this.jobs});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(Jobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jobs != null) {
      data['jobs'] = jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jobs {
  String? id;
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
  String? categoryName;

  Jobs(
      {this.id,
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
      this.categoryName});

  Jobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
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
    data['category_name'] = categoryName;
    return data;
  }
}