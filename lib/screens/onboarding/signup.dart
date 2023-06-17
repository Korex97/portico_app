import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/functions/general_functions.dart';
import 'package:potrico/functions/validators.dart';
import 'package:potrico/screens/job_seeker/navigation/navigation.dart';
import 'package:potrico/screens/onboarding/login.dart';
import 'package:potrico/screens/widgets/widgets.dart';
import 'package:sizer/sizer.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/countries_controller.dart';
import '../../models/signup_model.dart';
import '../../states/login_states.dart';
import '../../storage/storage.dart';
import '../employer/navigationbar/navigation_bar.dart';
import 'personal_details.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool obscureText = true;
  bool confirmPasswordObscure = true;
  bool isLoading = false;

  List accountType = [
    {'name': 'Select Account Type', 'value': ''},
    {'name': 'Employer', 'value': '2'},
    {'name': 'Job Seeker', 'value': '1'}
  ];
  String? selectedAccount;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      signupStateValidation();
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
                height: 40.h,
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
                      "Sign Up",
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
                      "SELECT ACCOUNT TYPE",
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
                              style: BorderStyle.solid,
                            ),
                          ),
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
                        hint: const Text("Select Account Type"),
                        value: selectedAccount,
                        onChanged: (value) {
                          setState(() {
                            if (value != null && value.isNotEmpty) {
                              selectedAccount = value;
                            }
                          });
                        },
                        items: accountType.map((account) {
                          return DropdownMenuItem<String>(
                            value: account['value'],
                            child: Text(account['name']),
                          );
                        }).toList(),
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
                    AutoSizeText(
                      "CONFRIM PASSWORD",
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
                        controller: confirmController,
                        obscureText: confirmPasswordObscure,
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
                          hintText: "Confirm your password",
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
                                confirmPasswordObscure =
                                    !confirmPasswordObscure;
                              });
                            },
                            child: Icon(
                              (confirmPasswordObscure)
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
                    Center(
                      child: InkWell(
                        onTap: () => goToPage(
                          context,
                          const LoginUser(),
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
                                  text: "Already have an account? ",
                                ),
                                TextSpan(
                                  text: "Login",
                                  style: fontRoboto(
                                    textStyle:
                                        const TextStyle(color: porticoPink),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              InkWell(
                onTap: () {
                  if (!isLoading) {
                    registerUser();
                  }
                },
                child: PotricoButton(
                  buttonText: 'Get Started',
                  loading: isLoading,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void registerUser() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmController.text.isEmpty ||
        selectedAccount == null ||
        selectedAccount == "") {
      showErrorToast(context, "Kindly Enter All Fields");
    } else if (passwordController.text != confirmController.text) {
      showErrorToast(context, "Both Password must match");
    } else if (!validator.validateEmail(emailController.text)) {
      showErrorToast(context, "Invalid Email Sent");
    } else {
      SignUpModel signupData = SignUpModel(
        emailController.text,
        passwordController.text,
        selectedAccount!,
        confirmController.text,
      );

      ref.read(loginControllerProvider.notifier).signup(signupData);
    }
  }

  void signupStateValidation() {
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
          secureStorage.tokenSave(myState.successData.data!.authtoken);
          showSuccessToast(context, myState.successData.text!);
          ref.read(countriesControllerProvider.notifier).getAllCountries();
          ref.read(loginControllerProvider.notifier).resetState();

          goToPage(
            context,
            PersonalDetailsUpdate(
              userType: selectedAccount!,
              backRoute: (selectedAccount == "1")
                  ? const JobSeekerNavigation()
                  : const Navigation(),
            ),
          );
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
