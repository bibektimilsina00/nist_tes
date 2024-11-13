import 'package:flutter/material.dart';
import 'package:nist_tes/app/const/app_colors.dart';

import '../../widgets/text_field/primary_text_field.dart';

class FillProfileScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FillProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            title: Text("Your Profile"),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.amber,
                            backgroundImage: NetworkImage(
                                'https://picsum.photos/250?image=9'),
                            radius: 50,
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  )),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle("Full Name"),
                        PrimaryTextField(
                          hintText: "Full Name",
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Name is required';
                            }
                            return null;
                          },
                          onEditingComplete: () =>
                              _formKey.currentState!.validate(),
                        ),
                        _buildSectionTitle("Gender"),
                        PrimaryTextField(
                          hintText: 'Gender',
                          trailing: const Icon(Icons.arrow_drop_down,
                              color: Colors.grey),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Gender is required";
                            }
                            return null;
                          },
                          onEditingComplete: () =>
                              _formKey.currentState!.validate(),
                        ),
                        _buildSectionTitle("DOB"),
                        PrimaryTextField(
                          hintText: 'Date of Birth',
                          trailing:
                              const Icon(Icons.date_range, color: Colors.grey),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Date of birth is required";
                            }
                            return null;
                          },
                          onEditingComplete: () =>
                              _formKey.currentState!.validate(),
                        ),
                        _buildSectionTitle("Location"),
                        PrimaryTextField(
                            hintText: 'Location',
                            trailing: const Icon(Icons.location_on,
                                color: Colors.grey),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Location is required";
                              }
                              return null;
                            },
                            onEditingComplete: () =>
                                _formKey.currentState!.validate()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 20, bottom: 8),
      child: Text(
        title,
      ),
    );
  }
}
