class JobFullDetailsModel {
  int? statusCode;
  Body? body;

  JobFullDetailsModel({this.statusCode, this.body});

  JobFullDetailsModel.fromJson(Map<String, dynamic> json) {
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
  JobFullDetails? jobs;

  Data({this.jobs});

  Data.fromJson(Map<String, dynamic> json) {
    jobs = json['jobs'] != null ? JobFullDetails.fromJson(json['jobs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jobs != null) {
      data['jobs'] = jobs!.toJson();
    }
    return data;
  }
}

class JobFullDetails {
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
  String? jobTypeValue;
  String? employerPic;
  String? companyBio;

  JobFullDetails(
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
      this.categoryName,
      this.employerPic,
      this.companyBio,
      this.jobTypeValue});

  JobFullDetails.fromJson(Map<String, dynamic> json) {
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
    jobTypeValue = json['jobTypeValue'];
    employerPic = json['employer_pic'];
    companyBio = json['company_bio'];
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
    data['jobTypeValue'] = jobTypeValue;
    data['employer_pic'] = employerPic;
    data['company_bio'] = companyBio;
    return data;
  }
}