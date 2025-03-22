import 'package:flutter/material.dart';
import 'package:lungv_app/Themes/colors.dart';
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Image.asset('assets/images/logo_small.png'),
        // centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.chevron_left, size: 28,)),
        backgroundColor: AppColor.primaryWhite,
      ),
      backgroundColor: AppColor.primaryWhite,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: AppColor.blackWithOpacity70,
        backgroundColor: AppColor.primaryWhite,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 12), // Adjust label size for selected tab
        unselectedLabelStyle: TextStyle(fontSize: 10),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Diagnose",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: "Use CT", ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
