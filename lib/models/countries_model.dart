class CountriesModel {
  List<Countries>? countries;

  CountriesModel({this.countries});

  CountriesModel.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(Countries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (countries != null) {
      data['countries'] = countries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countries {
  String? countryName;
  String? countryShortName;
  int? countryPhoneCode;

  Countries({this.countryName, this.countryShortName, this.countryPhoneCode});

  Countries.fromJson(Map<String, dynamic> json) {
    countryName = json['country_name'];
    countryShortName = json['country_short_name'];
    countryPhoneCode = json['country_phone_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_name'] = countryName;
    data['country_short_name'] = countryShortName;
    data['country_phone_code'] = countryPhoneCode;
    return data;
  }
}