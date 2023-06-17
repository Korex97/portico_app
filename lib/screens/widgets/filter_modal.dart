import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/screens/widgets/widgets.dart';
import 'package:sizer/sizer.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../controllers/jobs_details_controller.dart';
import '../../models/job_category.dart';

class FilterModal extends ConsumerStatefulWidget {
  const FilterModal({super.key, required this.allCategories});

  final List<Categories> allCategories;

  @override
  ConsumerState<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends ConsumerState<FilterModal> {
  List categoriesList = [
    {'name': 'Select Categories', 'value': ''},
  ];
  String? selectedCategory;

  List locationList = [
    {'name': 'Select Location', 'value': ''},
    {'name': 'Ontario, Canada', 'value': '1'},
    {'name': 'Brooklyn, New York', 'value': '2'},
  ];
  String? selectedLocation;

  List distanceList = [
    {'name': 'Select Distance', 'value': ''},
    {'name': '5 miles', 'value': '1'},
    {'name': '10 miles', 'value': '2'},
  ];
  String? selectedDistance;

  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    if (widget.allCategories.isNotEmpty) {
      for (var item in widget.allCategories) {
        categoriesList.add({'name': item.name, 'value': item.id});
      }
    }

    super.initState();
  }

  RangeValues currentRangeValues = const RangeValues(500, 100000);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 70.h,
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.5.h),
      decoration: const BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Center(
            child: Container(
              width: 30.w,
              height: 5,
              decoration: const BoxDecoration(
                color: porticoLightGreyBorder,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          AutoSizeText(
            "Filter Results",
            style: fontRoboto(
              textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: porticoBlack,
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          AutoSizeText(
            "CATEGORIES",
            style: fontRoboto(
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: porticoBlack,
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
                      color: porticoGrey, width: 1.0, style: BorderStyle.solid),
                ),
                hintStyle: fontRoboto(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: porticoBlack,
                  ),
                ),
              ),
              hint: const Text("Select Category"),
              value: selectedCategory,
              onChanged: (value) {
                setState(() {
                  if (value != null && value != "") {
                    selectedCategory = value;
                  }
                });
              },
              items: categoriesList.map((account) {
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
          AutoSizeText(
            "LOCATION",
            style: fontRoboto(
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: porticoBlack,
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
                hintText: "Enter your location",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                "Salary Range",
                style: fontRoboto(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: porticoBlack,
                  ),
                ),
              ),
              AutoSizeText(
                "\$ ${currentRangeValues.start.round().toString()} - \$ ${currentRangeValues.end.round().toString()}",
                style: fontRoboto(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: porticoBlack,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          RangeSlider(
            values: currentRangeValues,
            max: 100000,
            divisions: 5,
            onChanged: (RangeValues values) {
              setState(() {
                currentRangeValues = values;
              });
            },
          ),
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            height: 5.h,
          ),
          InkWell(
              onTap: () {
                ref.read(jobDetailsControllerProvider.notifier).getJobPosted(
                    value: "",
                    category: (selectedCategory != null)
                        ? "&job_category=$selectedCategory"
                        : "",
                    location: (locationController.text.isNotEmpty)
                        ? "&location=${locationController.text}"
                        : "",
                    salaryRange:
                        "&from=${currentRangeValues.start.round().toString()}&to=${currentRangeValues.end.round().toString()}");
                Navigator.pop(context);
              },
              child: const PotricoButton(buttonText: "Filter")),
        ],
      ),
    );
  }
}
