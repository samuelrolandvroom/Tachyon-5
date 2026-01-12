import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

class OnboardingPage extends StatefulComponent {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
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
  Iterable<Component> build(BuildContext context) sync* {
    final page = _pages[_currentPage];

    yield div(classes: 'auth-container', [
      div(styles: Styles.combine([Styles.box(margin: EdgeInsets.only(bottom: 40.px))]), [
        span(styles: Styles.text(fontSize: 80.px), [text(page.icon)]),
      ]),
      h1([text(page.title)]),
      p(styles: Styles.box(margin: EdgeInsets.symmetric(vertical: 24.px)), [text(page.description)]),

      div(
        styles: Styles.combine([
          Styles.flexbox(justifyContent: JustifyContent.center),
          Styles.box(margin: EdgeInsets.only(bottom: 32.px)),
        ]),
        [
          for (var i = 0; i < _pages.length; i++)
            div(
              styles: Styles.combine([
                Styles.box(
                  width: i == _currentPage ? 24.px : 8.px,
                  height: 8.px,
                  margin: EdgeInsets.symmetric(horizontal: 4.px),
                ),
                Styles.background(
                  color: i == _currentPage ? Color.hex('#00D4FF') : Color.hex('#E2E8F0').withOpacity(0.2),
                ),
                Styles.border(radius: BorderRadius.circular(4.px)),
              ]),
              [],
            ),
        ],
      ),

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
