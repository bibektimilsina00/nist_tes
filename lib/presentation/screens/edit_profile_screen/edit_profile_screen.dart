import 'dart:io';

import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _selectedImagePath;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                      theme.colorScheme.surfaceContainerHighest
                          .withOpacity(0.5),
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
                      Stack(
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
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: _selectedImagePath != null
                                  ? FileImage(File(_selectedImagePath!))
                                  : const NetworkImage(
                                          'https://picsum.photos/200')
                                      as ImageProvider,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: MaterialButton(
                              onPressed: _pickImage,
                              color: theme.colorScheme.primary,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(12),
                              child: Icon(
                                Icons.camera_alt,
                                color: theme.colorScheme.onPrimary,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildSection(
                      title: 'Basic Information',
                      icon: Icons.person_outline,
                      children: [
                        _buildTextField(
                          label: 'Full Name',
                          prefixIcon: Icons.person_outline,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          theme: theme,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          label: 'Phone Number',
                          prefixIcon: Icons.phone_outlined,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                          theme: theme,
                        ),
                      ],
                      theme: theme,
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: 'Address Information',
                      icon: Icons.location_on_outlined,
                      children: [
                        _buildTextField(
                          label: 'Address',
                          prefixIcon: Icons.home_outlined,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                          theme: theme,
                        ),
                      ],
                      theme: theme,
                    ),
                    const SizedBox(height: 32),
                    FilledButton(
                      onPressed: _isLoading ? null : _handleSubmit,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: _isLoading
                          ? SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: theme.colorScheme.onPrimary,
                              ),
                            )
                          : Text(
                              'Save Changes',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData prefixIcon,
    required String? Function(String?)? validator,
    required ThemeData theme,
  }) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.outlineVariant.withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      // Implement save functionality

      await Future.delayed(const Duration(seconds: 2)); // Simulated API call

      setState(() => _isLoading = false);

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  Future<void> _pickImage() async {
    // Implement image picker functionality
  }
}
