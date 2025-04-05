import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lungv_app/Themes/colors.dart';
import 'package:lungv_app/Themes/text_styles.dart';
import 'package:lungv_app/common/date_scroller.dart';
import 'package:lungv_app/modules/Diagnose/diagnose_screen.dart';
import 'package:lungv_app/modules/DiagnoseCT/diagnose_ct.dart';
import 'package:lungv_app/modules/Home/home_screen.dart';
import 'package:lungv_app/modules/Profile/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    DiagnoseScreen(),
    DiagnoseCt(),
    ProfileScreen(),
  ];

  final List<Widget> _appBarWidgets = [
    Text("Home", style: AppTextStyles.navType1),
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
      child: DateScroller(),
    ),
    Text("Diagnose By CT", style: AppTextStyles.navType1),
    Text("Profile", style: AppTextStyles.navType1),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _goBackToPreviousIndex() {
    if (_selectedIndex > 0) {
      setState(() {
        _selectedIndex = 0;
      });
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryWhite,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: _appBarWidgets[_selectedIndex], // Dynamic title
              // centerTitle: true,
              backgroundColor:
                  innerBoxIsScrolled
                      ? AppColor.primaryWhite
                      : AppColor.primaryGray,
              elevation: innerBoxIsScrolled ? 1 : 1,
              scrolledUnderElevation: 0,
              toolbarHeight: 60,
              floating: false,
              pinned: true,
              leading:
                  _selectedIndex == 1
                      ? null
                      : IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 24,
                          color:
                              innerBoxIsScrolled
                                  ? AppColor.primaryBlack
                                  : AppColor.primaryBlack,
                        ),
                        onPressed: () {
                          _goBackToPreviousIndex();
                        },
                      ),
            ),
          ];
        },
        body: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: AppColor.blackWithOpacity70,
        backgroundColor: AppColor.primaryWhite,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 10),
        elevation: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Diagnose",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: "Use CT"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
