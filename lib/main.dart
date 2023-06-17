import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import 'screens/splash_screen/splash_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: Sizer(
        builder: ((context, orientation, deviceType) {
          return const Potrico();
        }),
      ),
    ),
  );
}

class Potrico extends StatelessWidget {
  const Potrico({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
