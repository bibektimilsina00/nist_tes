import 'package:flutter/material.dart';
import 'package:nist_tes/app/const/app_styles.dart';

import '../../../app/config/size_config.dart';

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
      flexibleSpace: const FlexibleSpaceBar(
        background: Padding(
          padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg'), // Update with your image path
                  radius: 28,
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Good Morning, 👋',
                      style: AppStyles.appBarSubtitle,
                    ),
                    Text('Nirgun Subedi | BSC. CSIT 5th',
                        style: AppStyles.appBarTitle),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.notifications, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
