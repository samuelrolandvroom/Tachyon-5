import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:tachyon_core/tachyon_core.dart';

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
      backgroundColor: Color(TachyonColors.hexLanteanSilver).withOpacity(0.2),
      radius: .circular(4.px),
    ),
    css('.indicator.active').styles(
      width: 24.px,
      backgroundColor: Color(TachyonColors.hexAtlantisBlue),
    ),
  ];
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;

  @override
  Component build(BuildContext context) {
    final page = OnboardingData.pages[_currentPage];

    return div(classes: 'auth-container', [
      div(classes: 'icon-container', [
        span(classes: 'onboarding-icon', [text(page.iconIdentifier)]),
      ]),
      h1([text(page.title)]),
      p(classes: 'onboarding-description', [text(page.description)]),

      div(classes: 'page-indicator', [
        for (var i = 0; i < OnboardingData.pages.length; i++)
          div(classes: 'indicator ${i == _currentPage ? 'active' : ''}', []),
      ]),

      button(
        classes: 'atlantis-button',
        onClick: () {
          if (_currentPage < OnboardingData.pages.length - 1) {
            setState(() => _currentPage++);
          } else {
            Router.of(context).push('/');
          }
        },
        [text(_currentPage == OnboardingData.pages.length - 1 ? 'Get Started' : 'Next')],
      ),
    ]);
  }
}
