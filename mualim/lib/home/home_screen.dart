import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/home/home_sab/all_courses.dart';
import 'package:mualim/home/home_sab/saved_courses.dart';
import 'package:mualim/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TabController? tabController;
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
            if (ZoomDrawer.of(context)!.isOpen()) {
              ZoomDrawer.of(context)!.close();
            } else {
              ZoomDrawer.of(context)!.open();
            }
          },
          icon: const ImageIcon(
            AssetImage('assets/icons/menu.png'),
            size: 24,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Welcome\n',
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.25,
                        fontFamily: "Metropolis",
                        color: AppTheme.fonts,
                      ),
                    ),
                    TextSpan(
                      text: prefs!.getString('username').toString(),
                      style: const TextStyle(
                        fontSize: 24,
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
            Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: TabBar(
                controller: tabController,
                labelColor: AppTheme.white,
                unselectedLabelColor: AppTheme.fonts,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppTheme.appThemeColor,
                ),
                tabs: const [
                  Tab(text: 'ALL'),
                  Tab(text: 'SAVED'),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  AllCourses(),
                  SavedCourses(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
