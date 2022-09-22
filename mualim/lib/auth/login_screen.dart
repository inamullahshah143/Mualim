import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mualim/auth/registration_screen.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/helper/helper.dart';
import 'package:mualim/home/drawer/menu_drawer.dart';
import 'package:mualim/main.dart';

import 'forget_password.dart';
import 'otp_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final isVisible = true.obs;
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController password = TextEditingController();
  final String initialCountry = 'PK';
  final PhoneNumber number = PhoneNumber(isoCode: 'PK', dialCode: '+92');
  final isValidNo = true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                    'Proceed with your Login',
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
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {},
                          onInputValidated: (bool value) {
                            isValidNo.value = value;
                          },
                          selectorConfig: const SelectorConfig(
                            trailingSpace: false,
                            setSelectorButtonAsPrefixIcon: true,
                            showFlags: false,
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
                          selectorTextStyle:
                              const TextStyle(color: Colors.black),
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
                                fillColor:
                                    AppTheme.secondary.withOpacity(0.075),
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Get.to(ForgetPassword());
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppTheme.fonts,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        Map<String, dynamic> data = {
                          "phone": '0${phoneNo.text}',
                          "password": password.text,
                        };
                        await loginController.loginProcess(data, context).then(
                          (response) {
                            if (response!.success == 'successfully login') {
                              prefs!.setString('username', response.user.name);
                              prefs!.setString('email', response.user.email);
                              prefs!.setString('phone', response.user.phone);
                              prefs!.setString('token', response.token);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("User Login Successfully"),
                                ),
                              );
                              Get.offAll(const MenuDrawer());
                            }
                          },
                        );
                      }
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
                    child: const Text('Sign In'),
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
                      'I don\'t have an account? Please',
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
                      Get.to(const SignupScreen());
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: AppTheme.fonts,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                      'OR',
                      style: TextStyle(
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
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offAll(() => const MenuDrawer());
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(AppTheme.primary),
                      overlayColor: MaterialStateProperty.all<Color>(
                          AppTheme.primary.withOpacity(0.1)),
                      minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width, 45),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(color: AppTheme.primary),
                        ),
                      ),
                    ),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              FontAwesome.google,
                            ),
                          ),
                          TextSpan(text: '  '),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Text('Sign In with Google'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
