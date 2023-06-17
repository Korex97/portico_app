import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';

class DetailsLoading extends StatelessWidget {
  const DetailsLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/dot-loader.gif",
      color: porticoBlueBg,
      width: 5.w,
      height: 2.h,
    );
  }
}