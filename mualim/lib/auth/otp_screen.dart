import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/auth/password_confirmation.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/controllers/login_controller.dart';
import 'package:mualim/main.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../controllers/registration_controller.dart';
import '../home/drawer/menu_drawer.dart';

final registrationController = Get.put(RegistrationController());
final loginController = Get.put(LoginController());

class OTPScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  final bool isForget;
  const OTPScreen({Key? key, required this.data, required this.isForget})
      : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;
  String? _verificationCode;
  final OtpFieldController _pinPutController = OtpFieldController();

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _verifyPhone();
    });

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
    super.initState();
  }

  void _resendCode() {
    _verifyPhone();
    setState(() {
      secondsRemaining = 60;
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
                  controller: _pinPutController,
                  length: 6,
                  width: MediaQuery.of(context).size.width * 0.8,
                  fieldWidth: 48,
                  outlineBorderRadius: 5,
                  otpFieldStyle: OtpFieldStyle(
                    focusBorderColor: AppTheme.primary,
                  ),
                  style: const TextStyle(fontSize: 16),
                  textFieldAlignment: MainAxisAlignment.spaceEvenly,
                  fieldStyle: FieldStyle.box,
                  onCompleted: (pin) async {
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                              verificationId: _verificationCode!, smsCode: pin))
                          .then((value) async {
                        if (value.user != null) {
                          if (widget.isForget) {
                            Get.to(PasswordConfirmation(
                                phoneNo: widget.data['phone']));
                          } else {
                            await registrationController
                                .registrationProcess(widget.data, context)
                                .then(
                              (response) {
                                if (response!.status == 201) {
                                  prefs!.setBool('isLogin', true);
                                  prefs!.setString(
                                      'username', response.data.name);
                                  prefs!
                                      .setString('email', response.data.email);
                                  prefs!
                                      .setString('phone', response.data.phone);
                                  prefs!.setString('token', response.token);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("User Register Successfully"),
                                    ),
                                  );
                                  Get.offAll(const MenuDrawer());
                                }
                              },
                            );
                          }
                        }
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
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
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.data['phone'],
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              if (widget.isForget) {
                Get.offAll(PasswordConfirmation(
                  phoneNo: widget.data['phone'],
                ));
              } else {
                await registrationController
                    .registrationProcess(widget.data, context)
                    .then(
                  (response) {
                    if (response!.status == 201) {
                      prefs!.setBool('isLogin', true);
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
              }
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message.toString()),
            ),
          );
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 120));
  }
}
