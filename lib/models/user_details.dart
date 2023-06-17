class UserDetails {
  int? statusCode;
  Body? body;

  UserDetails({this.statusCode, this.body});

  UserDetails.fromJson(Map<String, dynamic> json) {
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
  UserData? data;

  Body({this.status, this.text, this.data});

  Body.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    text = json['text'];
    data = json['data'] != null ? (json['data'] is List)? null: UserData.fromJson(json['data']) : null;
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

class UserData {
  String? id;
  String? userType;
  String? email;
  String? phoneno;
  String? fullname;
  String? sex;
  String? location;
  String? city;
  String? state;
  String? country;
  String? zipcode;
  String? refcode;
  String? referby;
  String? profilePic;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? userTypeValue;
  List<UserExperience>? userExperience;
  List<UserEducation>? userEducation;
  List<CompanyDetails>? companyDetails;

  UserData(
      {this.id,
      this.userType,
      this.email,
      this.phoneno,
      this.fullname,
      this.sex,
      this.location,
      this.city,
      this.state,
      this.country,
      this.zipcode,
      this.refcode,
      this.referby,
      this.profilePic,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.userTypeValue,
      this.userExperience,
      this.userEducation,
      this.companyDetails});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    email = json['email'];
    phoneno = json['phoneno'];
    fullname = json['fullname'];
    sex = json['sex'];
    location = json['location'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zipcode = json['zipcode'];
    refcode = json['refcode'];
    referby = json['referby'];
    profilePic = json['profile_pic'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userTypeValue = json['userTypeValue'];
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
    if (json['company_details'] != null) {
      companyDetails = <CompanyDetails>[];
      json['company_details'].forEach((v) {
        companyDetails!.add(CompanyDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['email'] = email;
    data['phoneno'] = phoneno;
    data['fullname'] = fullname;
    data['sex'] = sex;
    data['location'] = location;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['zipcode'] = zipcode;
    data['refcode'] = refcode;
    data['referby'] = referby;
    data['profile_pic'] = profilePic;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['userTypeValue'] = userTypeValue;
    if (userExperience != null) {
      data['user_experience'] =
          userExperience!.map((v) => v.toJson()).toList();
    }
    if (userEducation != null) {
      data['user_education'] =
          userEducation!.map((v) => v.toJson()).toList();
    }
    if (companyDetails != null) {
      data['company_details'] =
          companyDetails!.map((v) => v.toJson()).toList();
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
  String? duration;

  UserExperience(
      {this.experienceId,
      this.userId,
      this.company,
      this.role,
      this.startDate,
      this.endDate,
      this.state,
      this.duration,
  });

  UserExperience.fromJson(Map<String, dynamic> json) {
    experienceId = json['experience_id'];
    userId = json['user_id'];
    company = json['company'];
    role = json['role'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    state = json['state'];
    duration = json['duration'];
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
    data['duration'] = duration;
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

class CompanyDetails {
  String? employerId;
  String? userId;
  String? companyName;
  String? companyLocation;
  String? openingDate;
  String? companyBio;
  String? state;

  CompanyDetails(
      {this.employerId,
      this.userId,
      this.companyName,
      this.companyLocation,
      this.openingDate,
      this.companyBio,
      this.state});

  CompanyDetails.fromJson(Map<String, dynamic> json) {
    employerId = json['employer_id'];
    userId = json['user_id'];
    companyName = json['company_name'];
    companyLocation = json['company_location'];
    openingDate = json['opening_date'];
    companyBio = json['company_bio'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employer_id'] = employerId;
    data['user_id'] = userId;
    data['company_name'] = companyName;
    data['company_location'] = companyLocation;
    data['opening_date'] = openingDate;
    data['company_bio'] = companyBio;
    data['state'] = state;
    return data;
  }
}