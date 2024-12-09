import '../../model/user_model.dart';

class ProfileState {
  final bool isLoading;
  final String error;
  final UserModel? userProfile;

  const ProfileState({
    this.isLoading = false,
    this.error = '',
    this.userProfile,
  });

  ProfileState copyWith({
    bool? isLoading,
    String? error,
    UserModel? userProfile,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}
