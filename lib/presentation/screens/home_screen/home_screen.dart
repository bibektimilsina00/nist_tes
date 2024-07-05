import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nist_tes/app/const/app_colors.dart';
import 'package:nist_tes/presentation/screens/class_routine_screen/class_routine_screen.dart';
import 'package:nist_tes/presentation/screens/dashboard_screen/dashboard_screen.dart';
import 'package:nist_tes/presentation/screens/event_screen/event_screen.dart';
import 'package:nist_tes/presentation/screens/profile_screen/profile_screen.dart';
import 'package:nist_tes/presentation/screens/teachers_screen/teachers_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indexSelected = 0;

  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          children: const [
            DashboardScreen(),
            TeachersScreen(),
            ClassRoutineScreen(),
            EventScreen(),
            ProfileScreen()
          ],
        ),
        bottomNavigationBar: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
          child: BottomBarInspiredFancy(
            indexSelected: _indexSelected,
            onTap: (index) {
              _onPageChange(index);
            },
            backgroundColor: Colors.white,
            color: Colors.grey,
            colorSelected: AppColors.primaryColor,
            items: const [
              TabItem(
                icon: Octicons.home,
                title: 'Home',
              ),
              TabItem(
                icon: SimpleLineIcons.graduation,
                title: 'Teachers',
              ),
              TabItem(
                icon: Feather.book,
                title: 'Routine',
              ),
              TabItem(
                icon: AntDesign.calendar,
                title: 'Events',
              ),
              TabItem(
                icon: FontAwesome5Regular.user_circle,
                title: 'Profile',
              ),
            ],
          ),
        ));
  }

  void _onPageChange(int index) {
    setState(() {
      _indexSelected = index;
      _pageController.jumpToPage(index);
    });
  }
}
