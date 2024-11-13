import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nist_tes/app/config/size_config.dart';
import 'package:nist_tes/app/const/app_assets.dart';
import 'package:nist_tes/app/const/app_colors.dart';
import 'package:nist_tes/app/const/app_styles.dart';
import 'package:nist_tes/core/model/teacher_model.dart';
import 'package:nist_tes/core/notifiers/teacher_notifier.dart';
import 'package:nist_tes/presentation/screens/home_screen/widgets/view_all_button.dart';
import 'package:provider/provider.dart';

import '../../widgets/appbar/home_appbar.dart';
import '../../widgets/shimmers/teacher_card_shimmer.dart';

class CollegeWallSection extends StatelessWidget {
  const CollegeWallSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(AppAssets.collegeLogo, width: 40, height: 40),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NIST College',
                      style: AppStyles.cardBodyTitle,
                    ),
                    Text(
                      '2 hours ago',
                      style: AppStyles.cardBodySubtitle,
                    ),
                  ],
                ),
              ],
            ),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ligula tellus, sodales sit amet malesuada ut, iaculis at purus. Ut turpis  iaculis .....',
              style: AppStyles.bodyDark,
            ),
            const SizedBox(height: 12),
            Image.asset(
              AppAssets.onboardGirl,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Chip(
                  backgroundColor: Colors.white,
                  label: const Text(
                    '210',
                    style: AppStyles.bodyDark,
                  ),
                  avatar: const Icon(
                    FontAwesome.thumbs_up,
                    color: AppColors.primaryColor,
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                const SizedBox(width: 12),
                // Chip(
                //   backgroundColor: Colors.white,
                //   label: const Text('210', style: AppStyles.bodyDark),
                //   avatar: const Icon(FontAwesome.commenting,
                //       color: AppColors.primaryColor),
                //   shape: RoundedRectangleBorder(
                //     side: const BorderSide(color: Colors.grey),
                //     borderRadius: BorderRadius.circular(24),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const HomeAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TeachersSection(),
                    const SizedBox(height: 16),
                    SectionTitle(
                      title: 'College Wall',
                      onViewAll: () {
                        // View all college wall posts action
                      },
                    ),
                    const CollegeWallSection(),
                    SectionTitle(
                      title: 'Notice Updates',
                      onViewAll: () {
                        // View all notice updates action
                      },
                    ),
                    const SizedBox(height: 16),
                    const NoticeUpdatesSection(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class NoticeUpdateCard extends StatelessWidget {
  final String title;
  final String date;

  const NoticeUpdateCard({
    super.key,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.campaign, color: AppColors.primaryColor),
        ),
        title: Text(
          title,
          style: AppStyles.cardBodyTitle,
        ),
        subtitle: Text(
          date,
          style: AppStyles.cardBodySubtitle,
        ),
        trailing: SizedBox(
          width: SizeConfig.screenWidth * 0.22,
          child: ViewAllButton(
            text: 'View',
            onPressed: () {
              // View notice update action
            },
          ),
        ),
      ),
    );
  }
}

class NoticeUpdatesSection extends StatelessWidget {
  const NoticeUpdatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        NoticeUpdateCard(
          title: 'Exam form opened',
          date: 'Tuesday Jan 2024',
        ),
        NoticeUpdateCard(
          title: 'Exam form opened',
          date: 'Tuesday Jan 2024',
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const SectionTitle({
    super.key,
    required this.title,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppStyles.cardTitle),
        ViewAllButton(
          text: 'View All',
          onPressed: onViewAll,
        ),
      ],
    );
  }
}

class TeacherCard extends StatelessWidget {
  final TeacherModel teacherModel;
  const TeacherCard({super.key, required this.teacherModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: SizeConfig.screenWidth * 0.5,
        child: ListTile(
          contentPadding: const EdgeInsets.all(4),
          leading: CircleAvatar(
            backgroundImage: teacherModel.user.avatar != null
                ? NetworkImage(teacherModel.user.avatar!)
                : const NetworkImage(
                    'https://www.pngfind.com/pngs/m/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.png'),
            radius: 24,
          ),
          title: Text(
            teacherModel.user.name,
            style: AppStyles.cardBodyTitle,
          ),
          subtitle: Text(
            teacherModel.subjects?.first.name ?? "N/A",
            style: AppStyles.cardBodySubtitle,
          ),
        ));
  }
}

class TeacherInfo extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String subject;

  const TeacherInfo({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          radius: 30,
        ),
        const SizedBox(height: 8),
        Text(name),
        Text(subject),
      ],
    );
  }
}

class TeachersSection extends StatelessWidget {
  const TeachersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Teachers", style: AppStyles.titleLight),
              ViewAllButton(
                text: 'View All',
                onPressed: () {},
              ),
            ],
          ),
          Consumer<TeacherNotifier>(builder: (context, notifier, child) {
            if (notifier.isLoading.value) {
              return const ShimmerTeacherCard();
            }

            return SizedBox(
              height: SizeConfig.heightMultiplier * 8,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: notifier.teacherList.length,
                itemBuilder: (BuildContext context, int index) {
                  return TeacherCard(
                    teacherModel: notifier.teacherList[index],
                  );
                },
              ),
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
