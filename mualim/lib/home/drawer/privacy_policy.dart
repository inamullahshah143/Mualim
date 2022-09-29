import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/app_theme.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.fonts,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'This policy sets out the basis on which any personal data we collect from you, or that you provide to us, through this Application or as otherwise agreed between you and us, or indicated to you by us, will be processed by us. Please read the following carefully to understand our views and practices regarding your personal data and how we will treat it.\n\nWe are responsible for operation of the site at www.alightpakistan.org Our contact information is:+92 51 2820437-40 info@alightpakistan.org and 85-East, Kamran Centre, 4th Floor, Blue Area, Islamabad',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.25,
                  color: AppTheme.fonts,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
