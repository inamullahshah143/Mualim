import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/home/drawer/change_password.dart';
import 'package:mualim/home/drawer/edit_profile.dart';
import 'package:mualim/main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.appThemeColor,
                  AppTheme.primary,
                ],
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 350.0,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                     CircleAvatar(
                      backgroundImage: prefs!.getString('picture') != null
                          ? Image.file(
                              File(prefs!.getString('picture').toString()),
                              fit: BoxFit.fill,
                            ).image
                          : Image.network(
                              'https://1.bp.blogspot.com/-ytMsk6NJCIc/YRDL86N7-CI/AAAAAAAAM_Q/3VFXo2IqsmMxqKbZYlERxjcLX7uA1L67QCLcBGAsYHQ/s500/unique-boys-whatsapp-dp-images-boys-dpz-dp-for-boys-profile-pictures-for-Boys%2B%25281%2529.jpg',
                              fit: BoxFit.fill,
                            ).image,
                      radius: 50.0,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      prefs!.getString('username').toString(),
                      style: const TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      prefs!.getString('email').toString(),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5.0),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 22.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: const <Widget>[
                                  Text(
                                    "Enrolled In",
                                    style: TextStyle(
                                      color: AppTheme.primary,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "1",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: AppTheme.fonts,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: const <Widget>[
                                  Text(
                                    "Completed",
                                    style: TextStyle(
                                      color: AppTheme.primary,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "0",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: AppTheme.fonts,
                                    ),
                                  )
                                ],
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
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 5.0),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    onTap: () {
                      Get.to(const ProfileEdit());
                    },
                    leading: const Icon(FontAwesome5.user_edit),
                    title: const Text('Edit Profile'),
                    subtitle: const Text(
                        'You can update your profile details for public'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 5.0),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    onTap: () {
                      Get.to(ChangePassword());
                    },
                    leading: const Icon(FontAwesome5.user_lock),
                    title: const Text('Change Password'),
                    subtitle:
                        const Text('You can change your account password'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
