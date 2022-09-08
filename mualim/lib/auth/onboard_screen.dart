import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/auth/login_screen.dart';
import 'package:mualim/constants/app_theme.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Better than a thousand days of diligent study is one day with a',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.25,
                      fontFamily: "Metropolis",
                      color: AppTheme.fonts,
                    ),
                  ),
                  TextSpan(
                    text: '\nMualim',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: "Metropolis",
                      height: 1.25,
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Image.asset('assets/images/get_started.png'),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 20,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            foregroundColor: MaterialStateProperty.all<Color>(AppTheme.primary),
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
          onPressed: () {
            Get.offAll(() => LoginScreen());
          },
          child: const Text('Get Started'),
        ),
      ),
    );
  }
}
