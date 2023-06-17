import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:potrico/screens/widgets/filter_modal.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/colors.dart';
import '../models/job_category.dart';

goToPage(BuildContext context, Widget route) async {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (BuildContext context) => route));
}

void showSuccessToast(BuildContext context, String message) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.success(
      backgroundColor: successToastBg,
      icon: Image.asset("assets/images/success.gif"),
      message: message,
    ),
  );
}

void showErrorToast(BuildContext context, String message) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.error(
      backgroundColor: danger,
      textStyle: const TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
      icon: Image.asset(
        "assets/images/cancel.gif",
        color: dangerBg,
      ),
      message: message,
    ),
  );
}

Future showFilterModal(BuildContext context, List<Categories> allCategories) {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      // shape: const ShapeBorder().add(),
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        //
        return FilterModal(
          allCategories: allCategories,
        );
      });
}

Future<File?> getImage() async {
  final ImagePicker picker = ImagePicker();
  // Pick an image
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image == null) {
    return null;
  } else {
    //TO convert Xfile into file
    File file = File(image.path);
    log("Image picked");
    return file;
  }
}

Future<File?> getResumeFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['doc', 'docx', 'pdf', 'ppt', 'pptx'],
  );

  if (result == null) {
    return null;
  } else {
    File resume = File(result.files.single.path!);

    return resume;
  }
}

String getFilename(File file) {
  String filename = basename(file.path);
  return filename;
}

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

Future<void> sendMessage(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'sms',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}
