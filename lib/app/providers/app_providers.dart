import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../core/notifiers/auth_notifier.dart';
import '../api_client/api_client.dart';

class AppProvider {
  static List<SingleChildWidget> providers = [
     ChangeNotifierProvider(
        create: (context) => AuthenticationNotifier(
            Provider.of<ApiClient>(context, listen: false))),
  ];
}
