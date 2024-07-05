import 'package:go_router/go_router.dart';
import 'package:nist_tes/presentation/screens/on_boarding_screen/on_boarding_screen.dart';

import '../../presentation/screens/home_screen/home_screen.dart';
import '../../presentation/screens/login_screen/login_screen.dart';
import '../../presentation/screens/wall/wall_screen.dart';

final router = GoRouter(
  initialLocation: AppRoutes.onBoardScreen,
  routes: [
    GoRoute(
      path: AppRoutes.onBoardScreen,
      builder: (context, state) => const OnBoardScreen(),
    ),
    GoRoute(
      path: AppRoutes.loginScreen,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
        path: AppRoutes.homeScreen,
        builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: AppRoutes.wallScreen,
      builder: (context, state) => const WallScreen(),
    ),
  ],
);

abstract class AppRoutes {
  static const onBoardScreen = '/';
  static const loginScreen = '/login';
  static const homeScreen = '/home';
  static const wallScreen = '/wall';
}
