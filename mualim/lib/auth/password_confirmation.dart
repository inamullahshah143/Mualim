import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/auth/onboard_screen.dart';
import 'package:mualim/auth/otp_screen.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/controllers/update_password.dart';
import 'package:mualim/helper/helper.dart';

class PasswordConfirmation extends StatefulWidget {
  final String phoneNo;
  const PasswordConfirmation({Key? key, required this.phoneNo})
      : super(key: key);

  @override
  State<PasswordConfirmation> createState() => _PasswordConfirmationState();
}

class _PasswordConfirmationState extends State<PasswordConfirmation> {
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final updatePasswordController = Get.put(UpdatePasswordController());
  final isVisible = true.obs;
  final formKey = GlobalKey<FormState>();
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Password Confirmation',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Please make sure to enter your new password',
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
                  Obx(
                    () {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 20,
                        ),
                        child: TextFormField(
                          controller: password,
                          validator: (value) => Helper.validatePassword(value),
                          obscureText: isVisible.value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  processLoading(context);
                  if (formKey.currentState!.validate()) {
                    Map<String, dynamic> data = {
                      "phone": widget.phoneNo.toString(),
                      "password": confirmPassword.text,
                    };
                    updatePasswordController
                        .updatePassword(data, context)
                        .whenComplete(() {
                      Get.offAll(const OnboardScreen());
                      loginController.logoutProcess(context);
                    });
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
                child: const Text('Send'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
