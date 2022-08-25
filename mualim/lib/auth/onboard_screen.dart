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
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 45),
        ),
        onPressed: () => {Get.offAll(LoginScreen())},
        child: const Text('Get Started'),
      ),
    );
  }
}
