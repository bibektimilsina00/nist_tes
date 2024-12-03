import 'package:flutter/material.dart';

class InfoItem {
  final String label;
  final String value;

  const InfoItem({required this.label, required this.value});
}

class UserPersonalInfoScreen extends StatelessWidget {
  const UserPersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Information',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.surface,
                    theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary.withOpacity(0.5),
                            theme.colorScheme.primary.withOpacity(0.2),
                          ],
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          'https://picsum.photos/200',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'John Doe',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Computer Engineering',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildInfoSection(
                    title: 'Personal Information',
                    items: [
                      const InfoItem(label: 'Full Name', value: 'John Doe'),
                      const InfoItem(
                          label: 'Email', value: 'john.doe@email.com'),
                      const InfoItem(label: 'Phone', value: '+977 9876543210'),
                      const InfoItem(
                          label: 'Address', value: 'Kathmandu, Nepal'),
                    ],
                    icon: Icons.person_outline,
                    theme: theme,
                  ),
                  const SizedBox(height: 20),
                  _buildInfoSection(
                    title: 'Academic Information',
                    items: [
                      const InfoItem(label: 'Roll Number', value: '076BCT099'),
                      const InfoItem(label: 'Batch', value: '2076'),
                      const InfoItem(
                          label: 'Faculty', value: 'Computer Engineering'),
                      const InfoItem(label: 'Semester', value: '6th Semester'),
                    ],
                    icon: Icons.school_outlined,
                    theme: theme,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required List<InfoItem> items,
    required IconData icon,
    required ThemeData theme,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.surface,
            theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => Divider(
              color: theme.colorScheme.outlineVariant.withOpacity(0.5),
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        items[index].label,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Text(
                      items[index].value,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
