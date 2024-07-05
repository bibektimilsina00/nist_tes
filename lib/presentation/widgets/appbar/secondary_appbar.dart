import 'package:flutter/material.dart';

import '../../../app/config/size_config.dart';

class SecondaryAppBar extends StatelessWidget {
  const SecondaryAppBar({
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
      toolbarHeight: SizeConfig.heightMultiplier * 14,
      flexibleSpace: const FlexibleSpaceBar(
        background: Padding(
          padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRepSpTHS0O1o4G9umZ2gMu2PFOQF23j6JashpqGRrHkmOBcRyMuT5PAdruM1RzVhIaWmI&usqp=CAU'), // Update with your image path
                  radius: 28,
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Good Morning, 👋'),
                    Text('Emma Watson | BSC. CSIT 2nd',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        )),
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
