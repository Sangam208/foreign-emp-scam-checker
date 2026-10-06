import 'package:flutter/material.dart';
import 'package:foreign_emp_scam_checker/alert_page.dart';
import 'package:foreign_emp_scam_checker/features/checker/presentation/pages/agency_page.dart';
import 'package:foreign_emp_scam_checker/features/checker/presentation/pages/home_page.dart';
import 'package:foreign_emp_scam_checker/features/job/presentation/screens/job_screen.dart';
import 'package:foreign_emp_scam_checker/features/checker/presentation/widgets/navbar/custom_bottom_nav_bar.dart';
import 'package:foreign_emp_scam_checker/profile_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final PageController _pageController = PageController();

  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.jumpToPage(selectedIndex);
  }

  List<Widget> pages = [
    HomePage(),
    JobPage(),
    AgencyPage(),
    AlertPage(),
    ProfilePage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        title: Text('JobGuard', style: Theme.of(context).textTheme.titleMedium),
        leading: Icon(Icons.shield),
        actionsPadding: EdgeInsets.all(15.0),
      ),

      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: onItemTapped,
          children: pages,
        ),
      ),

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          splashColor: Colors.transparent,
        ),
        child: CustomBottomNavBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            onItemTapped(index);
          },
        ),
      ),
    );
  }
}
