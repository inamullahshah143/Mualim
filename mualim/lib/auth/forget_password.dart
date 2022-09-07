import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/helper/helper.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 20,
              ),
              child: ElevatedButton(
                onPressed: () {},
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
