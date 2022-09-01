import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/home/home_sab/all_courses.dart';
import 'package:mualim/home/home_sab/saved_courses.dart';
import 'package:mualim/home/home_sab/stuyding_courses.dart';
import 'package:mualim/home/search_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TabController? tabController;
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: AppTheme.transparent,
        foregroundColor: AppTheme.fonts,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(LineIcons.bell)),
        ],
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
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Welcome\n',
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.25,
                        fontFamily: "Metropolis",
                        color: AppTheme.fonts,
                      ),
                    ),
                    TextSpan(
                      text: 'Inamullah!',
                      style: TextStyle(
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
                  Tab(text: 'STUDYING'),
                  Tab(text: 'SAVED'),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  AllCourses(),
                  StuydingCourses(),
                  SavedCourses(),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GNav(
          tabActiveBorder: const Border(
            bottom: BorderSide(
              color: AppTheme.appThemeColor,
            ),
            top: BorderSide(
              color: AppTheme.appThemeColor,
            ),
            left: BorderSide(
              color: AppTheme.appThemeColor,
            ),
            right: BorderSide(
              color: AppTheme.appThemeColor,
            ),
          ),
          tabBorderRadius: 15,
          gap: 8,
          activeColor: AppTheme.appThemeColor,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          color: Colors.black,
          tabs: const [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.heart,
              text: 'Likes',
            ),
            GButton(
              icon: LineIcons.search,
              text: 'Search',
            ),
            GButton(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://1.bp.blogspot.com/-ytMsk6NJCIc/YRDL86N7-CI/AAAAAAAAM_Q/3VFXo2IqsmMxqKbZYlERxjcLX7uA1L67QCLcBGAsYHQ/s500/unique-boys-whatsapp-dp-images-boys-dpz-dp-for-boys-profile-pictures-for-Boys%2B%25281%2529.jpg'),
                radius: 18,
              ),
              icon: LineIcons.user,
              text: 'Profile',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),),
    );
  }
}
