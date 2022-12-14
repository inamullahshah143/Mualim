import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:mualim/auth/onboard_screen.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/controllers/login_controller.dart';
import 'package:mualim/home/drawer/about_us.dart';
import 'package:mualim/home/drawer/edit_profile.dart';
import 'package:mualim/home/drawer/privacy_policy.dart';
import 'package:mualim/main.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Scaffold(
      backgroundColor: AppTheme.placeholder,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  backgroundImage: prefs!.getString('picture') != null
                      ? Image.file(
                          File(prefs!.getString('picture').toString()),
                          fit: BoxFit.fill,
                        ).image
                      : Image.network(
                          'https://1.bp.blogspot.com/-ytMsk6NJCIc/YRDL86N7-CI/AAAAAAAAM_Q/3VFXo2IqsmMxqKbZYlERxjcLX7uA1L67QCLcBGAsYHQ/s500/unique-boys-whatsapp-dp-images-boys-dpz-dp-for-boys-profile-pictures-for-Boys%2B%25281%2529.jpg',
                          fit: BoxFit.fill,
                        ).image,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Text(
                    prefs!.getString('username').toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppTheme.fonts,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    prefs!.getString('email').toString(),
                    style: const TextStyle(
                      color: AppTheme.fonts,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: () {
                  ZoomDrawer.of(context)!.close();
                  Get.to(const ProfileEdit());
                },
                leading: const Icon(
                  Icons.person_outlined,
                  color: AppTheme.fonts,
                  size: 20,
                ),
                title: const Text('Edit Profile'),
              ),
              ListTile(
                onTap: () {
                  ZoomDrawer.of(context)!.close();
                },
                leading: const Icon(
                  Icons.share,
                  color: AppTheme.fonts,
                  size: 20,
                ),
                title: const Text('Share'),
              ),
              ListTile(
                onTap: () {
                  ZoomDrawer.of(context)!.close();
                  Get.to(const PrivacyPolicy());
                },
                leading: const Icon(
                  Icons.policy_outlined,
                  color: AppTheme.fonts,
                  size: 20,
                ),
                title: const Text('Privacy Policy'),
              ),
              ListTile(
                onTap: () {
                  ZoomDrawer.of(context)!.close();
                  Get.to(const AboutUs());
                },
                leading: const Icon(
                  Icons.info_outline,
                  color: AppTheme.fonts,
                  size: 20,
                ),
                title: const Text('About Us'),
              ),
            
              ListTile(
                onTap: () {
                  processLoading(context);
                  loginController.logoutProcess(context).whenComplete(() {
                    prefs!.clear();
                    ZoomDrawer.of(context)!.close();
                    Get.offAll(const OnboardScreen());
                  });
                },
                leading: const Icon(
                  Icons.logout_outlined,
                  color: AppTheme.red,
                  size: 20,
                ),
                title: const Text('Logout'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
