class OnboardingData {
  final String title;
  final String description;
  final String iconIdentifier;

  const OnboardingData({
    required this.title,
    required this.description,
    required this.iconIdentifier,
  });

  static const List<OnboardingData> pages = [
    OnboardingData(
      title: 'PRECISION',
      description:
          'Capture your thoughts with pixel-perfect clarity. Every note has its place.',
      iconIdentifier: '🎯',
    ),
    OnboardingData(
      title: 'VELOCITY',
      description:
          'Synchronize across all your devices at hyper-speed. Never miss a beat.',
      iconIdentifier: '⚡',
    ),
    OnboardingData(
      title: 'INTELLIGENCE',
      description: 'Tachyon-5 learns your workflow and anticipates your needs.',
      iconIdentifier: '🧠',
    ),
  ];
}
