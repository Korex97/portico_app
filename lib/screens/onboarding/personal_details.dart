import 'dart:io';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/controllers/jobs_details_controller.dart';
import 'package:potrico/functions/general_functions.dart';
import 'package:potrico/functions/validators.dart';
import 'package:potrico/models/update_details_model.dart';
import 'package:potrico/screens/onboarding/education_details.dart';
import 'package:potrico/states/authenticated_form_states.dart';
import 'package:sizer/sizer.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../controllers/account_form_controller.dart';
import '../../controllers/cities_controller.dart';
import '../../controllers/countries_controller.dart';
import '../../controllers/details_controller.dart';
import '../../controllers/states_controller.dart';
import '../../models/cities_model.dart';
import '../../models/countries_model.dart';
import '../../models/states_model.dart';
import '../../models/user_details.dart';
import '../../services/base_url.dart';
import '../../states/all_states_state.dart';
import '../../states/cities_state.dart';
import '../../states/countries_state.dart';
import '../../states/user_details_state.dart';
import '../widgets/widgets.dart';
import 'company_details.dart';
import 'login.dart';

class PersonalDetailsUpdate extends ConsumerStatefulWidget {
  final String userType;
  final bool editRoute;
  final Widget backRoute;

  const PersonalDetailsUpdate(
      {super.key,
      required this.userType,
      this.editRoute = false,
      required this.backRoute});

  @override
  ConsumerState<PersonalDetailsUpdate> createState() =>
      _PersonalDetailsUpdateState();
}

class _PersonalDetailsUpdateState extends ConsumerState<PersonalDetailsUpdate>
    with AutomaticKeepAliveClientMixin<PersonalDetailsUpdate> {
  final userDetailsProvider = StateProvider<UserData>((ref) => UserData());
  final countriesProvider = StateProvider<List>((ref) => []);
  final statesProvider = StateProvider<List>((ref) => []);
  final citiesDetailsProvider = StateProvider<List>((ref) => []);
  UserData userDetails = UserData();
  List allCountries = [];
  List countryStates = [];
  List stateCities = [];

  List cityList = [
    {'name': 'Select City', 'value': ''},
  ];
  String? selectedCity;

  List stateList = [
    {'name': 'Select State', 'value': ''},
  ];
  String? selectedState;

  List countryList = [
    {'name': 'Select Country', 'value': ''},
  ];
  String? selectedCountry;

  List genderList = [
    {'name': 'Select Gender', 'value': ''},
    {'name': 'Male', 'value': 'male'},
    {'name': 'Female', 'value': 'female'}
  ];
  String? selectedGender;

  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isLoading = false;
  bool loading = false;
  File? imagePath;


  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Consumer(builder: (context, ref, child) {
      Future.delayed(Duration.zero, () async {
        await detailsStateValidation();
        await checkDetailsState();
        await getStates();
        await getCountries();
        await getCities();
      });
      userDetails = ref.read(userDetailsProvider.notifier).state;
      countryList = ref.read(countriesProvider.notifier).state;
      stateList = ref.read(statesProvider.notifier).state;
      cityList = ref.read(citiesDetailsProvider.notifier).state;

      if (widget.editRoute) {
        nameController.text =
            (userDetails.fullname != null) ? userDetails.fullname! : "";
        locationController.text =
            (userDetails.location != null) ? userDetails.location! : "";
        pinCodeController.text =
            (userDetails.zipcode != null) ? userDetails.zipcode! : "";
        phoneController.text =
            (userDetails.phoneno != null) ? userDetails.phoneno! : "";
        nameController.text =
            (userDetails.fullname != null) ? userDetails.fullname! : "";
        selectedGender = (userDetails.sex != null) ? userDetails.sex! : "";
        selectedCountry =
            (userDetails.country != null) ? userDetails.country! : "";
        selectedState = (userDetails.state != null) ? userDetails.state! : "";
        selectedCity = (userDetails.city != null) ? userDetails.city! : "";
      }
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 6.h, left: 5.w, right: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadStyle(
                    backRoute: widget.backRoute,
                    firstImage: "assets/images/arrow-left-fill.png",
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  AutoSizeText(
                    "Your Details",
                    style: fontRoboto(
                      textStyle: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: porticoBlackText,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: () async {
                      File? imageSelected = await getImage();
                      if (imageSelected != null) {
                        setState(() {
                          imagePath = imageSelected;
                        });
                      }
                    },
                    child: Center(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          if (widget.editRoute) ...[
                            if (userDetails.profilePic != null) ...[
                              CircleAvatar(
                                radius: 8.h,
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                    "${BaseUrl.imageUrl}${userDetails.profilePic}"),
                              ),
                            ] else ...[
                              Image.asset("assets/images/twitter_icon.png"),
                            ],
                          ] else ...[
                            if (imagePath == null)
                              Image.asset("assets/images/twitter_icon.png"),
                            if (imagePath != null)
                              CircleAvatar(
                                radius: 8.h,
                                backgroundColor: Colors.transparent,
                                // backgroundImage: FileImage(imagePath!),
                                backgroundImage: FileImage(imagePath!),
                              ),
                          ],
                          Image.asset("assets/images/camera.png"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  AutoSizeText(
                    "NAME",
                    style: fontRoboto(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: porticoGrey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  SizedBox(
                    child: TextFormField(
                      controller: nameController,
                      enableSuggestions: false,
                      autocorrect: false,
                      style: fontRoboto(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: porticoBlack,
                        ),
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: porticoLGrey,
                            width: 1.0,
                          ),
                        ),
                        focusColor: porticoGrey,
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: porticoLGrey,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: porticoGrey,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Kindly enter your fullname",
                        hintStyle: fontRoboto(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: porticoBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  AutoSizeText(
                    "PHONE NUMBER",
                    style: fontRoboto(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: porticoGrey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  SizedBox(
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      enableSuggestions: false,
                      autocorrect: false,
                      style: fontRoboto(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: porticoBlack,
                        ),
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: porticoLGrey,
                            width: 1.0,
                          ),
                        ),
                        focusColor: porticoGrey,
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: porticoLGrey,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: porticoGrey,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Enter your phone number",
                        hintStyle: fontRoboto(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: porticoBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  AutoSizeText(
                    "LOCATION",
                    style: fontRoboto(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: porticoGrey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  SizedBox(
                    child: TextFormField(
                      controller: locationController,
                      enableSuggestions: false,
                      autocorrect: false,
                      style: fontRoboto(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: porticoBlack,
                        ),
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: porticoLGrey,
                            width: 1.0,
                          ),
                        ),
                        focusColor: porticoGrey,
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: porticoLGrey,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: porticoGrey,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Kindly enter your address or location of stay",
                        hintStyle: fontRoboto(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: porticoBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  AutoSizeText(
                    "Country",
                    style: fontRoboto(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: porticoGrey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  SizedBox(
                    child: DropdownButtonFormField(
                      style: fontRoboto(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: porticoBlack,
                        ),
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: porticoLGrey,
                            width: 1.0,
                          ),
                        ),
                        focusColor: porticoGrey,
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: porticoLGrey,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                              color: porticoGrey,
                              width: 1.0,
                              style: BorderStyle.solid),
                        ),
                        hintStyle: fontRoboto(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: porticoBlack,
                          ),
                        ),
                      ),
                      hint: const Text("Select Your Country"),
                      value: selectedCountry,
                      onChanged: (value) {
                        setState(() {
                          if (value != null && value != "") {
                            selectedCountry = value;
                            ref
                                .read(statesControllerProvider.notifier)
                                .getAllStates(selectedCountry!);
                          }
                        });
                      },
                      items: countryList.map((account) {
                        return DropdownMenuItem<String>(
                          value: account['value'],
                          child: Text(account['name']),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 43.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "STATE",
                              style: fontRoboto(
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: porticoGrey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            SizedBox(
                              width: 43.w,
                              child: DropdownButtonFormField(
                                style: fontRoboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: porticoBlack,
                                  ),
                                ),
                                isExpanded: true,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: porticoLGrey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusColor: porticoGrey,
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(
                                          color: porticoLGrey,
                                          width: 1.0,
                                          style: BorderStyle.solid)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: porticoGrey,
                                        width: 1.0,
                                        style: BorderStyle.solid),
                                  ),
                                  hintStyle: fontRoboto(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: porticoBlack,
                                    ),
                                  ),
                                ),
                                hint: const Text("Select State"),
                                value: selectedState,
                                onChanged: (value) {
                                  setState(() {
                                    if (value != null && value != "") {
                                      selectedState = value;
                                      ref
                                          .read(
                                              citiesControllerProvider.notifier)
                                          .getAllCities(selectedState!);
                                    }
                                  });
                                },
                                items: stateList.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item['value'],
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.w),
                                      child: AutoSizeText(item['name']),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 43.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "CITY",
                              style: fontRoboto(
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: porticoGrey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            SizedBox(
                              width: 43.w,
                              child: DropdownButtonFormField(
                                style: fontRoboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: porticoBlack,
                                  ),
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: porticoLGrey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusColor: porticoGrey,
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(
                                          color: porticoLGrey,
                                          width: 1.0,
                                          style: BorderStyle.solid)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: porticoGrey,
                                        width: 1.0,
                                        style: BorderStyle.solid),
                                  ),
                                  hintStyle: fontRoboto(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: porticoBlack,
                                    ),
                                  ),
                                ),
                                isExpanded: true,
                                hint: const Text("Select City"),
                                value: selectedCity,
                                onChanged: (value) {
                                  setState(() {
                                    if (value != null && value != "") {
                                      selectedCity = value;
                                    }
                                  });
                                },
                                items: cityList.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item['value'],
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.w),
                                      child: AutoSizeText(item['name']),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 45.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "GENDER",
                              textAlign: TextAlign.left,
                              style: fontRoboto(
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: porticoGrey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            SizedBox(
                              width: 43.w,
                              child: DropdownButtonFormField(
                                style: fontRoboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: porticoBlack,
                                  ),
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: porticoLGrey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusColor: porticoGrey,
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(
                                          color: porticoLGrey,
                                          width: 1.0,
                                          style: BorderStyle.solid)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: porticoGrey,
                                        width: 1.0,
                                        style: BorderStyle.solid),
                                  ),
                                  hintStyle: fontRoboto(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: porticoBlack,
                                    ),
                                  ),
                                ),
                                hint: const Text("Select Gender"),
                                value: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    if (value != null && value != "") {
                                      selectedGender = value;
                                    }
                                  });
                                },
                                items: genderList.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item['value'],
                                    child: Text(item['name']),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 43.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "PINCODE",
                              style: fontRoboto(
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: porticoGrey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            SizedBox(
                              child: TextFormField(
                                controller: pinCodeController,
                                enableSuggestions: false,
                                autocorrect: false,
                                style: fontRoboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: porticoBlack,
                                  ),
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: porticoLGrey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusColor: porticoGrey,
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(
                                          color: porticoLGrey,
                                          width: 1.0,
                                          style: BorderStyle.solid)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(
                                          color: porticoGrey,
                                          width: 1.0,
                                          style: BorderStyle.solid)),
                                  hintText: "Enter your postal code",
                                  hintStyle: fontRoboto(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: porticoBlack,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  InkWell(
                    onTap: () {
                      if (!isLoading) {
                        updateDetails();
                      }
                    },
                    child: PotricoButton(
                      buttonText: "Next",
                      loading: isLoading,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void updateDetails() {
    if (nameController.text.isEmpty ||
        locationController.text.isEmpty ||
        phoneController.text.isEmpty ||
        selectedCity == null ||
        selectedCity == '' ||
        selectedState == null ||
        selectedState == '' ||
        selectedCountry == null ||
        selectedCountry == '' ||
        selectedGender == null ||
        selectedGender == '') {
      showErrorToast(context, "Insert all Fields");
    } else if (!validator.validatePhone(phoneController.text)) {
      showErrorToast(context, "Insert a valid Phone Number");
    } else if (imagePath == null && !widget.editRoute) {
      showErrorToast(context, "Kindly upload image");
    } else {
      UpdateDetails details = UpdateDetails(
          phoneController.text,
          nameController.text,
          selectedState!,
          selectedCity!,
          selectedCountry!,
          locationController.text,
          selectedGender!,
          pinCodeController.text,
          (imagePath != null) ? imagePath : null,
          currentImage: (imagePath == null && userDetails.profilePic != null)
              ? userDetails.profilePic!
              : "");

      // log(details.country);

      ref.read(accountFormControllerProvider.notifier).updateInfo(details);
    }
  }

  detailsStateValidation() async {
    var myState = ref.watch(accountFormControllerProvider);
    if (myState is AuthenticatedFormStateLaoding) {
      Future.delayed(Duration.zero, () {
        setState(() {
          isLoading = true;
        });
      });
    } else {
      Future.delayed(Duration.zero, () {
        setState(() {
          isLoading = false;
        });
      });

      if (myState is AuthenticatedFormStateerror) {
        Future.delayed(Duration.zero, () {
          showErrorToast(context, myState.error);
          ref.read(accountFormControllerProvider.notifier).resetState();
        });
      }

      if (myState is AuthenticatedFormStateSuccess) {
        if (myState.successData.body!.status!) {
          showSuccessToast(context, myState.successData.body!.text!);
          ref.read(accountFormControllerProvider.notifier).resetState();
          ref.read(userDetailsControllerProvider.notifier).getDetails();
          ref.read(jobDetailsControllerProvider.notifier).getJobPosted();
          Future.delayed(Duration.zero, () {
            if (widget.userType == "1") {
              goToPage(
                context,
                EducationDetails(
                  backRoute: widget.backRoute,
                ),
              );
            }
            if (widget.userType == "2") {
              goToPage(
                context,
                EmployerCompanyDetails(backRoute: widget.backRoute,),
              );
            }
          });
        } else {
          Future.delayed(Duration.zero, () {
            showErrorToast(
              context,
              myState.successData.body!.text!,
            );
            ref.read(accountFormControllerProvider.notifier).resetState();
          });
        }
      }
    }
  }

  checkDetailsState() async {
    final myState = ref.watch(userDetailsControllerProvider);
    if (myState is UserDetailsStateLaoding) {
      Future.delayed(Duration.zero, () {
        setState(() {
          loading = true;
        });
      });
    } else {
      // remove loading
      Future.delayed(Duration.zero, () {
        setState(() {
          loading = false;
        });
      });
      // state validation
      if (myState is UserDetailsStateError) {
        Future.delayed(Duration.zero, () {
          showErrorToast(context, myState.error);
          ref.read(userDetailsControllerProvider.notifier).resetState();
        });
      }

      if (myState is UserDetailsStateSuccess) {
        UserDetails success = myState.successData;
        // check authentication
        if (success.statusCode == 401) {
          Future.delayed(Duration.zero, () {
            showErrorToast(context, "User not authorized");
            ref.read(userDetailsControllerProvider.notifier).resetState();
            goToPage(context, const LoginUser());
          });
        }

        // check for errors
        if (success.statusCode == 200) {
          Future.delayed(Duration.zero, () {
            ref.read(userDetailsProvider.notifier).state = success.body!.data!;
          });
        } else {
          Future.delayed(Duration.zero, () {
            showErrorToast(context, success.body!.text!);
            ref.read(userDetailsControllerProvider.notifier).resetState();
          });
        }
      }
    }
  }

  getCountries() async {
    final myState = ref.watch(countriesControllerProvider);
    if (myState is CountryStateSuccess) {
      CountriesModel countries = myState.successData;
      List<Countries> countryfulList =
          (countries.countries != null) ? countries.countries! : [];

      List eachCountry = [
        {'name': 'Select Country', 'value': ''}
      ];

      if (countryfulList.isNotEmpty) {
        for (var item in countryfulList) {
          eachCountry
              .add({'name': item.countryName, 'value': item.countryName});
        }
        ref.read(countriesProvider.notifier).state = eachCountry;
      } else {
        ref.read(countriesProvider.notifier).state = eachCountry;
      }

      ref.read(countriesControllerProvider.notifier).resetState();
    }

    if (myState is CountryStateError) {
      showErrorToast(context, myState.error);
      ref.read(countriesControllerProvider.notifier).resetState();
    }
  }

  getStates() async {
    final myState = ref.watch(statesControllerProvider);
    if (myState is AllStatesStateSuccess) {
      StatesModel states = myState.successData;
      List<States> statesfulList =
          (states.states != null) ? states.states! : [];

      List eachStates = [
        {'name': 'Select State', 'value': ''}
      ];

      if (statesfulList.isNotEmpty) {
        for (var item in statesfulList) {
          eachStates.add({'name': item.stateName, 'value': item.stateName});
        }
        // log(eachStates.toString());

        ref.read(statesProvider.notifier).state = eachStates;
      } else {
        ref.read(statesProvider.notifier).state = eachStates;
      }
      ref.read(statesControllerProvider.notifier).resetState();
    }

    if (myState is AllStatesStateError) {
      showErrorToast(context, myState.error);
      ref.read(statesControllerProvider.notifier).resetState();
    }
  }

  getCities() async {
    final myState = ref.watch(citiesControllerProvider);
    if (myState is CitiesStateSuccess) {
      CitiesModel cities = myState.successData;
      List<Cities> citiesfulList =
          (cities.cities != null) ? cities.cities! : [];

      List eachCity = [
        {'name': 'Select City', 'value': ''}
      ];

      if (citiesfulList.isNotEmpty) {
        for (var item in citiesfulList) {
          eachCity.add({'name': item.cityName, 'value': item.cityName});
        }
        log(eachCity.toString());
        ref.read(citiesDetailsProvider.notifier).state = eachCity;
      } else {
        ref.read(citiesDetailsProvider.notifier).state = eachCity;
      }
      ref.read(citiesControllerProvider.notifier).resetState();
    }

    if (myState is CitiesStateError) {
      showErrorToast(context, myState.error);
      ref.read(citiesControllerProvider.notifier).resetState();
    }
  }
}
