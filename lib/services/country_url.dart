class CountryUrl {
  static const base = "https://www.universal-tutorial.com/api/";
  static const accessToken = "P8PL9NQ4qFhAksuvFnIY_WQFILvpKfT21s4-iX50hW3fPJSwGsCLMv1jajd2vS1arvQ";
  static const email = "egbeolowoakorede97@gmail.com";
  ////// ge token  ////
  static Uri getToken = Uri.parse("${base}getaccesstoken");

  // ***** Api Endpoint **** // 
  static Uri getCountries = Uri.parse("${base}countries");
  static String getStates = "${base}states";
  static String getCities = "${base}cities";

}
