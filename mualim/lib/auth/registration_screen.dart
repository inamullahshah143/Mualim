import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mualim/auth/otp_screen.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/helper/helper.dart';
import 'package:mualim/model/registration_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final isVisible = true.obs;
  RegistrationModel? registrationModel;
  final String initialCountry = 'PK';
  final gender = ''.obs;
  final PhoneNumber number = PhoneNumber(isoCode: 'PK', dialCode: '+92');
  final isValidNo = true.obs;
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController organization = TextEditingController();
  final TextEditingController designation = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController qualification = TextEditingController();
  final TextEditingController experience = TextEditingController();
  final TextEditingController cnic = TextEditingController();
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
                        keyboardType: TextInputType.name,
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
                          hintText: 'Teacher Name',
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
                        controller: organization,
                        keyboardType: TextInputType.text,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter the organization';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: AppTheme.secondary.withOpacity(0.075),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Organization',
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
                        controller: designation,
                        keyboardType: TextInputType.text,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter the designation';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: AppTheme.secondary.withOpacity(0.075),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Designation',
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
                        keyboardType: TextInputType.text,
                        controller: qualification,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter the qualification';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: AppTheme.secondary.withOpacity(0.075),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Qualification',
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
                        controller: experience,
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter the experience';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: AppTheme.secondary.withOpacity(0.075),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Experience',
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
                        controller: cnic,
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter the cnic';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: AppTheme.secondary.withOpacity(0.075),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'CNIC',
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
                      child: DropdownButtonFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'please select the gender';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          isCollapsed: true,
                          fillColor: AppTheme.secondary.withOpacity(0.075),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(12.5),
                          hintText: 'Gender',
                          hintStyle: TextStyle(
                            color: AppTheme.fonts.withOpacity(0.5),
                            fontSize: 14,
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'male',
                            child: Text('Male'),
                          ),
                          DropdownMenuItem(
                            value: 'female',
                            child: Text('Female'),
                          ),
                          DropdownMenuItem(
                            value: 'other',
                            child: Text('Other'),
                          ),
                        ],
                        onChanged: (String? value) {
                          gender.value = value!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 20,
                      ),
                      child: TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
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
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      Map<String, dynamic> data = {
                        "name": fullName.text,
                        "email": email.text,
                        "password": confirmPassword.text,
                        "gender": gender.value,
                        "organization": organization.text,
                        "designation": designation.text,
                        "qualification": qualification.text,
                        "experience": experience.text,
                        "cnic": cnic.text,
                        "phone": number.dialCode.toString() +
                            phoneNo.text.toString(),
                      };
                      Get.to(OTPScreen(
                        data: data,
                        isLogin: false,
                      ));
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
                  child: const Text('Next'),
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
                  onPressed: () async {},
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
