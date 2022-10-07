import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mualim/constants/app_theme.dart';

import 'otp_screen.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneNo = TextEditingController();
  final String initialCountry = 'PK';
  final PhoneNumber number = PhoneNumber(isoCode: 'PK', dialCode: '+92');
  final isValidNo = true.obs;
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
                'Reset Your Password',
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
                'Please enter your email to recieve a link to create a new password via email',
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
              child: Padding(
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
                      "phone":
                          number.dialCode.toString() + phoneNo.text.toString(),
                    };
                    Navigator.of(context).pop();
                    Get.to(
                      OTPScreen(data: data, isForget: true),
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
                child: const Text('Send'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
