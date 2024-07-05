import 'package:flutter/material.dart';

import 'app/config/size_config.dart';
import 'app/const/app_constant.dart';
import 'app/const/app_theme.dart';
import 'app/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConst.appname,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
