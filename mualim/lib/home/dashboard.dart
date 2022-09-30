import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/home/home_screen.dart';
import 'package:mualim/home/profile_screen.dart';
import 'package:mualim/home/search_screen.dart';
import 'package:mualim/main.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int? _selectedIndex;
  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0
          ? const HomeScreen()
          : _selectedIndex == 1
              ? const SearchScreen()
              : _selectedIndex == 2
                  ? const ProfileScreen()
                  : Container(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GNav(
          tabActiveBorder: const Border(
            bottom: BorderSide(
              color: AppTheme.primary,
            ),
            top: BorderSide(
              color: AppTheme.primary,
            ),
            left: BorderSide(
              color: AppTheme.primary,
            ),
            right: BorderSide(
              color: AppTheme.primary,
            ),
          ),
          tabBorderRadius: 15,
          gap: 8,
          activeColor: AppTheme.primary,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          color: Colors.black,
          tabs: [
            const GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            const GButton(
              icon: LineIcons.search,
              text: 'Search',
            ),
            GButton(
              leading: CircleAvatar(
                radius: 18,
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
              icon: LineIcons.user,
              text: 'Profile',
            ),
          ],
          selectedIndex: _selectedIndex!,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
