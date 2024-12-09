import 'package:nist_tes/core/notifiers/college_wall/wall_notifier.dart';
import 'package:nist_tes/core/notifiers/event/event_notifier.dart';
import 'package:nist_tes/core/notifiers/profile/profile_notifier.dart';
import 'package:nist_tes/core/notifiers/routine/routine_notifier.dart';
import 'package:nist_tes/core/notifiers/teacher/teacher_notifier.dart';
import 'package:nist_tes/core/notifiers/theme/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../core/notifiers/auth/auth_notifier.dart';
import '../../core/notifiers/subject/subject_notifier.dart';

class AppProvider {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => AuthenticationNotifier()),
    ChangeNotifierProvider(create: (context) => ProfileNotifier()),
    ChangeNotifierProvider(create: (context) => TeacherNotifier()),
    ChangeNotifierProvider(create: (context) => SubjectNotifier()),
    ChangeNotifierProvider(create: (context) => RoutineNotifier()),
    ChangeNotifierProvider(create: (context) => WallNotifier()),
    ChangeNotifierProvider(create: (context) => EventNotifier()),
    ChangeNotifierProvider(create: (context) => ThemeNotifier()),
  ];
}
