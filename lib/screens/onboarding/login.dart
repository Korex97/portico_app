import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/controllers/details_controller.dart';
import 'package:potrico/functions/validators.dart';
import 'package:potrico/screens/employer/navigationbar/navigation_bar.dart';
import 'package:potrico/screens/job_seeker/navigation/navigation.dart';
import 'package:potrico/screens/onboarding/signup.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/job_category_controller.dart';
import '../../controllers/jobs_details_controller.dart';
import '../../functions/general_functions.dart';
import '../../models/login_model.dart';
import '../../states/login_states.dart';
import '../../storage/storage.dart';
import '../widgets/widgets.dart';

class LoginUser extends ConsumerStatefulWidget {
  const LoginUser({super.key});

  @override
  ConsumerState<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends ConsumerState<LoginUser> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool obscureText = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      stateValidation();
    });
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50.h,
                width: 100.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 0.0),
                    colors: [gradient1, gradient2],
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/images/Layer_1.png",
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Login",
                      style: fontRoboto(
                        textStyle: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    AutoSizeText(
                      "EMAIL",
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
                        controller: emailController,
                        enableSuggestions: false,
                        validator: (value) {
                          if (value != null &&
                              validator.validateEmail(value)) {}
                        },
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
                          hintText: "Kindly enter your email address ",
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
                      "PASSWORD",
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
                        controller: passwordController,
                        obscureText: obscureText,
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
                          hintText: "Enter your password",
                          hintStyle: fontRoboto(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: porticoBlack,
                            ),
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: Icon(
                              (obscureText)
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    // Center(
                    //   child: AutoSizeText(
                    //     "Forgot Password?",
                    //     style: fontRoboto(
                    //       textStyle: const TextStyle(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w500,
                    //         color: porticoGrey,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () => goToPage(
                          context,
                          const SignUp(),
                        ),
                        child: AutoSizeText.rich(
                          TextSpan(
                            style: fontRoboto(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: porticoGrey,
                              ),
                            ),
                            children: [
                              const TextSpan(
                                text: "Don't have an account? ",
                              ),
                              TextSpan(
                                text: "Sign up here",
                                style: fontRoboto(
                                  textStyle:
                                      const TextStyle(color: porticoPink),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              InkWell(
                onTap: () {
                  if (!isLoading) {
                    loginUser();
                  }
                },
                child: PotricoButton(
                  buttonText: 'Login',
                  loading: isLoading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginUser() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showErrorToast(context, "Kindly Enter All Fields");
    } else if (!validator.validateEmail(emailController.text)) {
      showErrorToast(context, "Invalid Email Address");
    } else {
      LoginModel loginData =
          LoginModel(emailController.text, passwordController.text);

      ref.read(loginControllerProvider.notifier).login(loginData);
    }
  }

  void stateValidation() async {
    var myState = ref.watch(loginControllerProvider);
    if (myState is LoginStateLaoding) {
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

      if (myState is LoginStateerror) {
        Future.delayed(Duration.zero, () {
          showErrorToast(context, myState.error);
          ref.read(loginControllerProvider.notifier).resetState();
        });
      }

      if (myState is LoginStateSuccess) {
        if (myState.successData.status!) {
          showSuccessToast(context, myState.successData.text!);

          secureStorage
              .tokenSave(myState.successData.data!.authtoken)
              .then((value) {
            ref.read(userDetailsControllerProvider.notifier).getDetails();
            ref.read(jobDetailsControllerProvider.notifier).getJobPosted();
            ref.read(loginControllerProvider.notifier).resetState();
            if (myState.successData.data!.userType == "1") {
              ref
                  .read(jobCategoryControllerProvider.notifier)
                  .getJobCategories();
              goToPage(context, const JobSeekerNavigation());
            } else {
              goToPage(context, const Navigation());
            }
          });

          // log(myState.successData.data!.userType!);
        } else {
          Future.delayed(Duration.zero, () {
            showErrorToast(
              context,
              myState.successData.text!,
            );
            ref.read(loginControllerProvider.notifier).resetState();
          });
        }
      }
    }
  }
}
