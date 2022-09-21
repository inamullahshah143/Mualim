import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/main.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../controllers/registration_controller.dart';
import '../home/drawer/menu_drawer.dart';

final registrationController = Get.put(RegistrationController());

class OTPScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const OTPScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int secondsRemaining = 30;
  bool enableResend = false;
  Timer? timer;

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  void _resendCode() {
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer!.cancel();
    super.dispose();
  }

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
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Verify your phone number',
                  style: TextStyle(
                    fontSize: 24,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.fonts,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Please enter your OTP code to verify.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.fonts,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Enter OTP code',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.fonts,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: OTPTextField(
                  length: 5,
                  width: MediaQuery.of(context).size.width * 0.8,
                  fieldWidth: 48,
                  outlineBorderRadius: 5,
                  style: const TextStyle(fontSize: 16),
                  textFieldAlignment: MainAxisAlignment.spaceEvenly,
                  fieldStyle: FieldStyle.box,
                  onCompleted: (pin) {},
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: MaterialButton(
                  onPressed: enableResend ? _resendCode : () {},
                  child: Text(
                    '${secondsRemaining}s to resend',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.fonts,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Enter OTP that we sent to your mobile number',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.fonts,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.data['phone'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.fonts,
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: MaterialButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            'Change',
                            style: TextStyle(
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              color: AppTheme.fonts,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 20,
        ),
        child: ElevatedButton(
          onPressed: () async {
            await registrationController
                .registrationProcess(widget.data, context)
                .then(
              (response) {
                if (response!.status == 201) {
                  prefs!.setString('username', response.data.name);
                  prefs!.setString('email', response.data.email);
                  prefs!.setString('phone', response.data.phone);
                  prefs!.setString('token', response.token);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("User Register Successfully"),
                    ),
                  );
                  Get.offAll(const MenuDrawer());
                }
              },
            );
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AppTheme.white),
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
    );
  }
}
