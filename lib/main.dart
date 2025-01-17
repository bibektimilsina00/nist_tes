import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:nist_tes/app/providers/app_providers.dart';
import 'package:nist_tes/init.dart';
import 'package:provider/provider.dart';

import 'app/config/size_config.dart';
import 'app/const/app_constant.dart';
import 'app/enum/enum.dart';
import 'app/routes/app_routes.dart';
import 'core/notifiers/theme/theme_notifier.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiProvider(
      providers: AppProvider.providers,
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppConst.appname,
            routerConfig: router,
            theme: FlexThemeData.light(scheme: FlexScheme.brandBlue),
            darkTheme: FlexThemeData.dark(scheme: FlexScheme.brandBlue),
            themeMode: switch (themeNotifier.themeMode) {
              AppThemeMode.light => ThemeMode.light,
              AppThemeMode.dark => ThemeMode.dark,
              AppThemeMode.system => ThemeMode.system,
            },
          );
        },
      ),
    );
  }
}
