import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nist_tes/core/notifiers/profile_notifier.dart';
import 'package:nist_tes/core/notifiers/routine_notifier.dart';
import 'package:nist_tes/core/notifiers/subject_notifier.dart';
import 'package:nist_tes/core/notifiers/teacher_notifier.dart';
import 'package:nist_tes/presentation/screens/class_routine_screen/class_routine_screen.dart';
import 'package:nist_tes/presentation/screens/dashboard_screen/dashboard_screen.dart';
import 'package:nist_tes/presentation/screens/event_screen/event_screen.dart';
import 'package:nist_tes/presentation/screens/profile_screen/profile_screen.dart';
import 'package:nist_tes/presentation/screens/teachers_screen/teachers_screen.dart';
import 'package:nist_tes/presentation/widgets/appbar/home_appbar.dart';
import 'package:provider/provider.dart';

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
    final theme = Theme.of(context);
    return Scaffold(
        appBar: const HomeAppBar(),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
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
            color: Colors.transparent,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.surface,
                theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withOpacity(0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: BottomBarInspiredFancy(
            indexSelected: _indexSelected,
            onTap: (index) => _onPageChange(index),
            backgroundColor: Colors.transparent,
            color: theme.colorScheme.onSurfaceVariant,
            colorSelected: theme.colorScheme.primary,
            items: [
              const TabItem(
                icon: Octicons.home,
                title: 'Home',
              ),
              const TabItem(
                icon: SimpleLineIcons.graduation,
                title: 'Teachers',
              ),
              const TabItem(
                icon: Feather.book,
                title: 'Routine',
              ),
              const TabItem(
                icon: AntDesign.calendar,
                title: 'Events',
              ),
              const TabItem(
                icon: FontAwesome5Regular.user_circle,
                title: 'Profile',
              ),
            ]
                .map((item) => TabItem(
                      icon: item.icon,
                      title: item.title,
                    ))
                .toList(),
            titleStyle: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
            iconSize: 20,
          ),
        ));
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProfileNotifier>().getMyProfile();
      context.read<TeacherNotifier>().getTeachers();
      context.read<SubjectNotifier>().getSubjects();
      context.read<RoutineNotifier>().getRoutines();
    });
    super.initState();
  }

  void _onPageChange(int index) {
    setState(() {
      _indexSelected = index;
      _pageController.jumpToPage(index);
    });
  }
}
