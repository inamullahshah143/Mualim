import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mualim/auth/login_screen.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/helper/helper.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final isVisible = true.obs;

  final String initialCountry = 'PK';
  final PhoneNumber number = PhoneNumber(isoCode: 'PK', dialCode: '0');
  final isValidNo = true.obs;
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: AppTheme.transparent,
        foregroundColor: AppTheme.fonts,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Welcome to Mualim!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Setup your account',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppTheme.fonts.withOpacity(0.75),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 20,
                      ),
                      child: TextFormField(
                        controller: fullName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your full name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: AppTheme.secondary.withOpacity(0.075),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Username',
                          hintStyle: TextStyle(
                            color: AppTheme.fonts.withOpacity(0.5),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 20,
                      ),
                      child: TextFormField(
                        controller: email,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => Helper.validateEmail(value),
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: AppTheme.secondary.withOpacity(0.075),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Email Address',
                          hintStyle: TextStyle(
                            color: AppTheme.fonts.withOpacity(0.5),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 20,
                      ),
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {},
                        onInputValidated: (bool value) {
                          isValidNo.value = value;
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.DIALOG,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your phone number';
                          } else if (isValidNo.value == false) {
                            return 'please enter valid phone number';
                          } else {
                            return null;
                          }
                        },
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        initialValue: number,
                        textFieldController: phoneNo,
                        formatInput: false,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        inputDecoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: AppTheme.secondary.withOpacity(0.075),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(
                            color: AppTheme.fonts.withOpacity(0.5),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 20,
                          ),
                          child: TextFormField(
                            controller: password,
                            validator: (value) =>
                                Helper.validatePassword(value),
                            obscureText: isVisible.value,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              isDense: true,
                              errorMaxLines: 6,
                              filled: true,
                              fillColor: AppTheme.secondary.withOpacity(0.075),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: AppTheme.fonts.withOpacity(0.5),
                                fontSize: 14,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  isVisible.value = !isVisible.value;
                                },
                                icon: isVisible.value
                                    ? const Icon(
                                        Icons.visibility_off,
                                        color: AppTheme.fonts,
                                        size: 15,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        color: AppTheme.fonts,
                                        size: 15,
                                      ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Obx(
                      () {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 20,
                          ),
                          child: TextFormField(
                            controller: confirmPassword,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your confirm password';
                              } else if (value != password.text) {
                                return 'password doesn\'t match';
                              }
                              return null;
                            },
                            obscureText: isVisible.value,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: AppTheme.secondary.withOpacity(0.075),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(
                                color: AppTheme.fonts.withOpacity(0.5),
                                fontSize: 14,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  isVisible.value = !isVisible.value;
                                },
                                icon: isVisible.value
                                    ? const Icon(
                                        Icons.visibility_off,
                                        color: AppTheme.fonts,
                                        size: 15,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        color: AppTheme.fonts,
                                        size: 15,
                                      ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(AppTheme.white),
                    overlayColor: MaterialStateProperty.all<Color>(
                      AppTheme.white.withOpacity(0.1),
                    ),
                    minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width, 45),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text('Sign Up'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 20,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Already have an account? Please',
                    style: TextStyle(
                      color: AppTheme.fonts.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: MaterialButton(
                  onPressed: () {
                    Get.offAll(LoginScreen());
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: AppTheme.fonts,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Text(
                            'By signing of creating account, you agree with our ',
                            style: TextStyle(
                              color: AppTheme.fonts,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: InkWell(
                            onTap: () {},
                            child: const Text(
                              'Terms of Service',
                              style: TextStyle(
                                color: AppTheme.red,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Text(
                            ' & ',
                            style: TextStyle(
                              color: AppTheme.fonts,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: InkWell(
                            onTap: () {},
                            child: const Text(
                              'Privacy Policy',
                              style: TextStyle(
                                color: AppTheme.red,
                                fontSize: 16,
                              ),
                            ),
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
      ),
    );
  }
}
