import 'package:flutter/material.dart';
import 'package:nist_tes/app/providers/app_providers.dart';
import 'package:nist_tes/init.dart';
import 'package:provider/provider.dart';

import 'app/config/size_config.dart';
import 'app/const/app_constant.dart';
import 'app/const/app_theme.dart';
import 'app/routes/app_routes.dart';

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
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: AppConst.appname,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.lightTheme,
        routerConfig: router,
      ),
    );
  }
}
