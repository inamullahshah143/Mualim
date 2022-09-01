import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:mualim/constants/app_theme.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              children: const [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      'https://1.bp.blogspot.com/-ytMsk6NJCIc/YRDL86N7-CI/AAAAAAAAM_Q/3VFXo2IqsmMxqKbZYlERxjcLX7uA1L67QCLcBGAsYHQ/s500/unique-boys-whatsapp-dp-images-boys-dpz-dp-for-boys-profile-pictures-for-Boys%2B%25281%2529.jpg'),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.fonts,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'example@email.com',
                    style: TextStyle(
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
                  FontAwesome.chat_empty,
                  color: AppTheme.fonts,
                  size: 20,
                ),
                title: const Text('Messages'),
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
                  ZoomDrawer.of(context)!.close();
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
