import 'package:nist_tes/core/notifiers/profile_notifier.dart';
import 'package:nist_tes/core/notifiers/routine_notifier.dart';
import 'package:nist_tes/core/notifiers/teacher_notifier.dart';
import 'package:nist_tes/core/notifiers/wall_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../core/notifiers/auth_notifier.dart';
import '../../core/notifiers/subject_notifier.dart';
import '../../core/services/cache_service.dart';
import '../../core/services/connectivity_service.dart';
import '../api_client/api_client.dart';

class AppProvider {
  static List<SingleChildWidget> providers = [
    Provider<ApiClient>(create: (_) => ApiClient()),
    Provider<ConnectivityService>(create: (_) => ConnectivityService()),
    Provider<CacheService>(create: (_) => CacheService()),
    ChangeNotifierProvider(
        create: (context) => AuthenticationNotifier(
            Provider.of<ApiClient>(context, listen: false))),
    ChangeNotifierProvider(
        create: (context) => ProfileNotifier(
              Provider.of<ApiClient>(context, listen: false),
              Provider.of<ConnectivityService>(context, listen: false),
              Provider.of<CacheService>(context, listen: false),
            )),
    ChangeNotifierProvider<TeacherNotifier>(
        create: (context) => TeacherNotifier(
              Provider.of<ApiClient>(context, listen: false),
              Provider.of<ConnectivityService>(context, listen: false),
              Provider.of<CacheService>(context, listen: false),
            )),
    ChangeNotifierProvider(
      create: (context) => SubjectNotifier(
        Provider.of<ApiClient>(context, listen: false),
        Provider.of<ConnectivityService>(context, listen: false),
        Provider.of<CacheService>(context, listen: false),
      ),
    ),
    ChangeNotifierProvider<RoutineNotifier>(
      create: (context) => RoutineNotifier(
        Provider.of<ApiClient>(context, listen: false),
        Provider.of<ConnectivityService>(context, listen: false),
        Provider.of<CacheService>(context, listen: false),
      ),
    ),
    ChangeNotifierProvider<WallNotifier>(
      create: (context) => WallNotifier(
        Provider.of<ApiClient>(context, listen: false),
        Provider.of<ConnectivityService>(context, listen: false),
        Provider.of<CacheService>(context, listen: false),
      ),
    )
  ];
}
