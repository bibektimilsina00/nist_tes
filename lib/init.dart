import 'package:flutter/material.dart';
import 'package:nist_tes/core/services/service_locator.dart';

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator().initialize();
}
