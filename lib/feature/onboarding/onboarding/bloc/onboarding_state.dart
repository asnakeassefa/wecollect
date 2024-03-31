// bloc state for Onboarding

sealed class OnboardingState {}

class OnboardingInit extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingLoaded extends OnboardingState {}

class OnboardingStarted extends OnboardingState {}

class UserAuthenticated extends OnboardingState {}

class OnboardingError extends OnboardingState {
  final String error;
  OnboardingError({required this.error});
}
