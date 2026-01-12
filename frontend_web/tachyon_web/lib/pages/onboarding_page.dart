import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr_router/jaspr_router.dart';

class OnboardingPage extends StatefulComponent {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();

  @css
  static List<StyleRule> get styles => [
    css('.icon-container').styles(
      margin: .only(bottom: 40.px),
    ),
    css('.onboarding-icon').styles(
      fontSize: 80.px,
    ),
    css('.onboarding-description').styles(
      margin: .symmetric(vertical: 24.px),
    ),
    css('.page-indicator').styles(
      display: .flex,
      justifyContent: .center,
      margin: .only(bottom: 32.px),
    ),
    css('.indicator').styles(
      width: 8.px,
      height: 8.px,
      margin: .symmetric(horizontal: 4.px),
      backgroundColor: Color('#E2E8F0').withOpacity(0.2),
      radius: .circular(4.px),
    ),
    css('.indicator.active').styles(
      width: 24.px,
      backgroundColor: Color('#00D4FF'),
    ),
  ];
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'PRECISION',
      description: 'Capture your thoughts with pixel-perfect clarity. Every note has its place.',
      icon: '🎯',
    ),
    OnboardingData(
      title: 'VELOCITY',
      description: 'Synchronize across all your devices at hyper-speed. Never miss a beat.',
      icon: '⚡',
    ),
    OnboardingData(
      title: 'INTELLIGENCE',
      description: 'Tachyon-5 learns your workflow and anticipates your needs.',
      icon: '🧠',
    ),
  ];

  @override
  Component build(BuildContext context) {
    final page = _pages[_currentPage];

    return div(classes: 'auth-container', [
      div(classes: 'icon-container', [
        span(classes: 'onboarding-icon', [text(page.icon)]),
      ]),
      h1([text(page.title)]),
      p(classes: 'onboarding-description', [text(page.description)]),

      div(classes: 'page-indicator', [
        for (var i = 0; i < _pages.length; i++) div(classes: 'indicator ${i == _currentPage ? 'active' : ''}', []),
      ]),

      button(
        classes: 'atlantis-button',
        onClick: () {
          if (_currentPage < _pages.length - 1) {
            setState(() => _currentPage++);
          } else {
            Router.of(context).push('/');
          }
        },
        [text(_currentPage == _pages.length - 1 ? 'Get Started' : 'Next')],
      ),
    ]);
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String icon;

  OnboardingData({required this.title, required this.description, required this.icon});
}
