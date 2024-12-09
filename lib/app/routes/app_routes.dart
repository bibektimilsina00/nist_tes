import 'package:go_router/go_router.dart';
import 'package:nist_tes/presentation/screens/academic_info_screen/academic_info_screen.dart';
import 'package:nist_tes/presentation/screens/college_wall_screen/college_wall_screen.dart';
import 'package:nist_tes/presentation/screens/notice_screen/notice_screen.dart';
import 'package:nist_tes/presentation/screens/notification_screen/notification_screen.dart';
import 'package:nist_tes/presentation/screens/personal_info_screen/user_personal_info_screen.dart';
import 'package:nist_tes/presentation/screens/profile_screen/account_setting_screen.dart';
import 'package:nist_tes/presentation/screens/profile_screen/change_password_screen.dart';
import 'package:nist_tes/presentation/screens/profile_screen/faq_screen.dart';
import 'package:provider/provider.dart';

import '../../core/notifiers/auth/auth_notifier.dart';
import '../../presentation/screens/assignment_screen/assignment_screen.dart';
import '../../presentation/screens/edit_profile_screen/edit_profile_screen.dart';
import '../../presentation/screens/evaluation_form_screen/evaluation_form_screen.dart';
import '../../presentation/screens/home_screen/home_screen.dart';
import '../../presentation/screens/login_screen/login_screen.dart';
import '../../presentation/screens/on_boarding_screen/on_boarding_screen.dart';

final router = GoRouter(
  initialLocation: AppRoutes.collegeWallScreen,
  routes: [
    GoRoute(
      path: AppRoutes.onBoardScreen,
      builder: (context, state) => const OnBoardScreen(),
      redirect: (context, state) async {
        final authNotifier = context.read<AuthenticationNotifier>();
        if (await authNotifier.isFirstTimeUse()) {
          return null;
        }
        if (authNotifier.isLoggedIn) {
          return AppRoutes.homeScreen;
        }
        return AppRoutes.collegeWallScreen;
      },
    ),
    GoRoute(
      path: AppRoutes.loginScreen,
      builder: (context, state) => const LoginScreen(),
      redirect: (context, state) async {
        final authNotifier = context.read<AuthenticationNotifier>();
        if (authNotifier.isLoggedIn) {
          return AppRoutes.homeScreen;
        }
        return null;
      },
    ),
    GoRoute(
      path: AppRoutes.homeScreen,
      builder: (context, state) => const HomeScreen(),
      redirect: (context, state) async {
        final authNotifier = context.read<AuthenticationNotifier>();
        if (!authNotifier.isLoggedIn) {
          return AppRoutes.collegeWallScreen;
        }
        return null;
      },
    ),
    GoRoute(
      path: AppRoutes.userPersonalInfoScreen,
      builder: (context, state) => const UserPersonalInfoScreen(),
    ),
    GoRoute(
      path: AppRoutes.academicInfoScreen,
      builder: (context, state) => const AcademicInfoScreen(),
    ),
    GoRoute(
      path: AppRoutes.changePasswordScreen,
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.accountSettingScreen,
      builder: (context, state) => const AccountSettingScreen(),
    ),
    GoRoute(
      path: AppRoutes.faqScreen,
      builder: (context, state) => const FaqScreen(),
    ),
    GoRoute(
      path: AppRoutes.editProfileScreen,
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.notificationScreen,
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: AppRoutes.evaluationFormScreen,
      builder: (context, state) => const EvaluationFormScreen(),
    ),
    GoRoute(
        path: AppRoutes.noticeScreen,
        builder: (context, state) => const NoticeAndUpdatesScreen()),
    GoRoute(
      path: AppRoutes.collegeWallScreen,
      builder: (context, state) => const CollegeWallScreen(),
      redirect: (context, state) async {
        final authNotifier = context.read<AuthenticationNotifier>();
        if (authNotifier.isLoggedIn) {
          return AppRoutes.homeScreen;
        }
        return null;
      },
    ),
    GoRoute(
      path: AppRoutes.assignmentScreen,
      builder: (context, state) => const AssignmentScreen(),
    ),
  ],
);

abstract class AppRoutes {
  static const onBoardScreen = '/';
  static const loginScreen = '/login';
  static const homeScreen = '/home';

  static const userPersonalInfoScreen = '/userPersonalInfo';
  static const academicInfoScreen = '/academicInfoScreen';
  static const changePasswordScreen = '/changePasswordScreen';
  static const accountSettingScreen = '/accountSettingScreen';
  static const faqScreen = '/faqScreen';
  static const editProfileScreen = '/editProfileScreen';
  static const notificationScreen = '/notificationScreen';
  static const evaluationFormScreen = '/evaluationFormScreen';
  static const noticeScreen = '/noticeScreen';
  static const collegeWallScreen = '/collegeWallScreen';
  static const assignmentScreen = '/assignmentScreen';
}
