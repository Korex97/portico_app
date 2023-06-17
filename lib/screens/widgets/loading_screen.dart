import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50.w,
        height: 10.w,
        child: Image.asset("assets/images/dot-loader.gif",
            fit: BoxFit.fitWidth),
      ),
    );
  }
}