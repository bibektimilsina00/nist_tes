import 'package:flutter/material.dart';
import 'package:nist_tes/app/const/app_colors.dart';
import 'package:nist_tes/app/const/app_styles.dart';
import 'package:nist_tes/presentation/widgets/dimention_widget.dart';

class TeacherDetailCard extends StatelessWidget {
  const TeacherDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRepSpTHS0O1o4G9umZ2gMu2PFOQF23j6JashpqGRrHkmOBcRyMuT5PAdruM1RzVhIaWmI&usqp=CAU'),
              radius: 24,
              backgroundColor: Colors.grey,
            ),
            hSizedBox1,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Mensun Lakhemaru',
                        style: AppStyles.cardBodyTitle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      const WidgetSpan(
                        child: SizedBox(
                            width:
                                8), // Space between the name and the microprocessor label
                      ),
                      const TextSpan(
                        text: 'Microprocessor',
                        style: AppStyles.cardBodySubtitle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const TeacherInfoItem(
                  icon: Icon(
                    Icons.email,
                    color: AppColors.primaryColor,
                    size: 14,
                  ),
                  text: "mensun.lakhamaru11@gmail.com",
                ),
                const SizedBox(height: 4),
                const TeacherInfoItem(
                  icon: Icon(
                    Icons.phone,
                    color: AppColors.primaryColor,
                    size: 14,
                  ),
                  text: "+977 - 9876543210",
                ),
                const SizedBox(height: 4),
                const TeacherInfoItem(
                  icon: Icon(
                    Icons.location_pin,
                    color: AppColors.primaryColor,
                    size: 14,
                  ),
                  text: "Bhaktapur , chyamasingh",
                ),
              ],
            ),
            hSizedBox1,
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.iconBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TeacherInfoItem extends StatelessWidget {
  final Widget icon;
  final String text;
  const TeacherInfoItem({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 4),
        Text(
          text,
          style: AppStyles.cardBodyTitle.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
