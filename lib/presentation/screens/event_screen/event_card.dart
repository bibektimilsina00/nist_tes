import 'package:flutter/material.dart';
import 'package:nist_tes/app/const/app_colors.dart';
import 'package:nist_tes/app/const/app_styles.dart';
import 'package:nist_tes/presentation/widgets/dimention_widget.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: ListTile(
        title:
            const Text('Basketball Tournament', style: AppStyles.cardBodyTitle),
        subtitle:
            const Text('Basketball Court', style: AppStyles.cardBodySubtitle),
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.iconBackground,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '21',
                style: AppStyles.titleDark.copyWith(
                  fontSize: 16,
                  color: Colors.purple,
                ),
              ),
              hSizedBox1,
              const Text("Fav", style: TextStyle(color: Colors.purple)),
            ],
          ),
        ),
        trailing: const SizedBox(
          child: Text('5 days to go', style: AppStyles.primaryColorText),
        ),
      ),
    );
  }
}
