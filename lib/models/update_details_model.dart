import 'dart:io';

class UpdateDetails {
  late String phoneno;
  late String fullname;
  late String state;
  late String city;
  late String country;
  late String address;
  late String gender;
  late String zipcode;
  late File? imageChosen;
  late String currentImage;

  UpdateDetails(
    this.phoneno,
    this.fullname,
    this.state,
    this.city,
    this.country,
    this.address,
    this.gender,
    this.zipcode,
    this.imageChosen,
    {this.currentImage = ""}
  );
}
