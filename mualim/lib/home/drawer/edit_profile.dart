import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/controllers/user_profile_controller.dart';
import 'package:mualim/helper/helper.dart';
import 'package:mualim/main.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final userProfileController = Get.put(UserProfileController());
  final formKey = GlobalKey<FormState>();
  final TextEditingController username =
      TextEditingController(text: prefs!.getString('username'));

  final TextEditingController email =
      TextEditingController(text: prefs!.getString('email'));

  final TextEditingController phoneNo =
      TextEditingController(text: prefs!.getString('phone'));

  File? profilePicture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          'Edit Profile',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: prefs!.getString('picture') != null
                        ? Image.network(
                            prefs!.getString('picture').toString(),
                            fit: BoxFit.fill,
                          ).image
                        : Image.network(
                            'https://1.bp.blogspot.com/-ytMsk6NJCIc/YRDL86N7-CI/AAAAAAAAM_Q/3VFXo2IqsmMxqKbZYlERxjcLX7uA1L67QCLcBGAsYHQ/s500/unique-boys-whatsapp-dp-images-boys-dpz-dp-for-boys-profile-pictures-for-Boys%2B%25281%2529.jpg',
                            fit: BoxFit.fill,
                          ).image,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          FontAwesome5.edit,
                          color: AppTheme.appThemeColor,
                          size: 16,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Edit Profile",
                          style: TextStyle(color: AppTheme.appThemeColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Hi there ${prefs!.getString('username')}!",
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 20,
                    ),
                    child: TextFormField(
                      controller: username,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your full name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: AppTheme.secondary.withOpacity(0.075),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Teacher Name',
                        hintStyle: TextStyle(
                          color: AppTheme.fonts.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 20,
                    ),
                    child: TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 20,
                    ),
                    child: TextFormField(
                      controller: phoneNo,
                      enabled: false,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your full name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: AppTheme.secondary.withOpacity(0.075),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Phone No',
                        hintStyle: TextStyle(
                          color: AppTheme.fonts.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 20,
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          processLoading(context);
                          userProfileController.updateProfile(context, {
                            'name': username.text,
                            'email': email.text,
                          }).then((value) {
                            if (value == 'success') {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profile Updated Successfully'),
                                ),
                              );
                            }
                          });
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
                        child: const Text("Save"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomFormImput extends StatelessWidget {
  const CustomFormImput({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.only(left: 40),
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: AppTheme.secondary.withOpacity(0.25),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          contentPadding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
        ),
        initialValue: value,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
