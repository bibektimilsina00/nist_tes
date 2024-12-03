import 'package:go_router/go_router.dart';
import 'package:nist_tes/presentation/screens/academic_info_screen/academic_info_screen.dart';
import 'package:nist_tes/presentation/screens/notification_screen/notification_screen.dart';
import 'package:nist_tes/presentation/screens/personal_info_screen/user_personal_info_screen.dart';
import 'package:nist_tes/presentation/screens/profile_screen/account_setting_screen.dart';
import 'package:nist_tes/presentation/screens/profile_screen/change_password_screen.dart';
import 'package:nist_tes/presentation/screens/profile_screen/faq_screen.dart';
import 'package:provider/provider.dart';

import '../../core/notifiers/auth_notifier.dart';
import '../../presentation/screens/edit_profile_screen/edit_profile_screen.dart';
import '../../presentation/screens/home_screen/home_screen.dart';
import '../../presentation/screens/login_screen/login_screen.dart';
import '../../presentation/screens/on_boarding_screen/on_boarding_screen.dart';
import '../../presentation/screens/wall/wall_screen.dart';

final router = GoRouter(
  initialLocation: AppRoutes.wallScreen,
  routes: [
    GoRoute(
      path: AppRoutes.onBoardScreen,
      builder: (context, state) => const OnBoardScreen(),
      redirect: (context, state) async {
        final authNotifier = context.read<AuthenticationNotifier>();
        if (await authNotifier.isFirstTimeUse()) {
          return null;
        }
        if (await authNotifier.isUserLoggedIn()) {
          return AppRoutes.homeScreen;
        }
        return AppRoutes.wallScreen;
      },
    ),
    GoRoute(
      path: AppRoutes.loginScreen,
      builder: (context, state) => const LoginScreen(),
      redirect: (context, state) async {
        final authNotifier = context.read<AuthenticationNotifier>();
        if (await authNotifier.isUserLoggedIn()) {
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
        if (!await authNotifier.isUserLoggedIn()) {
          return AppRoutes.wallScreen;
        }
        return null;
      },
    ),
    GoRoute(
      path: AppRoutes.wallScreen,
      builder: (context, state) => const WallScreen(),
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
  ],
);

abstract class AppRoutes {
  static const onBoardScreen = '/';
  static const loginScreen = '/login';
  static const homeScreen = '/home';
  static const wallScreen = '/wall';
  static const userPersonalInfoScreen = '/userPersonalInfo';
  static const academicInfoScreen = '/academicInfoScreen';
  static const changePasswordScreen = '/changePasswordScreen';
  static const accountSettingScreen = '/accountSettingScreen';
  static const faqScreen = '/faqScreen';
  static const editProfileScreen = '/editProfileScreen';
  static const notificationScreen = '/notificationScreen';
}
