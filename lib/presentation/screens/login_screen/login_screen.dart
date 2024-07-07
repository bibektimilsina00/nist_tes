import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nist_tes/app/config/size_config.dart';
import 'package:nist_tes/app/const/app_assets.dart';
import 'package:nist_tes/app/const/app_colors.dart';
import 'package:nist_tes/app/const/app_styles.dart';
import 'package:nist_tes/app/routes/app_routes.dart';
import 'package:nist_tes/core/notifiers/auth_notifier.dart';
import 'package:nist_tes/presentation/widgets/buttons/primary_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {



  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String userEmail = '';
  String userPassword = '';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: SizeConfig.blockSizeVertical * 10),
              Image.asset(AppAssets.collegeLogo,
                  height: SizeConfig.blockSizeVertical * 15),
              SizedBox(height: SizeConfig.blockSizeVertical * 5),
              Text(
                'Welcome Back!',
                style: AppStyles.titleDark
                    .copyWith(fontSize: 28, color: AppColors.primaryColor),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 1),
              Text(
                'Please sign in to continue',
                style: AppStyles.bodyDark
                    .copyWith(color: AppColors.textDark, fontSize: 16),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 5),
              _buildTextField(context, 'Email', false),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              _buildTextField(context, 'Password', true),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Add your forgot password logic here
                  },
                  child: const Text('Forgot Password?',
                      style: TextStyle(color: AppColors.primaryColor)),
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 4),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  ontap: () async{
                    try {
                     await context.read<AuthenticationNotifier>().userLogin(userEmail: _emailController.text.trim(), userPassword: _passwordController.text);
                      context.go(AppRoutes.homeScreen);
                    } catch (e) {

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                        ),
                      );
                      
                    }
                  },
                  text: 'Sign In',
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label, bool isPassword) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.primaryColor),
        fillColor: AppColors.inputFillLight,
        filled: true,
        border: AppStyles.inputBorder(AppColors.inputBorderLight),
        enabledBorder: AppStyles.inputBorder(AppColors.inputBorderLight),
        focusedBorder: AppStyles.inputBorder(AppColors.primaryColor),
      ),
      style: const TextStyle(color: AppColors.textDark),
    );
  }
}
