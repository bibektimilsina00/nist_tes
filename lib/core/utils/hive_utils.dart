// import 'package:hive_flutter/hive_flutter.dart';

// import '../model/user_model.dart';

// class HiveUtil {
//   static const String _userBoxName = 'userBox';
//   static const String _userKey = 'userProfile';

//   static UserModel? getUserProfile() {
//     final userBox = Hive.box<UserModel>(_userBoxName);
//     return userBox.get(_userKey);
//   }

//   static Future<void> initHive() async {
//     await Hive.initFlutter();
//     Hive.registerAdapter(UserModelAdapter());
//     await Hive.openBox<UserModel>(_userBoxName);
//   }

//   static Future<void> storeUserProfile(UserModel userModel) async {
//     final userBox = Hive.box<UserModel>(_userBoxName);
//     await userBox.put(_userKey, userModel);
//   }
// }
