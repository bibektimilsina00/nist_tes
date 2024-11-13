import 'package:flutter/material.dart';
import 'package:nist_tes/app/const/app_styles.dart';
import 'package:nist_tes/core/model/user_model.dart';
import 'package:nist_tes/core/notifiers/profile_notifier.dart';
import 'package:provider/provider.dart';

import '../../../app/config/size_config.dart';
import '../shimmers/home_app_bar_shimmer.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      toolbarHeight: SizeConfig.heightMultiplier * 10,
      flexibleSpace: FlexibleSpaceBar(
        background:
            Consumer<ProfileNotifier>(builder: (context, notifier, child) {
          return notifier.isLoading.value || notifier.userProfile == null
              ? const HomeAppBarShimmer()
              : HomeAppBarContent(
                  userModel: notifier.userProfile!,
                );
        }),
      ),
    );
  }
}

class HomeAppBarContent extends StatelessWidget {
  final UserModel userModel;
  const HomeAppBarContent({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: userModel.avatar != null
                  ? NetworkImage(userModel.avatar!)
                  : const NetworkImage(
                      'https://www.pngfind.com/pngs/m/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.png'), // Update with your image path
              radius: 28,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Good Morning, 👋',
                  style: AppStyles.appBarSubtitle,
                ),
                Text(
                    '${userModel.name} | ${userModel.student?.section.classModel?.faculty?.name} ${userModel.student?.section.classModel?.name}',
                    style: AppStyles.appBarTitle),
              ],
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.notifications, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
