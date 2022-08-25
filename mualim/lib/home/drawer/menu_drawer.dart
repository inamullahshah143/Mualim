import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/home/home_screen.dart';

import 'menu_items.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: zoomDrawerController,
      borderRadius: 25.0,
      showShadow: true,
      mainScreenTapClose: true,
      menuScreenTapClose: true,
      menuBackgroundColor: AppTheme.placeholder,
      shadowLayer2Color: AppTheme.appThemeColor,
      shadowLayer1Color: AppTheme.appThemeColor.withOpacity(0.5),
      drawerShadowsBackgroundColor: AppTheme.fonts,
      angle: 0.0,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      menuScreenWidth: MediaQuery.of(context).size.width * 0.75,
      mainScreen: const HomeScreen(),
      menuScreen: const MenuItems(),
      style: DrawerStyle.defaultStyle,
      moveMenuScreen: true,
    );
  }
}
